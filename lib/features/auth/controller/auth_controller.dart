import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_clone/apis/auth_api.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authAPIProvider);
  return AuthController(authAPI: authApi);
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authApi;
  AuthController({
    required AuthAPI authAPI,
  })  : _authApi = authAPI,
        super(false);

  void signUp({
    required String email,
    required String password,
    required BuildContext context, // to test controller (remove) build context
  }) async {
    try {
      // set loading state to true
      state = true;
      final result = await _authApi.signUp(email: email, password: password);

      state = false;

      result.fold(
        (l) => Fluttertoast.showToast(
          msg: l.message,
          backgroundColor: Colors.red,
        ),
        (r) => print(r.email),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: '$e:  Unavailable');
    }
  }
}
