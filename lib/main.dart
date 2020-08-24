import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/productsProvider.dart';
import 'package:foodDelivery/provider/shopProvider.dart';
import 'package:foodDelivery/screens/loginSignUp/login.dart';
import 'package:foodDelivery/styling.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductsProvider.initialize()),
        ChangeNotifierProvider.value(value: ShopProvider.initialize()),
        // ChangeNotifierProvider.value(value: AppProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: grey[700]),
          cursorColor: black,
          accentColor: orange,
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Login(),
      ),
    ),
  );
}
