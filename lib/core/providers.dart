import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';

final endpointProvider = Provider<String>((ref) {
  return AppWriteConstants.getEndpoint(); // Call the getEndpoint function here
});

final appwriteClientProvider = Provider((ref) {
  final endpoint =
      ref.watch(endpointProvider); // Read the endpoint from the custom provider
  Client client = Client();
  return client
      .setEndpoint(endpoint)
      .setProject(AppWriteConstants.projectID)
      .setSelfSigned(status: true);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});

final appwriteStorageProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Storage(client);
});

final appwriteRealtimeProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Realtime(client);
});
