import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizplugins_skillup/controllers/login_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizplugins_skillup/utils/colors.dart';
import 'package:bizplugins_skillup/utils/common_widgets/app_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    controller.loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Sign in to continue",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                Center(
                  child: SvgPicture.asset(
                    'assets/images/login.svg', // change filename if needed
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 30),

                /// Username
                AppTextFormField(
                  controller: controller.userName,
                  label: "Username",
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Username is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Password with visibility toggle
                AppTextFormField(
                  controller: controller.password,
                  label: "Password",
                  obscureText: !isPasswordVisible,
                  textInputAction: TextInputAction.done,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 5) {
                      return "Password must be at least 5 characters";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                /// Remember me
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: controller.rememberMe.value,
                              onChanged: (val) {
                                controller.rememberMe.value = val ?? false;
                              },
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        // TextButton(
                        //   onPressed: () {
                        //     // TODO: Navigate to Forgot Password screen
                        //     // Get.to(() => ForgotPasswordScreen());
                        //   },
                        //   child: const Text(
                        //     "Forgot Password?",
                        //     style: TextStyle(
                        //       color: primaryColor,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                      ],
                    )),

                const SizedBox(height: 20),

                /// Login Button with loader
                Obx(() => SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  controller.loginAPI(context);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                              ),
                      ),
                    )),

                const SizedBox(height: 20),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don’t have an account? "),
                //     GestureDetector(
                //       onTap: () {
                //         // TODO: Navigate to Sign Up screen
                //         // Get.to(() => SignUpScreen());
                //       },
                //       child: const Text(
                //         "Sign Up",
                //         style: TextStyle(
                //           color: primaryColor,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
