import 'package:ecosensetest/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  PhoneNumber? _phoneNumber;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
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
                          TextFormField(
                            controller: _usernameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Username",
                              prefixIcon: const Icon(Icons.person,
                                  color: Color(0xFF48A47C)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) => authState.setUsername(value),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a username'
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Email
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Email",
                              prefixIcon: const Icon(Icons.email,
                                  color: Color(0xFF48A47C)),
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
                              onInputChanged: (PhoneNumber number) {
                                _phoneNumber = number;
                                authState.setPhone(number.phoneNumber ?? '');
                              },
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: _phoneNumber,
                              textFieldController: TextEditingController(),
                              formatInput: false,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputDecoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Phone",
                                prefixIcon: const Icon(Icons.phone,
                                    color: Color(0xFF48A47C)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !authState.isPasswordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFF48A47C)),
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
                            validator: (value) => value!.isEmpty
                                ? 'Please enter a password'
                                : null,
                          ),
                          const SizedBox(height: 16),

                          // Confirm Password
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !authState.isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Confirm Password",
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color(0xFF48A47C)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  authState.isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed:
                                    authState.toggleConfirmPasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) =>
                                authState.setConfirmPassword(value),
                            validator: (value) =>
                                authState.validatePasswordMatch(),
                          ),
                          const SizedBox(height: 16),

                          // Account Type Dropdown
                          DropdownButtonFormField<String>(
                            value: authState.userType ?? 'user',
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: "Account Type",
                              prefixIcon: const Icon(Icons.account_circle,
                                  color: Color(0xFF48A47C)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: const [
                              DropdownMenuItem(
                                  value: 'user', child: Text('User')),
                              DropdownMenuItem(
                                  value: 'business', child: Text('Business')),
                              DropdownMenuItem(
                                  value: 'government',
                                  child: Text('Government')),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                authState.setUserType(value);
                              }
                            },
                            validator: (value) => value == null
                                ? 'Please select an account type'
                                : null,
                          ),
                          const SizedBox(height: 30),

                          // SIGN UP Button
                          authState.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      bool success = await authState.signUp(
                                          userType:
                                              authState.userType ?? 'user');
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
                                              context, '/homegovernment');
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                authState.errorMessage ??
                                                    'Error during sign up'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF48A47C),
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                          const SizedBox(height: 25),

                          // Already have an account?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account? ",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
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
              );
            },
          ),
        ),
      ),
    );
  }
}
