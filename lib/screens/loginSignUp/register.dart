import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodDelivery/models/users.dart';
import 'package:foodDelivery/screens/loginSignUp/login.dart';
import 'package:foodDelivery/service/users/userProvider.dart';
import 'package:foodDelivery/service/users/usersDatabase.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:foodDelivery/widgets/textField.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homeNavigation.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneNumberController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  UserService userProvider = new UserService();
  UserDataBase userDataBase = new UserDataBase();
  QuerySnapshot snapshot;
  Firestore firestore = Firestore.instance;
  String userName;
  String userEmail;
  String phoneNumber;
  String userId;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            child: Image.asset('images/mtumba.jpg',
                fit: BoxFit.cover, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width),
          ),
          Container(color: black.withOpacity(.6)),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                        child: CustomTextField(
                          radius: 20,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'FirstName field cannot be left empty';
                            }

                            return null;
                          },
                          containerColor: white.withOpacity(.8),
                          iconOne: Icons.person,
                          hint: 'FirstName',
                          controller: firstNameController,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                        child: CustomTextField(
                          radius: 20,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'laseName field cannot be left empty';
                            }

                            return null;
                          },
                          containerColor: white.withOpacity(.8),
                          // iconOne: Icons.lock,
                          hint: 'LastName',
                          controller: lastNameController,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1),
                        child: CustomTextField(
                          radius: 20,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Email Cannot be empty';
                            }
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(v))
                              return 'Please make sure your email address is valid';
                            else
                              return null;
                          },
                          containerColor: white.withOpacity(.8),
                          iconOne: Icons.email,
                          hint: 'Email',
                          controller: emailController,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 8),
                        child: CustomTextField(
                          radius: 20,
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Password field cannot be left empty';
                            }
                            if (v.length < 6) {
                              return 'the password length must be greather than 6';
                            }
                            return null;
                          },
                          containerColor: white.withOpacity(.8),
                          iconOne: Icons.lock,
                          hint: 'Password',
                          controller: passwordController,
                          obscure: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CustomText(
                            textAlign: TextAlign.right,
                            text: 'Recover Password?',
                            color: white,
                            fontWeight: FontWeight.bold,
                            size: 20),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          width: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: CustomText(
                                  text: 'Sign Up',
                                  color: white,
                                  size: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                child: Container(
                                  width: 60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [white, orange]),
                                  ),
                                  child: MaterialButton(
                                    splashColor: orange,
                                    minWidth: 30,
                                    height: 40,
                                    shape: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                                    onPressed: signUp,
                                    child: Icon(Icons.arrow_forward),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(text: 'Already have an account? ', children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Login()));
                                },
                              text: 'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline))
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(visible: loading == true, child: Loading())
        ],
      )),
    );
  }

  signUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (formKey.currentState.validate()) {
      prefs.setString(User.emailAddress, emailController.text);
      setState(() {
        loading = true;
      });
      userDataBase.getUserByEmail(emailController.text).then((QuerySnapshot snap) async {
        if (snap.documents.length < 1) {
          await userDataBase.createUser(
              firstNameController.text, lastNameController.text, emailController.text, passwordController.text);
          await userProvider
              .signUp(emailController.text, passwordController.text)
              .then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeNavigation())));
        } else {
          setState(() {
            formKey.currentState.reset();
            loading = false;
          });
          Fluttertoast.showToast(msg: 'Email already in use');
        }
      });
    }
  }
}
