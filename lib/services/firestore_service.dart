import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:how_can_i_make/models/user.dart';

class FirestoreUserService {
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final String _collection = 'users';

// Save or update user data in Firestore
Future<void> saveUser (UserModel user) async {
  try {
    await _firestore.collection(_collection).doc(user.id).set(user.toJson());
  } catch (e) {
    print('Error saving user to Firestore: $e');
    rethrow;
  }
}

// Get user data from Firestore by user ID
Future<UserModel?> getUser (String userId) async {
  try {
    final doc = await _firestore.collection(_collection).doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  } catch (e) {
    print('Error fetching user from Firestore: $e');
    return null;
  }
}

// Update specific fields of the user document
Future<void> updateUserFields(String userId, Map<String, dynamic> fields) async {
  try {
    await _firestore.collection(_collection).doc(userId).update(fields);
  } catch (e) {
    print('Error updating user fields in Firestore: $e');
    rethrow;
  }
}
}