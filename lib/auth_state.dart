import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _email = '';
  String _password = '';
  String _username = '';
  String _phone = '';
  String _confirmPassword = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _userType = 'user';
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  FirebaseAuth get auth => _auth;
  String get email => _email;
  String get password => _password;
  String get username => _username;
  String get phone => _phone;
  String get confirmPassword => _confirmPassword;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String? get userType => _userType;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setters
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setPhone(String value) {
    _phone = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void setUserType(String value) {
    _userType = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  String? validateEmail() {
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(pattern);
    if (_email.isEmpty) return 'Please enter an email';
    if (!regex.hasMatch(_email)) return 'Enter a valid email';
    return null;
  }

  String? validatePasswordMatch() {
    if (_password.isEmpty) return 'Please enter a password';
    if (_password.length < 6) return 'Password must be at least 6 characters';
    if (_password != _confirmPassword) return 'Passwords do not match';
    return null;
  }

  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      _userType = await loadUserType();
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Invalid email or password';
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp({String userType = 'user'}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Validate all fields
      if (_username.isEmpty) {
        _errorMessage = 'Please enter a username';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (_phone.isEmpty) {
        _errorMessage = 'Please enter a phone number';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (validateEmail() != null || validatePasswordMatch() != null) {
        _errorMessage = 'Please fix the errors in the form';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      await saveUserData(userCredential.user!.uid, userType);
      _userType = userType;
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMessage = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        _errorMessage = 'The account already exists for that email';
      } else {
        _errorMessage = e.message ?? 'An error occurred during sign up';
      }
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> saveUserData(String uid, String userType) async {
    await _firestore.collection('users').doc(uid).set({
      'username': _username,
      'phone': _phone,
      'userType': userType,
      'email': _email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String?> loadUserType() async {
    if (_auth.currentUser != null) {
      var doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      return doc.data()?['userType'] ?? 'user';
    }
    return 'user';
  }

  void logout() async {
    await _auth.signOut();
    _userType = 'user';
    notifyListeners();
  }
}
