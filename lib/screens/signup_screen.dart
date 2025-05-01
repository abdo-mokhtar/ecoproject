import 'package:ecosensetest/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // Icon logo
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFF48A47C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF48A47C),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // User Name
                  _buildInputField(
                    label: "Username",
                    icon: Icons.person,
                    onChanged: (value) => authState.setUsername(value),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a username' : null,
                  ),
                  const SizedBox(height: 16),

                  // Email with validation
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Email",
                      prefixIcon:
                          const Icon(Icons.email, color: Color(0xFF48A47C)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => authState.setEmail(value),
                    validator: (value) => authState.validateEmail(),
                  ),
                  const SizedBox(height: 16),

                  // Phone with country code picker
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InternationalPhoneNumberInput(
                      inputDecoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Phone",
                        prefixIcon:
                            const Icon(Icons.phone, color: Color(0xFF48A47C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onInputChanged: (PhoneNumber number) {
                        authState.setPhone(number.phoneNumber ?? '');
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password
                  TextFormField(
                    obscureText: !authState.isPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => authState.setPassword(value),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password' : null,
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password
                  TextFormField(
                    obscureText: !authState.isConfirmPasswordVisible,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Confirm Password",
                      prefixIcon:
                          const Icon(Icons.lock, color: Color(0xFF48A47C)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          authState.isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: authState.toggleConfirmPasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) => authState.setConfirmPassword(value),
                    validator: (value) => authState.validatePasswordMatch(),
                  ),
                  const SizedBox(height: 30),

                  // SIGN UP Button
                  authState.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool success = await authState.signUp();
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
                                      context, '/homegoverment');
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
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                  const SizedBox(height: 25),

                  // Already have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF48A47C),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF48A47C)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
