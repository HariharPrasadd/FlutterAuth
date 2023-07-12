import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Components/my_button.dart';
import 'package:social_media_app/Components/square_tile.dart';
import 'package:social_media_app/Components/text_field.dart';
import 'package:social_media_app/Pages/register_page.dart';
import 'package:social_media_app/Services/auth_service.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //conditional error message booleans
  bool showError = false;

  //error message to be displayed
  String error_message = 'No change';

  //sign user in
  void signUserIn() async {
    //hide error message
    setState(() {
      showError = false;
    });
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //show error to user
      errorMessage(e.code);

      //pop the loading circle
      Navigator.pop(context);
    }
  }

  //wrong email message popup
  void errorMessage(String errormessage) {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    setState(() {
      showError = false;
    });

    //if the user hasn't entered their email and password
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your email and password.";
      });
    }

    //if the user hasn't entered their email
    else if (emailController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your email.";
      });
    }

    //if the user has entered an invalid email
    else if (errormessage == 'invalid-email') {
      setState(() {
        error_message = "Please enter a valid email address.";
      });
    }

    //if the user hasn't entered their password
    else if (passwordController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your password.";
      });
    }

    //if the user has entered an incorrect email
    else if (errormessage == 'user-not-found') {
      setState(() {
        error_message = "User does not exist.";
      });
    }

    //if the user has entered an incorrect password
    else if (errormessage == 'wrong-password') {
      setState(() {
        error_message = "Incorrect password.";
      });
    }

    //if the user sends too many requests
    else if (errormessage == 'too-many-requests') {
      setState(() {
        error_message =
            'Your account has been timed out. \nPlease reset password or try again later.';
      });
    }

    //if there's any other error
    else {
      setState(() {
        error_message = "There seems to be an error.";
      });
    }

    Future.delayed(
      const Duration(seconds: 1),
      () {
        setState(() {
          showError = true;
        });
        Navigator.pop(context);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                const Icon(Icons.lock, size: 100),

                const SizedBox(height: 50),

                //welcome back, you've been missed
                Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //error message
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: showError,
                            child: Text(
                              error_message,
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                //forgot password
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const ForgotPasswordPage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),

                const SizedBox(height: 25),

                //sign in button
                MyButton(onTap: signUserIn, text: "Sign In"),

                const SizedBox(height: 50),

                //or continue with
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
                          "Or continue with",
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

                const SizedBox(height: 25),

                //google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: "lib/Images/google.png",
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //not a member? register now
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
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
                      "Register Now",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
