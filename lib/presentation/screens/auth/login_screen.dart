import 'package:firebasetesting/core/common/custom_button.dart';
import 'package:firebasetesting/core/utils/ui_utils.dart';
import 'package:firebasetesting/data/services/service_locator.dart';
import 'package:firebasetesting/logic/cubits/auth/auth_cubit.dart';
import 'package:firebasetesting/logic/cubits/auth/auth_state.dart';
import 'package:firebasetesting/presentation/screens/auth/signup_screen.dart';
import 'package:firebasetesting/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    getIt<AuthCubit>().signOut(); // E  nsure user is logged out when the app starts
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
        await getIt<AuthCubit>().signIn(
            email: emailController.text, password: passwordController.text);
        // Navigation logic after successful login (replace with your navigation)
        // ignore: use_build_context_synchronously
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
    return BlocConsumer<AuthCubit, AuthState>(
        bloc: getIt<AuthCubit>(),
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            getIt<AppRouter>().pushAndRemoveUntil(
               Scaffold(
                 appBar: AppBar(
                  title: Text('Home',
                  style: TextStyle(color: Colors.black),),
                ),
                body: Text("Hello"),
              ),
            );
          } else if (state.status == AuthStatus.error && state.error != null) {
            UiUtils.showSnackBar(context, message: state.error!);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Welcome Back",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sign in to continue",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: "Email",
                          focusNode: _emailFocus,
                          validator: _validateEmail,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                          
                          }                       ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          focusNode: _passwordFocus,
                          validator: _validatePassword,
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline),
                          secureText: !_isPasswordVisible,
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
                          onChanged: (value) {
                            _formKey.currentState!.validate();
                            
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                          onPressed: handleLogin,
                          text: 'Login',
                          child: state.status == AuthStatus.loading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account?  ",
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                              children: [
                                TextSpan(
                                  text: "Sign up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const SignupScreen(),
                                      //   ),
                                      // );
                                      getIt<AppRouter>()
                                          .push(const SignupScreen());
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
