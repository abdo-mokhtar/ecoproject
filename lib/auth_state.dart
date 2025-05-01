import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends ChangeNotifier {
  // متغيرات الحالة
  String _email = '';
  String _password = '';
  String _username = '';
  String _phone = '';
  String _confirmPassword = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _userType = 'user'; // قيمة افتراضية
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
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

  // التحقق من صحة البريد الإلكتروني
  String? validateEmail() {
    String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
    RegExp regex = RegExp(pattern);
    if (_email.isEmpty) {
      return 'Please enter an email';
    } else if (!regex.hasMatch(_email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // التحقق من تطابق كلمات المرور
  String? validatePasswordMatch() {
    if (_password != _confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  // تسجيل الدخول باستخدام SharedPreferences
  Future<bool> login() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      // التحقق من وجود المستخدم في SharedPreferences
      String? storedEmail = prefs.getString('email');
      String? storedPassword = prefs.getString('password');

      if (storedEmail == _email && storedPassword == _password) {
        _userType = prefs.getString('userType') ?? 'user';
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // التسجيل باستخدام SharedPreferences
  Future<bool> signUp({String userType = 'user'}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // التحقق من الحقول
      if (validateEmail() != null || validatePasswordMatch() != null) {
        _errorMessage = 'Please fix the errors in the form';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // حفظ بيانات المستخدم في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      await prefs.setString('username', _username);
      await prefs.setString('phone', _phone);
      await prefs.setString('userType', userType);

      _userType = userType;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // استرجاع نوع المستخدم
  Future<void> loadUserType() async {
    final prefs = await SharedPreferences.getInstance();
    _userType = prefs.getString('userType') ?? 'user';
    notifyListeners();
  }
}
