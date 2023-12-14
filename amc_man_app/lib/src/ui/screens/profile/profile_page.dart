import 'package:amc_man_app/src/ui/components/text_formField.dart';
import 'package:flutter/material.dart';

import '../../../global/globals.dart' as global;

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            _ProfileHeader(),
            const Spacer(),
            Expanded(flex: 25, child: _ProfileBody()),
          ],
        ),
      ),
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final _nameController = TextEditingController(text: global.user?.name);
  final _emailController = TextEditingController(text: global.user!.email);
  final _phoneController = TextEditingController(text: global.user!.mobile);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 25.0),
        _NameField(_nameController),
        const SizedBox(height: 25.0),
        _EmailField(_emailController),
        const SizedBox(height: 25.0),
        _PhoneField(_phoneController),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'My Profile',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 54),
          ),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField(this.nameTextController);

  final TextEditingController nameTextController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fieldController: nameTextController,
      hintText: 'Enter your name',
      labelText: 'Name',
      prefixIcon: Icons.person,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Name',
      enabled: false,
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField(this.phoneTextController);

  final TextEditingController phoneTextController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fieldController: phoneTextController,
      hintText: 'Enter phone number',
      labelText: 'Phone',
      prefixIcon: Icons.phone,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Phone',
      enabled: false,
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField(this.emailTextController);

  final TextEditingController emailTextController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fieldController: emailTextController,
      hintText: 'Enter your email',
      labelText: 'Email',
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Email',
      enabled: false,
    );
  }
}
