import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/features/auth/view/login.dart';
import 'package:appwrite/models.dart' as model;
import 'package:twitter_clone/features/home/view/homepage.dart';

import '../../../core/utils.dart';
import '../../../models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authAPIProvider);
  return AuthController(
      authAPI: authApi,
      userAPI: ref.watch(
        userAPIProvider,
      ));
});

final currentUserAccountProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.currentUser();
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authApi;

  final UserAPI _userAPI;

  AuthController({
    required AuthAPI authAPI,
    required UserAPI userAPI,
  })  : _authApi = authAPI,
        _userAPI = userAPI,
        super(false);

  Future<model.User?> currentUser() => _authApi.currentUserAccount();

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
              ), (r) async {
        UserModel userModel = UserModel(
          email: email,
          name: getNameFromEmail(email),
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          // uid: r.$id,
          uid: '',
          bio: '',
          isTwitterBlue: false,
        );
        final res2 = await _userAPI.saveUserData(userModel);
        res2.fold(
          (l) {
            Fluttertoast.showToast(
              msg: l.message,
              backgroundColor: Colors.red,
            );
          },
          (r) {
            Fluttertoast.showToast(
              msg: 'Account created! Login to account',
              backgroundColor: Colors.green,
            );
            Navigator.push(
              context,
              Login.route(),
            );
            // showSnackBar(context, 'Accounted created! Please login.');
            // Navigator.push(context, LoginView.route());
          },
        );
      });
    } catch (e) {
      Fluttertoast.showToast(msg: '$e:  Unavailable');
    }
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      // set loading state to true
      state = true;
      final result = await _authApi.login(email: email, password: password);

      state = false;

      result.fold(
          (l) => Fluttertoast.showToast(
                msg: l.message,
                backgroundColor: Colors.red,
              ), (r) {
        Navigator.push(
          context,
          Homepage.route(),
        );
      });
    } catch (e) {
      Fluttertoast.showToast(msg: '$e:  Unavailable');
    }
  }
}
