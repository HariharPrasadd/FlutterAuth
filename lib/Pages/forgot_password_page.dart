import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:social_media_app/Components/my_button.dart";
import "package:social_media_app/Components/text_field.dart";
import "package:social_media_app/Pages/register_page.dart";

import "auth_page.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      successMessage();
    } on FirebaseAuthException catch (e) {
      errorMessage(e);
    }
  }

  void errorMessage(FirebaseAuthException errormessage) {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            errormessage.message.toString(),
          ),
        );
      },
    );
  }

  void successMessage() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          content: Text(
            "Password reset link sent successfully!",
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //logo
                const Icon(Icons.lock_reset_rounded, size: 150),

                const SizedBox(height: 10),

                //trouble logging in?
                const Text("Trouble Logging In?",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

                const SizedBox(height: 25),

                //enter your email
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Enter your email and we'll send you a link to get \nback into your account.",
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 25),

                //email textbox
                MyTextField(
                  controller: _emailController,
                  hintText: "Enter Email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //send login link button
                MyButton(onTap: passwordReset, text: "Send Login Link"),

                const SizedBox(height: 50),

                //divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //Create New Account
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation1,
                            Animation<double> animation2) {
                          return const RegisterPage();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                //back to login
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation1,
                            Animation<double> animation2) {
                          return const AuthPage();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const Text(
                    "Back To Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
