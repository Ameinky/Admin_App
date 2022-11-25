import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/constan_color.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final EmailTextEditingController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    EmailTextEditingController.dispose();
  }

  Future PasswordReset() async {
    // if() {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: EmailTextEditingController.text.trim());
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Password reset sent link! check your Email"),
            content: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                EmailTextEditingController.clear();
              },
              child: Text("OK"),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //search place ui
          Container(
            height: 160,
            decoration: const BoxDecoration(
              color: blueColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 25.0),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Enter Your Email & will Send you Password",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: TextField(
                              controller: EmailTextEditingController,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Enter Your Email...",
                                fillColor: Colors.white54,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          MaterialButton(
            onPressed: PasswordReset,
            child: Text(
              'Forgett Password',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.redAccent,
          )
        ],
      ),
    );
  }
}
