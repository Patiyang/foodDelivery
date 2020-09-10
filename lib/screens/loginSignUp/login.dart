import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/screens/homeNavigation.dart';
import 'package:foodDelivery/screens/loginSignUp/register.dart';
import 'package:foodDelivery/service/users/userService.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/changeScreen.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:foodDelivery/widgets/textField.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserService userProvider = new UserService();
  UserService userService = new UserService();
  QuerySnapshot snapshot;
  String email = '';
  String password = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    print(user.status);
    print(user.status);
    print(user.status);
    print(user.status);
    print(user.status);
    return SafeArea(
      child: Scaffold(
          key: _key,
          body: user.status == Status.Authenticating
              ? Loading()
              : Stack(
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/mtumba.jpg',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width),
                    ),
                    Container(color: black.withOpacity(.6)),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 70,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  // height: 100,
                                  child: Column(
                                    children: <Widget>[
                                      CustomText(
                                          text: 'Hello',
                                          size: 50,
                                          fontWeight: FontWeight.w400,
                                          color: white,
                                          textAlign: TextAlign.left),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CustomText(
                                          text: 'Sign Into Your Account', size: 24, fontWeight: FontWeight.w300, color: white)
                                    ],
                                  ),
                                ),
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
                                    iconOne: Icons.person,
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
                                CustomText(
                                    textAlign: TextAlign.right,
                                    text: 'Recover Password?',
                                    color: white,
                                    fontWeight: FontWeight.bold,
                                    size: 20),
                                SizedBox(height: 30),
                                Container(
                                  width: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: CustomText(
                                          text: 'Sign In',
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
                                            onPressed: () async {
                                              if (formKey.currentState.validate()) {
                                                if (!await user.signIn(emailController.text, passwordController.text)) {
                                                  _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                                                }
                                                // changeScreenReplacement(context, HomeNavigation());
                                              }
                                            },
                                            child: Icon(Icons.arrow_forward),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: RichText(
                                      text: TextSpan(text: 'Don\'t have an account? ', children: <TextSpan>[
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Register()));
                                          },
                                        text: 'Create One',
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
}
