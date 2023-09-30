import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppWriteConstants {
  // static const String databaseID = '6517c8ddd2b5b905409e';
  // static const String projectID = '6517c06ceb995cbcc206';
  // static const String endPoint = 'http://localhost:80/v1';

  static String databaseID =  dotenv.env['DATABASE_ID']!;
  static String projectID = dotenv.env['DATABASE_PROJECT_ID']!;
  static String endPoint = dotenv.env['ENDPOINT_ID']!;


}
