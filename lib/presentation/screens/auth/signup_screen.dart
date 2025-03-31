import 'package:firebasetesting/core/common/custom_button.dart';
import 'package:firebasetesting/data/services/service_locator.dart';
import 'package:firebasetesting/presentation/screens/auth/login_screen.dart';
import 'package:firebasetesting/router/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../../../core/common/custom_text_field.dart';
import '../../../data/repositories/auth_repository.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    }
    if (!isEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return 'Phone is required';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value!.isEmpty) {
      return "Username is required";
    }

    return null;
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  Future<void> handleSignUp() async {
    FocusScope.of(context).unfocus();
    if(_formKey.currentState?.validate() ?? false) {
      try {
        await getIt<AuthRepository>().signUp(
        fullName: nameController.text,
          username: usernameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        password: passwordController.text,
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50),
                  Text(
                    "Start The Journey !",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign Up to continue ",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: emailController,
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    validator: validateEmail,
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    hintText: "Password",
                    secureText: true,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                    validator: validatePassword,
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: "Confirm Password",
                    secureText: false,
                    prefixIcon: Icon(Icons.lock),
                    validator: validateConfirmPassword,
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    prefixIcon: Icon(Icons.person),
                    validator: validateName,
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: phoneController,
                    hintText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    validator: validatePhone,
                    keyBoardType: TextInputType.numberWithOptions(),
                  ),
                  SizedBox(height: 10),
                  CustomTextField(
                    controller: usernameController,
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                    onChanged: (value) {
                      _formKey.currentState!.validate();
                    },
                    validator: validateUsername,
                  ),
                  SizedBox(height: 10),
                  // Row(
                  //   children: [
                  //     Checkbox(value: true, onChanged: (value) {
                  //       setState(() {
                  //         value = !value!;
                  //       });
                  //     }),
                  //     Text("Remember Me")
                  //     ,
                  //     Spacer(),
                  //     TextButton(onPressed: (){}, child: Text("Forgot Password?"))
                  //   ],
                  // ),
                  SizedBox(height: 30),
                  CustomButton(onPressed: handleSignUp , text: "Sign Up"),
                  SizedBox(height: 10),
                  // Text("Don't have account ? Sign Up !",
                  // style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  // ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Already Have An Account ? ",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: "Sign In !",
                            style: Theme.of(
                              context,
                            ).textTheme.bodyLarge?.copyWith(color: Colors.blue),
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.pop(context);
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => LoginScreen(),
                                    //   ),
                                    // );
                                    getIt<AppRouter>().pop();
                                    getIt<AppRouter>().push(LoginScreen());
                                    // Navigator.pop(context);
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
      ),
    );
  }
}
