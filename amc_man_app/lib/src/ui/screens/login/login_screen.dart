import 'package:amc_man_app/src/route.dart';
import 'package:amc_man_app/src/ui/components/forget_password.dart';
import 'package:amc_man_app/src/ui/screens/signup/signup_screen.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

import '../../../extensions/snack_bar.dart';
import '../../components/show_progress.dart';
import '../../components/text_formField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginInProgress) {
          showProgress(context);
        } else if (state is LoginFailure) {
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
                          'Welcome',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontSize: 50.0),
                        ),
                        const SizedBox(height: 20.0),
                        _EmailField(_emailController),
                        const SizedBox(height: 20.0),
                        _PasswordField(_passwordController),
                        const SizedBox(height: 20.0),
                        _ForgetPassword(),
                        const SizedBox(height: 20.0),
                        _LoginButton(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: _SignupWidget(),
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
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.go,
      validator: (text) =>
          text!.isNotEmpty ? ' ' : 'This field cannot be empty',
      semanticsLabel: 'Password',
      obscureText: true,
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: 500,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.login, size: 20.0),
            label: const Text('LOGIN'),
            style: ButtonStyle(
              enableFeedback: true,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(vertical: 15.0)),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
                  email: emailController.text,
                  password: passwordController.text,
                ));
              }
            },
          ),
        );
      },
    );
  }
}

class _ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text.rich(
          TextSpan(
            text: 'Forgot Password?',
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                    context: context, builder: (context) => ForgetPassDialog());
              },
          ),
          overflow: TextOverflow.ellipsis,
          semanticsLabel: 'Forget Password',
          softWrap: true,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
        ),
      ],
    );
  }
}

class _SignupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          TextSpan(
            text: 'Don\'t have an account? ',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: 'Sign Up',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(newRoute(const SignUpScreen()));
                  },
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          semanticsLabel: 'Sign Up',
        ),
      ],
    );
  }
}
