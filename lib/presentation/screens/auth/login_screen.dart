import 'package:firebasetesting/core/common/custom_button.dart';
import 'package:firebasetesting/data/repositories/auth_repository.dart';
import 'package:firebasetesting/data/services/service_locator.dart';
import 'package:firebasetesting/presentation/screens/auth/signup_screen.dart';
import 'package:firebasetesting/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../core/common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _isPasswordVisible = false;
  bool _isLoading = false; // Add loading indicator

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> handleLogin() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });
      try {
        await getIt<AuthRepository>().signIn(
            email: emailController.text, password: passwordController.text);
        // Navigation logic after successful login (replace with your navigation)
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/home'); //Example
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Text(
                  "Welcome Back !",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Sign In to continue",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  focusNode: _emailFocus,
                  validator: _validateEmail,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: passwordController,
                  hintText: "Password",
                  secureText: !_isPasswordVisible,
                  prefixIcon: const Icon(Icons.lock),
                  focusNode: _passwordFocus,
                  validator: _validatePassword,
                  onChanged: (value) {
                    _formKey.currentState!.validate();
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: true, // This should be a state variable
                      onChanged: (value) {}, // Handle remember me logic
                    ),
                    const Text("Remember Me"),
                    const Spacer(),
                    TextButton(
                      onPressed: () {}, // Handle forgot password logic
                      child: const Text("Forgot Password?"),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CustomButton(
                  onPressed: _isLoading ? null : handleLogin, // Disable button while loading
                  text: "Log In",
                ),
                const SizedBox(height: 10),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have account ? ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: "Sign Up !",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              getIt<AppRouter>().push(const SignupScreen());
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
