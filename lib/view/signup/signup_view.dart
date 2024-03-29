import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/common/app_images.dart';
import 'package:music_player/common/color_extensions.dart';
import 'package:music_player/view/login/login_view.dart';
import 'package:music_player/view_model/signup_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;
  final loginVM = Get.put<SignupViewModel>(SignupViewModel());

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
              "SignUp",
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
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
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
                  "Already have a account? ",
                  style: TextStyle(
                    color: TColor.primaryText,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => const LogInView());
                  },
                  child: Text(
                    "LogIn",
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
                loginVM.signUpUser(
                    email: emailController.text,
                    password: passwordController.text);
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
