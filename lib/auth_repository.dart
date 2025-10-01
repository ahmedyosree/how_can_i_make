import 'package:how_can_i_make/models/user.dart';
import 'firebase_auth_service.dart';
import 'firestore_service.dart';
import 'local_storage.dart';

class AuthRepository {
  final FirebaseAuthService _authService;
  final SharedPreferencesService _prefsService;
  final FirestoreUserService _firestoreUserService;

  AuthRepository({
    required FirebaseAuthService authService,
    required SharedPreferencesService prefsService,
    required FirestoreUserService firestoreUserService,
  })  : _authService = authService,
        _prefsService = prefsService,
        _firestoreUserService = firestoreUserService;

  // Sign in and save user to preferences and Firestore
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser  = credential?.user;
    if (fbUser  != null) {
      // Try to get user data from Firestore
      UserModel? userModel = await _firestoreUserService.getUser(fbUser.uid);
      if (userModel == null) {
        // If user does not exist in Firestore, create a new UserModel
        userModel = UserModel(
          id: fbUser .uid,
          name: fbUser .displayName ?? '',
          email: fbUser .email ?? email,
          avatarUrl: fbUser .photoURL,
          bio: null,
          registeredAt: DateTime.now(),
          roadmapIds: [],
          followingRoadmapIds: [],
        );
        await _firestoreUserService.saveUser (userModel);
      }
      await _prefsService.saveUser (userModel);
      return userModel;
    }
    return null;
  }

  // Register and save user to preferences and Firestore
  Future<UserModel?> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final credential = await _authService.registerWithEmailAndPassword(
      email: email,
      password: password,
    );
    final fbUser  = credential?.user;
    if (fbUser  != null) {
      final userModel = UserModel(
        id: fbUser .uid,
        name: name ?? '',
        email: fbUser .email ?? email,
        avatarUrl: fbUser .photoURL,
        bio: null,
        registeredAt: DateTime.now(),
        roadmapIds: [],
        followingRoadmapIds: [],
      );
      await _firestoreUserService.saveUser (userModel);
      await _prefsService.saveUser (userModel);
      return userModel;
    }
    return null;
  }

  // Sign out and remove user from preferences
  Future<void> signOut() async {
    await _authService.signOut();
    await _prefsService.removeUser();
  }

  // Get current user from preferences
  UserModel? getCurrentUser() {
    return _prefsService.getUser();
  }
}