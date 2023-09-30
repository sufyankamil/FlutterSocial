import 'package:flutter/material.dart';
import 'package:twitter_clone/theme/pallete.dart';

class AuthField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator; // Validation function
  // bool obscureText;

  const AuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.labelText,
    // this.obscureText = false,
  }) : super(key: key);

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool obscureText = true; // Separate obscureText for each AuthField

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.blueColor,
            width: 3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.greyColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(22),
        hintText: widget.hintText,
        // label: Text(labelText),
        hintStyle: const TextStyle(
          fontSize: 18,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.redColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Pallete.redColor,
          ),
        ),
        // suffixIcon: AuthFieldSuffixIcon(
        //   obscureText: obscureText,
        //   toggleVisibility: () {
        //     setState(() {
        //       obscureText = !obscureText;
        //     });
        //   },
        // ),
      ),
    );
  }
}

class AuthFieldSuffixIcon extends StatelessWidget {
  final bool obscureText;
  final VoidCallback toggleVisibility;

  AuthFieldSuffixIcon({
    required this.obscureText,
    required this.toggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        obscureText ? Icons.visibility_off : Icons.visibility,
        color: Colors.grey,
      ),
      onPressed: toggleVisibility,
    );
  }
}
