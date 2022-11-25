import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:usrs_app/splashScreen/splash_screen.dart';

import '../constants/constan_color.dart';
import '../global/global.dart';

class CarInfoScreen extends StatefulWidget {
  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController CarModelTextEditingController = TextEditingController();
  TextEditingController CarPhoneTextEditingController = TextEditingController();
  TextEditingController CarColorTextEditingController = TextEditingController();

  List<String> carTypeList = [
    "Ambulance-Homey",
    "Ambulance-bike",
    "Ambulance-bus"
  ];
  String? SelectedCarType;

  // User? currentFirebaseUser;

  saveCarInfo() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    if (currentFirebaseUser != null) {
      Map driverCarInfoMap = {
        "ambulance_color": CarColorTextEditingController.text.trim(),
        "ambulance_number": CarPhoneTextEditingController.text.trim(),
        "ambulance_model": CarModelTextEditingController.text.trim(),
        "type": SelectedCarType,
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");

      driversRef
          .child(currentFirebaseUser!.uid)
          .child("car_details")
          .set(driverCarInfoMap);
      Fluttertoast.showToast(msg: "Car details has been saved. Congratulation");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MySplashScreen()));
    } else {
      Navigator.pop(context);
      Timer(Duration(seconds: 10), () {
        Fluttertoast.showToast(msg: "Account has not been created");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
              SizedBox(
                height: 17,
              ),
              Text(
                'Write Ambulance Details',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              TextField(
                controller: CarModelTextEditingController,
                style: TextStyle(color: whiteColor),
                decoration: InputDecoration(
                  labelText: 'Ambulance  Model',
                  hintText: "Ambulance   Model",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: whiteColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: whiteColor),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: whiteColor,
                  ),
                ),
              ),
              TextField(
                controller: CarPhoneTextEditingController,
                style: TextStyle(color: whiteColor),
                decoration: InputDecoration(
                  labelText: 'Ambulance  Tarco',
                  hintText: "Ambulance   Tarco",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: whiteColor),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: whiteColor),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: whiteColor,
                  ),
                ),
              ),
              TextField(
                controller: CarColorTextEditingController,
                style: TextStyle(color: whiteColor),
                decoration: InputDecoration(
                  labelText: 'Ambulance  Color',
                  hintText: "Ambulance   Color",
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
                height: 17,
              ),
              DropdownButton(
                dropdownColor: Colors.grey[900],
                hint: Text(
                  "Please Choose AmbulanceType",
                  style: TextStyle(
                    fontSize: 19,
                    color: whiteColor,
                  ),
                ),
                value: SelectedCarType,
                onChanged: (newVAlue) {
                  setState(() {
                    SelectedCarType = newVAlue.toString();
                  });
                },
                items: carTypeList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: TextStyle(color: whiteColor),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (CarColorTextEditingController.text.isNotEmpty &&
                        CarPhoneTextEditingController.text.isNotEmpty &&
                        CarModelTextEditingController.text.isNotEmpty &&
                        SelectedCarType != null) {
                      saveCarInfo();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                ),
                child: Text(
                  'Save Now',
                  style: TextStyle(
                    fontSize: 18,
                    color: whiteColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
