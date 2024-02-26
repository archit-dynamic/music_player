import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/firebase/authentication_queries.dart';
import 'package:music_player/view/main_tabview/main_tabview.dart';
import 'package:music_player/view/signup/signup_view.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              "LogIn",
              style: TextStyle(
                color: TColor.primary,
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                color: TColor.darkGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: emailController,
                showCursor: true,
                cursorColor: TColor.primaryText,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your email here...",
                  hintStyle: TextStyle(
                    color: TColor.primaryText60,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Container(
              decoration: BoxDecoration(
                color: TColor.darkGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: passwordController,
                showCursor: true,
                cursorColor: TColor.primaryText,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Enter your password here...",
                  hintStyle: TextStyle(
                    color: TColor.primaryText60,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: InputBorder.none,
                  suffixIcon: InkWell(
                    onTap: () {
                      isObscure = !isObscure;
                      setState(() {});
                    },
                    child: Image.asset(
                      isObscure
                          ? AppImages.hidePassword
                          : AppImages.showPassword,
                    ),
                  ),
                ),
                obscureText: isObscure,
                style: TextStyle(
                  color: TColor.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const SignUpView());
                  },
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                      color: TColor.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            InkWell(
              onTap: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  User? user = await FirebaseAuthenticationQueries().signInUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (user != null) {
                    Get.to(() => const MainTabView());
                  }
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: TColor.primary,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: Text(
                  "SignUp",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
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
