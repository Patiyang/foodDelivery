import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodDelivery/models/orders.dart';
import 'package:foodDelivery/provider/userProvider.dart';
import 'package:foodDelivery/widgets/customText.dart';

import '../../styling.dart';

class OrderItems extends StatefulWidget {
  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  UserProvider userProvider = new UserProvider.initialize();
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: userProvider.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = userProvider.orders[index];
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
              child: Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: grey.withOpacity(.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CartItemRich(lightFont: 'ID: ', boldFont: _order.id, boldFontSize: 17),
                    CartItemRich(lightFont: 'Details: ', boldFont: _order.description),
                    SizedBox(height: 10),
                    CartItemRich(
                        lightFont: 'Placed On: ',
                        boldFont: '${DateTime.fromMillisecondsSinceEpoch(_order.createdAt).toString()}'),
                    CartItemRich(lightFont: 'Status: ', boldFont: _order.status, color: Colors.green),
                    CartItemRich(lightFont: 'Order Total: ', boldFont: 'Rs. ${_order.total.toString()}', boldFontSize: 17),
                  ],
                ),
              ),
            );
          }),
    );
  }

  getOrders() async {
    await userProvider.getOrders();
    setState(() {
      
    });
  }
}
