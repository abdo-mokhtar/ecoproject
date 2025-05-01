import 'package:ecosensetest/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6FDFB),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      onChanged: (value) => authState.setEmail(value),
                      validator: (value) => authState.validateEmail(),
                    ),

                    const SizedBox(height: 20),

                    // Password Field
                    TextFormField(
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
                                  String userType =
                                      authState.userType ?? 'user';
                                  if (userType == 'user') {
                                    Navigator.pushReplacementNamed(
                                        context, '/homeuser');
                                  } else if (userType == 'business') {
                                    Navigator.pushReplacementNamed(
                                        context, '/homebusiness');
                                  } else if (userType == 'government') {
                                    Navigator.pushReplacementNamed(
                                        context, '/homegoverment');
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          authState.errorMessage ?? 'Error'),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
            // Skip button bottom right
            Positioned(
              bottom: 10,
              right: 20,
              child: GestureDetector(
                onTap: () async {
                  // تحميل userType من SharedPreferences
                  await authState.loadUserType();
                  String userType = authState.userType ?? 'user';
                  if (userType == 'user') {
                    Navigator.pushReplacementNamed(context, '/homeuser');
                  } else if (userType == 'business') {
                    Navigator.pushReplacementNamed(context, '/homebusiness');
                  } else if (userType == 'government') {
                    Navigator.pushReplacementNamed(context, '/homegoverment');
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF48A47C),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Skip",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
