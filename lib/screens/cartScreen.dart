import 'package:flutter/material.dart';
import 'package:foodDelivery/provider/appProvider.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/screens/products/singleProduct.dart';
import 'package:foodDelivery/service/productsService.dart';
import 'package:foodDelivery/widgets/changeScreen.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../styling.dart';

enum Pages  {cartList, orders}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
   Pages selectedpage = Pages.cartList;
  Color active = orange;
  Color inactive = grey[200];
  final _key = GlobalKey<ScaffoldState>();
  ProductsService _productsService = new ProductsService();
  // OrderServices _orderServices = OrderServices();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final userModelItem = userProvider.userModel;
    return Scaffold(
      key: _key,
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: black),
      //   backgroundColor: orange[200],
      //   elevation: 0.0,
      //   centerTitle: true,
      //   title: CustomText(
      //     text: "Shopping Cart",
      //     size: 20,
      //     fontWeight: FontWeight.bold,
      //     letterSpacing: .3,
      //   ),
      //   leading: IconButton(
      //       icon: Icon(Icons.close),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       }),
      // ),
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userModelItem.cart.length,
              itemBuilder: (_, index) {
                var cart = userModelItem.cart[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
                  child: GestureDetector(
                    onTap: () {
                      _productsService.selectedCartItem(cart.productId).then((value) {
                        print('${value.length}');
                        changeScreenReplacement(
                            context,
                            SingleProduct(
                              productsModel: value[0],
                            ));
                      });
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: white,
                          boxShadow: [BoxShadow(color: grey.withOpacity(0.2), offset: Offset(3, 2), blurRadius: 7)]),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(9),
                            ),
                            child: Image.network(
                              cart.image,
                              height: 110,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: cart.name,
                                        style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: "Ksh${cart.price}",
                                        style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.w300)),
                                  ]),
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: red,
                                    ),
                                    onPressed: () async {
                                      appProvider.changeLoadingState();
                                      bool success = await userProvider.removeFromCart(cartItem: userModelItem.cart[index]);
                                      if (success) {
                                        userProvider.updateUserModel();
                                        _key.currentState.showSnackBar(SnackBar(
                                            content: Text(
                                          "Removed from Cart!",
                                          textAlign: TextAlign.center,
                                        )));
                                        appProvider.changeLoadingState();
                                        return;
                                      } else {
                                        appProvider.changeLoadingState();
                                      }
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Container(
          color: grey[100],
          // height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "Total: ", style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: " \$${userModelItem.totalCartPrice}",
                        style: TextStyle(color: orange, fontSize: 17, fontWeight: FontWeight.bold)),
                  ]),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: black),
                  child: FlatButton(
                    child: CustomText(
                      text: "Check out",
                      // size: 17,
                      color: white,
                      fontWeight: FontWeight.normal,
                    ),
                    onPressed: () {
                      if (userModelItem.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Your cart is emty',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Total Ksh${userModelItem.totalCartPrice}',
                                        textAlign: TextAlign.center,
                                      ),

                                      // SizedBox(
                                      //   width: 320.0,
                                      //   child: RaisedButton(
                                      //     onPressed: () async {
                                      //       var uuid = Uuid();
                                      //       String id = uuid.v4();
                                      //       _orderServices.createOrder(
                                      //           userId: userProvider.user.uid,
                                      //           id: id,
                                      //           description: "Some random description",
                                      //           status: "complete",
                                      //           totalPrice: userProvider.userModel.totalCartPrice,
                                      //           cart: userProvider.userModel.cart);
                                      //       for (CartModel cartItem in userProvider.userModel.cart) {
                                      //         bool value = await userProvider.removeFromCart(cartItem: cartItem);
                                      //         if (value) {
                                      //           userProvider.reloadUserModel();
                                      //           print("Item added to cart");
                                      //           _key.currentState.showSnackBar(SnackBar(content: Text("Removed from Cart!")));
                                      //         } else {
                                      //           print("ITEM WAS NOT REMOVED");
                                      //         }
                                      //       }
                                      //       _key.currentState.showSnackBar(SnackBar(content: Text("Order created!")));
                                      //       Navigator.pop(context);
                                      //     },
                                      //     child: Text(
                                      //       "Accept",
                                      //       style: TextStyle(color: white),
                                      //     ),
                                      //     color: const Color(0xFF1BC0C5),
                                      //   ),
                                      // ),
                                      SizedBox(
                                          width: 320.0,
                                          child: FavoriteButton(
                                            callback: () {
                                              Navigator.pop(context);
                                            },
                                            text: "Cancel",
                                            icon: Icons.cancel,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
