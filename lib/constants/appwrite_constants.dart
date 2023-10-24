import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

// to make it work in android edit the endpoint id from localhost to ip address
class AppWriteConstants {
  static String databaseID = dotenv.env['DATABASE_ID']!;
  static String projectID = dotenv.env['DATABASE_PROJECT_ID']!;
  static String endPoint = dotenv.env['ENDPOINT_ID']!;
  static String usersCollection = dotenv.env['USER_COLLECTION_ID']!;
  static String tweetsCollection = dotenv.env['TWEET_COLLECTION_ID']!;
  static String imagesBucket = dotenv.env['IMAGES_BUCKET_ID']!;

  static String getEndpoint() {
    if (Platform.isAndroid) {
      return dotenv.env['ANDROID_ENDPOINT_ID']!;
    } else {
      return dotenv.env['ENDPOINT_ID']!;
    }
  }

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectID&mode=admin';
}
