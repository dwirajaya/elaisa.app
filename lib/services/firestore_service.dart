import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elaisa_app/models/user_model.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  // users
  // Add a user to Firestore
  Future<void> addUser(String? id, UserModel userModel) async {
    if (id != null) await db.collection('users').doc(id).set(userModel.toMap());
  }

  // Get a user from Firestore
  Future<UserModel?> getUser(String uid) async {
    try {
      final doc = await db.collection('users').doc(uid).get();
      if (doc.exists) {
        return UserModel.fromMap(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error getting user: $e');
    }
    return null;
  }

  // Update a user in Firestore
  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    await db.collection('users').doc(id).update(data);
  }

  // Delete a user from Firestore
  Future<void> deleteUser(String id) async {
    await db.collection('users').doc(id).delete();
  }
}
