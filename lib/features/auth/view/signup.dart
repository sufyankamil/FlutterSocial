import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/features/auth/view/login.dart';
import 'package:validators/validators.dart';

import '../../../common/common_button.dart';
import '../../../constants/ui_constants.dart';
import '../../../theme/pallete.dart';
import '../widgets/common_textfield.dart';

class Signup extends StatefulWidget {
  // Route for the signup
  static route() => MaterialPageRoute(
        builder: (context) => const Signup(),
      );

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // instance of appbar to the whenever the state changes appbar would not be reloaded
  final appbar = UIConstants.appBar();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create an account.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  AuthField(
                    // obscureText: false,
                    controller: emailController,
                    hintText: 'Enter your email address',
                    labelText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!isEmail(value)) {
                        return 'Invalid email format';
                      }
                      return null; // Return null for no validation error
                    },
                  ),
                  const SizedBox(height: 30),
                  AuthField(
                      // obscureText: true,
                      controller: passwordController,
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null; // Return null for no validation error
                      }),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.topRight,
                    child: RoundedSmallButton(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform the desired action
                          print(
                              'Form is valid. Email: ${emailController.text}');
                        }
                      },
                      label: 'Done',
                    ),
                  ),
                  const SizedBox(height: 40),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account?",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: ' Login',
                          style: const TextStyle(
                            color: Pallete.blueColor,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                Login.route(),
                              );
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
