import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'constant/assets_path.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  List<Map<String, dynamic>> addedPizzaList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
    addedPizzaList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff023034),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset(
            appBarNameTag,
            height: 130,
            width: 130,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListView.builder(
            itemCount: addedPizzaList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey, spreadRadius: 2, blurRadius: 2)
                    ]),
                child: Column(
                  children: [
                    Text(addedPizzaList[index]['Qty'].toString() ??""),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }



  Future<void> getProduct() async {
    addedPizzaList.clear();
    QuerySnapshot<Map<String, dynamic>> list =
        await FirebaseFirestore.instance.collection("AddedItem").get();
    for (int i = 0; i < list.docs.length; i++) {
      var map = list.docs[i].data();
      map['id'] = list.docs[i].id;
      addedPizzaList.add(map);
    }
    setState(() {});
  }
}
