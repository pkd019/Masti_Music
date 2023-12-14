import 'dart:async';

import 'package:amc_man_app/src/ui/components/text_formField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'show_progress.dart';
import '../../extensions/snack_bar.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmNewPassController = TextEditingController();
  final _currentPassNode = FocusNode();
  final _newPassNode = FocusNode();
  final _confirmNewPassNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    void onChangePassClick() async {
      if (!_formKey.currentState!.validate()) return;
      try {
        showProgress(context);
        final user = FirebaseAuth.instance.currentUser;

        final credentials = EmailAuthProvider.credential(
          email: user!.email.toString(),
          password: _currentPassController.text,
        );

        final reauthenticate =
            await user.reauthenticateWithCredential(credentials);

        if (reauthenticate.user == null) {
          Navigator.of(context).pop();
          context.showSnackbar(
              'Error authenticating the user. Please login again');
          return;
        }

        await user.updatePassword(_newPassController.text);

        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        Navigator.of(context).pop();
        context.showSnackbar(e.message.toString());
      } on TimeoutException catch (e) {
        Navigator.of(context).pop();
        context.showSnackbar('Timeout Error:${e.message}');
      } catch (e) {
        Navigator.of(context).pop();
        const SnackBar(content: Text(''));
      }
    }

    return AlertDialog(
      title: const Text('Change Password'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20.0),
            CustomTextFormField(
              currentNode: _currentPassNode,
              nextNode: _newPassNode,
              obscureText: false,
              fieldController: _currentPassController,
              hintText: 'Enter current password',
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  value!.isEmpty ? 'This cannot be empty' : ' ',
              labelText: 'Current password',
              prefixIcon: Icons.lock,
              semanticsLabel: 'Current password',
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              currentNode: _newPassNode,
              nextNode: _confirmNewPassNode,
              fieldController: _newPassController,
              obscureText: false,
              hintText: 'Enter New Password',
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              validator: (value) =>
                  value!.isEmpty ? 'This cannot be empty' : ' ',
              prefixIcon: Icons.lock,
              labelText: 'New password',
              semanticsLabel: 'New password',
            ),
            const SizedBox(height: 20.0),
            CustomTextFormField(
              currentNode: _confirmNewPassNode,
              fieldController: _confirmNewPassController,
              obscureText: false,
              hintText: 'Confirm New Password',
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              validator: (confirmPass) {
                if (confirmPass == null || confirmPass.isEmpty) {
                  return 'This cannot be empty';
                } else if (_newPassController.text != confirmPass) {
                  return 'Passwords do not match';
                } else {
                  return '';
                }
              },
              labelText: 'Confirm password',
              prefixIcon: Icons.lock,
              semanticsLabel: 'Confirm new password',
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: onChangePassClick,
          child: const Text('CHANGE PASSWORD'),
        ),
      ],
    );
  }
}
