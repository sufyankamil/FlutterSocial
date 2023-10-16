import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/models/user_model.dart';

import '../core/providers.dart';

final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(
        appwriteDatabaseProvider),
    // realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI extends IUserAPI {
  final Databases _db;
  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppWriteConstants.databaseID,
        collectionId: AppWriteConstants.usersCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, stacktrace) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          stacktrace,
        ),
      );
    } catch (e, stacktrace) {
      return left(Failure(
        e.toString(),
        stacktrace,
      ));
    }
  }
}
