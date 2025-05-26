import 'package:ecosensetest/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // FocusNodes for managing focus on text fields
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // TextEditingControllers for managing text input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose FocusNodes and Controllers to prevent memory leaks
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6FDFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/EcoSenseLogo.PNG',
                    width: size.width * 0.5,
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                const Text(
                  "Welcome back 👋",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D64),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                const Text(
                  "Login to your account",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon:
                        const Icon(Icons.email, color: Color(0xFF48A47C)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next, // Move to next field
                  onChanged: (value) => authState.setEmail(value),
                  validator: (value) => authState.validateEmail(),
                  onFieldSubmitted: (_) {
                    // Move focus to password field
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                ),

                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  obscureText: !authState.isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon:
                        const Icon(Icons.lock, color: Color(0xFF48A47C)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        authState.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: authState.togglePasswordVisibility,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) => authState.setPassword(value),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a password' : null,
                ),

                const SizedBox(height: 30),

                // Login Button
                authState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool success = await authState.login();
                            if (success) {
                              String userType = authState.userType ?? 'user';
                              if (userType == 'user') {
                                Navigator.pushReplacementNamed(
                                    context, '/homeuser');
                              } else if (userType == 'business') {
                                Navigator.pushReplacementNamed(
                                    context, '/homebusiness');
                              } else if (userType == 'government') {
                                Navigator.pushReplacementNamed(
                                    context, '/homegovernment');
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(authState.errorMessage ?? 'Error'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF48A47C),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),

                const SizedBox(height: 16),

                // Sign up Button
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                  child: const Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            color: Color(0xFF48A47C),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
