import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/Components/my_button.dart';
import 'package:social_media_app/Components/square_tile.dart';
import 'package:social_media_app/Components/text_field.dart';
import 'package:social_media_app/Pages/auth_page.dart';
import 'package:social_media_app/Pages/registration_success_page.dart';
import 'package:social_media_app/Services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  //conditional error message boolean
  bool showError = false;

  //conditional success message boolean
  bool showSuccess = false;

  //error message to be displayed
  String error_message = 'Something went wrong';

  //sign user in
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //hide prior error message
    setState(() {
      showError = false;
    });

    //try creating the user
    try {
      //check if password and confirm password are matching
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        successMessage();
      } else {
        errorMessage("");

        //pop the loading circle
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      //show error to user
      errorMessage(e.code);

      //pop the loading circle
      Navigator.pop(context);
    }
  }

  //navigate to success page
  void successMessage() {
    //pop the loading circle
    Navigator.pop(context);

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation1,
            Animation<double> animation2) {
          return const RegistrationSuccessPage();
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
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

    //if user hasn't entered their email and password
    if (passwordController.text.isEmpty && emailController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your email  and password.";
      });
    }

    //if the user hasn't entered their email
    else if (emailController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your email.";
      });
    }

    //if the user hasn't entered their password
    else if (passwordController.text.isEmpty) {
      setState(() {
        error_message = "Please enter your password.";
      });
    }

    //if the email's already in use
    else if (errormessage == "email-already-in-use") {
      setState(() {
        error_message = "Email already in use.";
      });
    }

    //if there's an invalid email
    else if (errormessage == "invalid-email") {
      setState(() {
        error_message = "Please enter a valid email address.";
      });
    }

    //if confirm password is empty
    else if (confirmPasswordController.text.isEmpty) {
      setState(() {
        error_message = "Please confirm your password.";
      });
    }

    //if the passwords don't match
    else if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        error_message = "Passwords do not match.";
      });
    }

    //if there's a weak password
    else if (errormessage == "weak-password") {
      setState(() {
        error_message = "Please use a stronger password.";
      });
    }

    Future.delayed(
      const Duration(milliseconds: 900),
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
              const SizedBox(height: 25),

              //logo
              const Icon(Icons.lock, size: 50),

              const SizedBox(height: 25),

              //Let's create an account for you
              Text(
                "Let's create an account for you!",
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

              const SizedBox(height: 25),

              //confirm password textfield
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm password",
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
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //sign in button
              MyButton(onTap: signUserUp, text: "Sign Up"),

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
                    onTap: () {
                      AuthService().signInWithGoogle();
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
                    imagePath: "lib/Images/google.png",
                  ),
                ],
              ),

              const SizedBox(height: 50),

              //not a member? register now
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Already have an account?",
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
                          return const AuthPage();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: const Text(
                    "Login Now",
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
    ));
  }
}
