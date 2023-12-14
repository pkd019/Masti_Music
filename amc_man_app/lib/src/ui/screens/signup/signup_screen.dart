import 'package:amc_man_app/src/route.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login_screen.dart';
import 'bloc/signup_bloc.dart';

import '../../../extensions/snack_bar.dart';
import '../../components/show_progress.dart';
import '../../components/text_formField.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => SignupBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupInProgress) {
          showProgress(context);
        } else if (state is SignupFailure) {
          Navigator.of(context).pop();
          context.showSnackbar(state.message);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: const Alignment(0, -1 / 3),
            curve: Curves.easeInCubic,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(flex: 2),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 50.0),
                        ),
                        const SizedBox(height: 20.0),
                        _NameField(_nameController),
                        const SizedBox(height: 20.0),
                        _EmailField(_emailController),
                        const SizedBox(height: 20.0),
                        _PasswordField(_passwordController),
                        const SizedBox(height: 20.0),
                        _PhoneField(_phoneController),
                        const SizedBox(height: 20.0),
                        _SignupButton(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                          nameController: _nameController,
                          phoneController: _phoneController,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _SignInWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
      textInputAction: TextInputAction.next,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Email',
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField(this.passwordTextController);

  final TextEditingController passwordTextController;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      fieldController: passwordTextController,
      hintText: 'Enter your password',
      labelText: 'Password',
      prefixIcon: Icons.lock,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Password',
      obscureText: true,
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
      hintText: 'Enter your phone number',
      labelText: 'Phone',
      prefixIcon: Icons.phone,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.done,
      validator: (text) => text!.isNotEmpty ? '' : 'This field cannot be empty',
      semanticsLabel: 'Phone number',
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.login, size: 20.0),
            label: const Text('REGISTER'),
            style: ButtonStyle(
              enableFeedback: true,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 15.0)),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<SignupBloc>().add(
                      SignupButtonPressed(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                        phone: phoneController.text,
                      ),
                    );
              }
            },
          ),
        );
      },
    );
  }
}

class _SignInWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: 'Sign In',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(newRoute(const LoginScreen()));
                  },
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          semanticsLabel: 'Sign In',
        ),
      ],
    );
  }
}
