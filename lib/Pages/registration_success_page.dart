import "package:flutter/material.dart";
import "package:social_media_app/Components/my_button.dart";
import "package:social_media_app/Pages/auth_page.dart";

class RegistrationSuccessPage extends StatelessWidget {
  const RegistrationSuccessPage({super.key});

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

                const Icon(Icons.check_circle, size: 100, color: Colors.green),

                const SizedBox(height: 50),

                const Text("Your account has been registered successfully."),

                const SizedBox(height:50),

                MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation<double> animation1,
                            Animation<double> animation2) {
                          return const AuthPage();
                        },
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  }, text: "Go to Home Page")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
