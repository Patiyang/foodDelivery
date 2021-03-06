import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/products.dart';
import 'package:foodDelivery/provider/appProvider.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/screens/home.dart';
import 'package:foodDelivery/screens/homeNavigation.dart';
import 'package:foodDelivery/screens/manageOrders/orders.dart';
import 'package:foodDelivery/widgets/changeScreen.dart';
import 'package:foodDelivery/widgets/customText.dart';
import 'package:foodDelivery/widgets/favoritesButton.dart';
import 'package:foodDelivery/widgets/loading.dart';
import 'package:foodDelivery/widgets/textField.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styling.dart';
import '../manageOrders/cartScreen.dart';

class SingleProduct extends StatefulWidget {
  final ProductsModel productsModel;

  const SingleProduct({Key key, this.productsModel}) : super(key: key);
  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  List<DropdownMenuItem<String>> sizesList = <DropdownMenuItem<String>>[];
  final TextEditingController quantityController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String currentSize = '';
  @override
  void initState() {
    sizesList = getDropDownItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final appProvider = Provider.of<AppProvider>(context);
    var singleProduct = widget.productsModel;
    var carousel = Carousel(
      dotBgColor: Colors.transparent,
      indicatorBgPadding: 5,
      overlayShadow: false,
      borderRadius: false,
      dotSize: 3,
      animationCurve: Curves.easeOutQuart,
      autoplay: false,
      animationDuration: Duration(milliseconds: 1000),
      images: [
        for (int i = 0; i < singleProduct.images.length; i++)
          Container(
            child: Image.network(singleProduct.images[i], fit: BoxFit.cover),
            foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [black.withOpacity(.1), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
      ],
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: '${singleProduct.id}',
          child: Text(singleProduct.name),
        ),
        actions: [
          IconButton(icon: Icon(Icons.map), onPressed: () {}),
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () => changeScreen(context, ManageOrders()))
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  child: GridTile(
                    child: Stack(
                      children: [
                        carousel,
                      ],
                    ),
                    footer: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 40,
                      color: black.withOpacity(.6),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            size: 17,
                            text: singleProduct.name,
                            color: white,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: 'Ksh: ${singleProduct.price}',
                            color: orange,
                            fontWeight: FontWeight.bold,
                            size: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Remaining: ',
                          style: TextStyle(
                            color: black,
                          )),
                      TextSpan(text: '${singleProduct.quantity}', style: TextStyle(color: orange, fontWeight: FontWeight.bold))
                    ])),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Delivery: ',
                          style: TextStyle(
                            color: black,
                          )),
                      TextSpan(
                          text: 'Ksh ${singleProduct.delivery}', style: TextStyle(color: orange, fontWeight: FontWeight.bold))
                    ])),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: 'Select Size: '),
                  DropdownButton(
                    hint: Text('Sizes'),
                    icon: Icon(Icons.branding_watermark),
                    iconSize: 12,
                    style: TextStyle(color: black),
                    items: sizesList,
                    onChanged: changeSelectedSize,
                    value: currentSize,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: CustomTextField(
                  validator: (v) {
                    if (int.parse(quantityController.text) > singleProduct.quantity) return 'the size picked is out of range';
                  },
                  controller: quantityController,
                  radius: 17,
                  containerColor: grey[200],
                  hint: 'Quantity',
                ),
              ),

              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: CustomText(text: '${singleProduct.description}', maxLines: 20),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: FlatButton.icon(
                        color: orange[200],
                        icon: Icon(Icons.add_shopping_cart, color: black, size: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () async {
                          appProvider.changeLoadingState();
                          if (formKey.currentState.validate()) {
                            bool productAdded = await userProvider.addItemToCart(
                                product: singleProduct, size: currentSize, quantity: int.parse(quantityController.text));
                            if (productAdded == true) {
                              final snackBar = SnackBar(
                                  content: Text(
                                'Product added to cart',
                                textAlign: TextAlign.center,
                              ));
                              scaffoldKey.currentState.showSnackBar(snackBar);
                              userProvider.updateUserModel().then((value) => showDialog(
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
                                                text: 'What would you like to do?',
                                                textAlign: TextAlign.center,
                                              ),
                                              FavoriteButton(
                                                icon: Icons.check,
                                                callback: () async {
                                                  changeScreenReplacement(context, ManageOrders());
                                                },
                                                text: 'Proceed to Cart',
                                                color: orange[500],
                                              ),
                                              FavoriteButton(
                                                color: orange[500],
                                                callback: () {
                                                  changeScreenReplacement(context, HomeNavigation());
                                                },
                                                text: "Continue Shopping",
                                                icon: Icons.cancel,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                              appProvider.changeLoadingState();
                            } else {
                              final snackBar = SnackBar(
                                  content: Text(
                                'Product not added to cart',
                                textAlign: TextAlign.center,
                              ));
                              scaffoldKey.currentState.showSnackBar(snackBar);
                              appProvider.changeLoadingState();
                            }
                          }
                        },
                        label: appProvider.isLoading
                            ? Loading(
                                // text: 'Please wait...',
                                )
                            : CustomText(text: 'add to cart'),
                      ),
                    ),
                    Container(
                      child: FlatButton.icon(
                        color: orange[200],
                        icon: Icon(Icons.favorite_border, color: black, size: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                        onPressed: () {},
                        label: CustomText(
                          maxLines: 2,
                          text: 'Add to Favorites',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),
              Divider(),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Vendor: ', style: TextStyle(color: black)),
                TextSpan(
                    text: '${singleProduct.shopName}', style: TextStyle(color: black, fontSize: 15, fontWeight: FontWeight.bold))
              ])),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15),
                  FlatButton.icon(
                      color: orange[200],
                      icon: Icon(Icons.phone, color: black, size: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () {
                        triggerPhone(singleProduct.phone);
                      },
                      label: CustomText(
                        text: 'Call',
                      )),
                  SizedBox(width: 15),
                  FlatButton.icon(
                      color: orange[200],
                      icon: Icon(Icons.message, color: black, size: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                      onPressed: () {
                        triggerMessage(singleProduct.phone);
                      },
                      label: CustomText(
                        text: 'Text',
                      ))
                ],
              ),
              Divider(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                // width: MediaQuery.of(context).size.width - 16,
                child: Row(
                  children: <Widget>[
                    CustomText(
                      text: 'Similar Products',
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    // GestureDetector(child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> items = new List();
    var singleProduct = widget.productsModel;
    for (int i = 0; i < singleProduct.sizes.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(singleProduct.sizes[i]),
              value: singleProduct.sizes[i],
            ));
        currentSize = singleProduct.sizes[i];
      });
    }
    sizesList = items;
    return items;
  }

  changeSelectedSize(String value) {
    setState(() {
      currentSize = value;
      print(currentSize);
    });
  }

  triggerPhone(String phoneNumber) async {
    var url = "tel:$phoneNumber";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot launch $url';
    }
  }

  triggerMessage(String message) async {
    var url = "sms:$message";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Cannot launch $url';
    }
  }
}
