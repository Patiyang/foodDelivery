import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/loginSignUp/login.dart';
import 'package:foodDelivery/screens/loginSignUp/register.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool seeLogin = false;
  bool seeRegistration = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Column(
            children: [
              Image.asset('images/loggo.png', height: 90),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),
                    color: grey[100],
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          OnboardChild(imagePath: 'images/allWeather.png', text: 'For the cold'),
                          OnboardChild(imagePath: 'images/children.png', text: 'For the kids'),
                          OnboardChild(imagePath: 'images/urbanTrends.png', text: 'For the trendy')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              FavoriteButton(
                callback: () {
                  setState(() {
                    seeLogin = true;
                  });
                },
                icon: Icons.exit_to_app,
                text: 'Log In',
                color: orange,
              ),
              FavoriteButton(
                callback: () {
                  setState(() {
                    seeRegistration = true;
                  });
                },
                icon: Icons.person_add,
                text: 'Sign Up',
                color: orange,
              )
            ],
          ),
          Visibility(
            visible: seeLogin == true,
            child: Login(),
          ),
          Visibility(
            child: Register(),
            visible: seeRegistration == true,
          )
        ],
      )),
    );
  }
}

class OnboardChild extends StatelessWidget {
  final String imagePath;
  final String text;

  const OnboardChild({Key key, @required this.imagePath, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              imagePath,
              colorBlendMode: BlendMode.colorBurn,
              fit: BoxFit.cover,
              height: 380,
            ),
            CustomText(
              text: text,
              size: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: .3,
            )
          ],
        ),
      ),
    );
  }
}
