import 'package:amc_man_app/src/constants.dart';
import 'package:amc_man_app/src/ui/components/text_formField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgetPassDialog extends StatelessWidget {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ForgetPassDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> onPressed() async {
      if (!_formKey.currentState!.validate()) return;

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text);
      } on FirebaseAuthException catch (e) {
        SnackBar(
          content: Text(e.message.toString()),
        );
        return Future.error(e);
      } catch (e) {
        SnackBar(content: Text(e.toString()));
        return Future.error(e);
      }

      const SnackBar(content: Text('Password reset mail sent successfully'));

      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text('Forgot Password'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            CustomTextFormField(
              fieldController: _emailController,
              hintText: 'Enter registered email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              validator: (value) =>
                  value!.isEmpty ? 'This cannot be empty' : '',
              labelText: 'Email',
              prefixIcon: Icons.email,
              semanticsLabel: 'Registered email',
            ),
            const SizedBox(height: 20.0),
            const Text(
              'A link will be sent to your registered email Id. Click on the link to reset your password',
            ),
            const SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                final Uri url = 'mailto:$kSupportEmail' as Uri;
                await launchUrl(url);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.zero),
              ),
              child: const Text('Trouble signing in? Contact Us'),
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
          onPressed: onPressed,
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }
}
