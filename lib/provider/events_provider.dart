import 'package:events_app/data/modules/auth_service.dart';
import 'package:events_app/data/modules/events_api.dart';
import 'package:events_app/models/categories_response_model.dart';
import 'package:events_app/models/event_details_response_model.dart';
import 'package:events_app/utils/strings.dart';
import 'package:events_app/views/home/notifier/event_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

///cat api provider
final eventsApi = Provider<EventsApi>((ref) {
  return EventsApi();
});

///cat Future Provider
final eventFutureProvider = FutureProvider<List<EventCategoriesResponseModel>?>(
  (ref) async {
    final apiService = ref.watch(eventsApi);
    return apiService.callEventsCategoryApi();
  },
);

///api provider
final eventApiServiceProvider = Provider<EventsApi>((ref) {
  return EventsApi();
});

/// event notifier
final eventNotifierProvider = StateNotifierProvider<EventNotifier, List<Item>?>(
  (ref) {
    final api = ref.read(eventApiServiceProvider);
    return EventNotifier(api);
  },
);

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);
final googleSignInProvider = Provider(
  (ref) =>
      GoogleSignIn.instance
        ..initialize(serverClientId: AppConstants.webClientId),
);

final authRepositoryProvider = Provider<AuthApi>((ref) {
  return AuthApi(
    ref.watch(googleSignInProvider),
    ref.watch(firebaseAuthProvider),
  );
});

final authStateProvider = StreamProvider<User?>((ref) async* {
  await Future.delayed(const Duration(milliseconds: 500));
  yield* ref.watch(authRepositoryProvider).auth.authStateChanges();
});
