// abstract class is going to contain all the functions which we will be using in authAPI class

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../core/core.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;

final authAPIProvider = Provider((ref) {
  // return AuthAPI(account: account);
});

// interface for AUTH API class
abstract class IAuthAPI {
  // since we will be getting two types of datatypes in return that is success or failure, we will be using EITHER type
  FutureEither<model.User> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({
    required Account account,
  }) : _account = account;

  @override
  FutureEither<model.User> signUp(
      {required String email, required String password}) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(
            e.message ??
                'Some unexpected error occurred while creating an account',
            stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
