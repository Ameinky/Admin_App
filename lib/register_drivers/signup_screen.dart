import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usrs_app/global/global.dart';
import 'package:usrs_app/widgets/progress_dialog.dart';
import '../constants/constan_color.dart';
import 'car_info_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController NameTextEditingController = TextEditingController();
  TextEditingController EmailTextEditingController = TextEditingController();
  TextEditingController PhoneTextEditingController = TextEditingController();
  TextEditingController PasswordTextEditingController = TextEditingController();

  void ValidateForm() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (NameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name Must be at least 3 characters");
    } else if (!EmailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email Address in not valid");
    } else if (PhoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "phone number is required");
    } else if (PasswordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password at least 8 Characters,");
    } else {
      saveDriverNow();
    }
  }

  saveDriverNow() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing PlS Wait...",
          );
        });
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: EmailTextEditingController.text.trim(),
      password: PasswordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      Map driverMap = {
        "id": firebaseUser.uid,
        "name": NameTextEditingController.text.trim(),
        "email": EmailTextEditingController.text.trim(),
        "phone": PhoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).set(driverMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => CarInfoScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'images/ambulance.png',
                height: 310,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              'Register as a Drver',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: whiteColor,
              ),
            ),
            TextField(
              controller: NameTextEditingController,
              style: TextStyle(color: whiteColor),
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: "Name",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
              ),
            ),
            TextField(
              controller: EmailTextEditingController,
              style: TextStyle(color: whiteColor),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: "Email",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
              ),
            ),
            TextField(
              controller: PhoneTextEditingController,
              style: TextStyle(color: whiteColor),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone',
                hintText: "Phone",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
              ),
            ),
            TextField(
              controller: PasswordTextEditingController,
              style: TextStyle(color: whiteColor),
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: "Password",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: whiteColor),
                ),
                hintStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: whiteColor,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ValidateForm();
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreenAccent,
              ),
              child: Text(
                'Create New Account',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forget PAssword?',
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
