import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/screens/home.dart';
import 'package:foodDelivery/screens/favorites/favorites.dart';
import 'package:foodDelivery/screens/location.dart';
import 'package:foodDelivery/screens/manageOrders/orders.dart';
import 'package:foodDelivery/widgets/drawerItems.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../provider/userProvider.dart';
import '../styling.dart';
import '../widgets/changeScreen.dart';
import '../widgets/customText.dart';
import '../widgets/customText.dart';
import '../widgets/loading.dart';
import 'manageOrders/ordersScreen.dart';
import 'profile.dart';

class HomeNavigation extends StatefulWidget {
  final int cartOrderScreen;

  const HomeNavigation({Key key, this.cartOrderScreen}) : super(key: key);
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    Firestore _firestore = Firestore.instance;
    String firstName;
    String lastName;
    String email;
    String profilePicture;

    final tabs = [Location(), HomePage(), UserDetails()];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(elevation: 0,centerTitle: true, title: CustomText(text: 'CHANGE HII TITLE MZAE', size: 17)),
        body: tabs[currentIndex],
        bottomNavigationBar: SizedBox(
          height: 45,
          child: BottomNavigationBar(
            unselectedLabelStyle: TextStyle(color: black),
            fixedColor: orange,
            unselectedItemColor: black,
            selectedFontSize: 12,
            unselectedFontSize: 10,
            elevation: 0,
            iconSize: 15,
            showUnselectedLabels: true,
            currentIndex: currentIndex,
            backgroundColor: grey[100],
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.location_on_outlined), title: Text('Location')),
              // BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text('Manage Orders')),
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Profile')),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            StreamBuilder(
              stream: _firestore.collection('users').where(UserModel.ID, isEqualTo: user.user.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot _snap = snapshot.data.documents[i];
                    firstName = _snap[UserModel.FIRSTNAME];
                    lastName= _snap[UserModel.LASTNAME];
                    email = _snap[UserModel.EMAIL];
                    profilePicture = _snap[UserModel.PROFILE];
                  }
                  return GestureDetector(
                    child: UserAccountsDrawerHeader(
                        accountName: CustomText(text: firstName +''+ lastName, color: white, size: 16),
                        accountEmail: CustomText(text: email, color: white, size: 16),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(profilePicture),
                        )),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading(
                    text: 'Please Wait...',
                  );
                }
                if (snapshot.hasError) {
                  return CustomText(text: 'null');
                }
                return Container();
              },
            ),
            ListTiles(
                icon: Icons.home,
                text: 'Home',
                callback: () {
                  setState(() {
                    currentIndex = 0;
                  });
                  Navigator.pop(context);
                }),
            // ListTiles(
            //     icon: Icons.notifications,
            //     text: 'Notification',
            //     callback: () {
            //       setState(() {
            //         currentIndex = 0;
            //       });
            //       Navigator.pop(context);
            //     }),
            ListTiles(
                icon: Icons.shopping_cart,
                text: 'My Orders',
                callback: () {
                  changeScreen(context, ManageOrders());
                  // Navigator.pop(context);
                }),
            ListTiles(
                icon: Icons.favorite,
                text: 'Favorite Items',
                callback: () {
                  changeScreen(context, Favorites());
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      text: 'Application Preferences', letterSpacing: .4, fontWeight: FontWeight.w500, color: grey, size: 13),
                ],
              ),
            ),
            ListTiles(icon: Icons.help, text: 'Help & Support'),
            // ListTiles(
            //   icon: Icons.settings,
            //   text: 'Settings',
            //   callback: () => changeScreen(context, Settings()),
            // ),
            ListTiles(icon: Icons.language, text: 'Languages'),
            ListTiles(icon: Icons.brightness_6, text: 'Dark Mode'),
            ListTiles(
              icon: Icons.exit_to_app,
              text: 'Log Out',
              callback: () => user.signOut(),
            ),
          ],
        )),
      ),
    );
  }
}
