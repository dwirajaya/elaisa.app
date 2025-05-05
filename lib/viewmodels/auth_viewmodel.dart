import 'package:elaisa_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  bool _isLoading = false;
  String? _errorMessage;
  UserModel? _userModel;
  String uid =
      ''; // To store the UID when the userModel is not yet loaded from Firestore

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get userModel => _userModel;
  Stream<User?> get onAuthStateChanged => _authService.onAuthStateChanged;
  set userModel(UserModel? model) => _userModel = model;

  Future<void> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userModel = await _authService.signInWithGoogle();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userModel = await _authService.createUserWithEmailAndPassword(
        email,
        password,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userModel = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInAnonymously() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _userModel = await _authService.signInAnonymously();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchUser(String uid) async {
    try {
      this.uid = uid;
      _userModel = await _firestoreService.getUser(uid);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to fetch user: $e';
      notifyListeners();
    }
  }

  Future<void> addUser(UserModel userModel) async {
    try {
      this.uid = userModel.uid!;
      await _firestoreService.addUser(userModel.uid, userModel);
      _userModel = userModel;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add user: $e';
      notifyListeners();
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      this.uid = uid;
      await _firestoreService.updateUser(uid, data);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update user: $e';
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _userModel = null;
      notifyListeners();
    }
  }
}
