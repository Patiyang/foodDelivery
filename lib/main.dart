import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/appProvider.dart';
import 'package:foodDelivery/provider/productsProvider.dart';
import 'package:foodDelivery/provider/shopProvider.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/screens/homeNavigation.dart';
import 'package:foodDelivery/screens/loginSignUp/login.dart';
import 'package:foodDelivery/styling.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider.initialize()),
        ChangeNotifierProvider.value(value: ShopProvider.initialize()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(appBarTheme: AppBarTheme(color: orange[200]),
          scaffoldBackgroundColor: white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: grey[700]),
          cursorColor: black,
          accentColor: orange,
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ScreensController(),
      ),
    ),
  );
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomeNavigation();
      default: return Login();
    }
  }
}