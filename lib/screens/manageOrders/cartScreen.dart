import 'package:flutter/material.dart';
import 'package:foodDelivery/models/cartProducts.dart';
import 'package:foodDelivery/provider/appProvider.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/screens/products/singleProduct.dart';
import 'package:foodDelivery/service/orderServices.dart';
import 'package:foodDelivery/service/productsService.dart';
import 'package:foodDelivery/widgets/changeScreen.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../styling.dart';

enum Pages { cartList, orders }

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Pages selectedpage = Pages.cartList;
  Color active = orange;
  Color inactive = grey[200];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsService _productsService = new ProductsService();
  OrderServices _orderServices = OrderServices();
  String shopName;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final appProvider = Provider.of<AppProvider>(context);
    final userModelItem = userProvider.userModel;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: white,
      body: appProvider.isLoading
          ? Loading()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: userModelItem.cart.length,
              itemBuilder: (_, index) {
                var cart = userModelItem.cart[index];
                var individualPrice = cart.price / cart.quantity;
                shopName = cart.shopName;
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
                      height: 150,
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
                              height: 130,
                              width: 140,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CartItemRich(
                                    letterSpacing: .3,
                                    // boldFontSize: 17,
                                    lightFont: 'Name: ',
                                    boldFont: '${cart.name.toUpperCase()} (@$individualPrice)',
                                  ),
                                  CartItemRich(
                                    lightFont: 'By: ',
                                    boldFont: '${cart.shopName}',
                                  ),
                                  CartItemRich(
                                    lightFont: 'Selected Size: ',
                                    boldFont: '${cart.sizes}',
                                  ),
                                  CartItemRich(
                                    lightFont: 'Delivery: ',
                                    boldFont: '${cart.delivery}',
                                  ),
                                  CartItemRich(
                                    lightFont: 'Summary: ',
                                    boldFont: '(${cart.quantity} x $individualPrice) + ${cart.delivery}',
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CartItemRich(
                                          lightFont: 'Total: ',
                                          boldFont: '${cart.total}',
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            appProvider.changeLoadingState();
                                            bool success = await userProvider.removeFromCart(cartItem: userModelItem.cart[index]);
                                            if (success) {
                                              userProvider.updateUserModel();
                                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: Text(
                                                "Removed from Cart!",
                                                textAlign: TextAlign.center,
                                              )));
                                              appProvider.changeLoadingState();
                                              return;
                                            } else {
                                              appProvider.changeLoadingState();
                                            }
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: red,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: CustomText(
                          text: 'Your cart is empty',
                          textAlign: TextAlign.center,
                          color: white,
                        )));

                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                              child: Container(
                             
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: .3,
                                        text: 'You are going to pay Ksh${userModelItem.totalCartPrice} for this order',
                                        textAlign: TextAlign.center,
                                      ),
                                      FavoriteButton(
                                        icon: Icons.check,
                                        callback: () async {
                                          var uuid = Uuid();
                                          String id = uuid.v4();
                                          _orderServices.createOrder(
                                              userId: userProvider.user.uid,
                                              id: id,
                                              description: 'Paid Ksh${userModelItem.totalCartPrice}',
                                              status: "ONGOING",
                                              totalPrice: userProvider.userModel.totalCartPrice,
                                              cart: userProvider.userModel.cart);
                                          for (CartModel cartItem in userModelItem.cart) {
                                            bool value = await userProvider.removeFromCart(cartItem: cartItem);
                                            if (value) {
                                              userProvider.updateUserModel();
                                              print("Item added to orders");
                                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                                  content: CustomText(
                                                text: 'Order is being processed',
                                                textAlign: TextAlign.center,
                                                color: white,
                                              )));
                                            } else {
                                              print("ITEM WAS NOT REMOVED");
                                            }
                                          }
                                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Order created!")));
                                          Navigator.pop(context);
                                        },
                                        text: 'Accept',
                                        color: Colors.green,
                                      ),
                                      FavoriteButton(
                                        color: red,
                                        callback: () {
                                          Navigator.pop(context);
                                        },
                                        text: "Cancel",
                                        icon: Icons.cancel,
                                      )
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
