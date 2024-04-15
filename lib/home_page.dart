import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helios/order_page.dart';
import 'package:readmore/readmore.dart';

import 'auth/edit_profile_page.dart';
import 'constant/assets_path.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> pizzaList = [];
  List<dynamic> cartItem = [];
  String groupValue = "Regular";
  int qty = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
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
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfile(),
                  ));
            },
            icon: const Icon(Icons.account_circle,color: Colors.white,),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border,color: Colors.white,),
            ),
            // IconButton(onPressed: (){},icon: const Icon(Icons.shopping_cart_outlined),)
          ],
        ),
        body: Stack(
          children: [
            GridView.builder(
              itemCount: pizzaList.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.50,
              ),
              itemBuilder: (context, index) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          pizzaList[index]["PizzaImage"] ?? '',
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.20,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(pizzaList[index]["PizzaName"] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${pizzaList[index]["RegularPrice"] ?? ''} ₹",
                            style: const TextStyle(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.black26,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Container(
                                        height: 380,
                                        color: Colors.grey.shade200,
                                        // padding: EdgeInsets.symmetric(horizontal: 12),
                                        child: ListView(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  color: Colors.white,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 7),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                        child: Image.network(
                                                          pizzaList[index][
                                                          "PizzaImage"] ??
                                                              '',
                                                          width: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.20,
                                                          height: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height *
                                                              0.09,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                pizzaList[index]
                                                                [
                                                                "PizzaName"] ??
                                                                    '',
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                            const SizedBox(
                                                                height: 2),
                                                            ReadMoreText(
                                                              pizzaList[index][
                                                              "Ingredients"] ??
                                                                  '',
                                                              trimLines: 3,
                                                              colorClickableText:
                                                              Colors.pink,
                                                              trimMode:
                                                              TrimMode.Line,
                                                              trimCollapsedText:
                                                              'Read more',
                                                              trimExpandedText:
                                                              ' Read less',
                                                              moreStyle: const TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                              lessStyle: const TextStyle(
                                                                  color: Colors
                                                                      .blueGrey,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .favorite_border)),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                  child: Column(
                                                    children: [
                                                      ListTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Regular - ${pizzaList[index]["RegularPrice"] ??
                                                                  ''} ₹",
                                                              // style:  TextStyle(color: groupValue == "Regular" ? Colors.black :Colors.grey),
                                                            ),
                                                            Radio(
                                                              value: "Regular",
                                                              groupValue:
                                                              groupValue,
                                                              onChanged:
                                                                  (value) {
                                                                groupValue =
                                                                value!;
                                                                pizzaList[index]
                                                                [
                                                                'Price'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "RegularPrice"];
                                                                pizzaList[index]
                                                                [
                                                                'TotalPrice'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "RegularPrice"];
                                                                pizzaList[index]
                                                                ['Qty'] = 0;
                                                                setState(() {});
                                                              },
                                                              fillColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                        titleTextStyle: groupValue ==
                                                            "Regular"
                                                            ? const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)
                                                            : const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal),
                                                      ),
                                                      ListTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Medium - ${pizzaList[index]["MediumPrice"] ??
                                                                  ''} ₹",
                                                            ),
                                                            Radio(
                                                              value: "Medium",
                                                              groupValue:
                                                              groupValue,
                                                              onChanged:
                                                                  (value) {
                                                                groupValue =
                                                                value!;
                                                                pizzaList[index]
                                                                [
                                                                'Price'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "MediumPrice"];
                                                                pizzaList[index]
                                                                [
                                                                'TotalPrice'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "MediumPrice"];
                                                                pizzaList[index]
                                                                ['Qty'] = 0;
                                                                setState(() {});
                                                              },
                                                              fillColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                        titleTextStyle: groupValue ==
                                                            "Medium"
                                                            ? const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)
                                                            : const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal),
                                                      ),
                                                      ListTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Large - ${pizzaList[index]["LargePrice"] ??
                                                                  ''} ₹",
                                                            ),
                                                            Radio(
                                                              value: "Large",
                                                              groupValue:
                                                              groupValue,
                                                              onChanged:
                                                                  (value) {
                                                                groupValue =
                                                                value!;
                                                                pizzaList[index]
                                                                [
                                                                'Price'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "LargePrice"];
                                                                pizzaList[index]
                                                                [
                                                                'TotalPrice'] =
                                                                pizzaList[
                                                                index]
                                                                [
                                                                "LargePrice"];
                                                                pizzaList[index]
                                                                ['Qty'] = 0;
                                                                setState(() {});
                                                              },
                                                              fillColor:
                                                              const MaterialStatePropertyAll(
                                                                  Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                        titleTextStyle: groupValue ==
                                                            "Large"
                                                            ? const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)
                                                            : const TextStyle(
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  color: Colors.white,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 18,
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0xff023034)),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                12)),
                                                        child: Row(
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  if (pizzaList[
                                                                  index]
                                                                  [
                                                                  "Qty"] >
                                                                      0) {
                                                                    pizzaList[
                                                                    index]
                                                                    [
                                                                    "Qty"] =
                                                                        pizzaList[index]
                                                                        [
                                                                        "Qty"] -
                                                                            1;
                                                                    pizzaList[
                                                                    index]
                                                                    [
                                                                    "TotalPrice"] =
                                                                        int
                                                                            .parse(
                                                                            pizzaList[index]["Price"]
                                                                                .toString()) *
                                                                            int
                                                                                .parse(
                                                                                pizzaList[index]["Qty"]
                                                                                    .toString());
                                                                    qty =
                                                                    pizzaList[
                                                                    index]
                                                                    ["Qty"];
                                                                    setState(
                                                                            () {});
                                                                  }
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .remove)),
                                                            Text(pizzaList[
                                                            index]
                                                            ["Qty"]
                                                                .toString()),
                                                            IconButton(
                                                                onPressed: () {
                                                                  pizzaList[
                                                                  index]
                                                                  [
                                                                  "Qty"] =
                                                                      pizzaList[
                                                                      index]
                                                                      [
                                                                      "Qty"] +
                                                                          1;
                                                                  pizzaList[
                                                                  index]
                                                                  [
                                                                  'TotalPrice'] =
                                                                      int.parse(
                                                                          pizzaList[index]
                                                                          [
                                                                          'Price']
                                                                              .toString()) *
                                                                          int
                                                                              .parse(
                                                                              pizzaList[index]
                                                                              [
                                                                              "Qty"]
                                                                                  .toString());
                                                                  qty =
                                                                  pizzaList[
                                                                  index]
                                                                  ["Qty"];
                                                                  setState(
                                                                          () {});
                                                                },
                                                                icon: const Icon(
                                                                    Icons.add)),
                                                          ],
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          getQty();
                                                          pizzaList[index]
                                                          ['Qty'] >
                                                              0
                                                              ? Navigator.pop(
                                                              context)
                                                              :
                                                          ScaffoldMessenger.of(
                                                              context)
                                                              .showSnackBar(
                                                              const SnackBar(
                                                                  backgroundColor: Colors
                                                                      .red,

                                                                  margin: EdgeInsets
                                                                      .only(
                                                                      bottom:
                                                                      330),
                                                                  duration: Duration(
                                                                      seconds:
                                                                      1),
                                                                  behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                                  content:
                                                                  Center(
                                                                    child: Text(
                                                                      'Please Add Quantity',
                                                                      style: TextStyle(
                                                                          fontSize: 18,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                    ),
                                                                  )));
                                                        },
                                                        child: Container(
                                                          margin:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              18),
                                                          padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                              18,
                                                              vertical: 18),
                                                          decoration: BoxDecoration(
                                                              color: const Color(
                                                                  0xff023034),
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  12)),
                                                          child: Row(
                                                            children: [
                                                              pizzaList[index][
                                                              "Qty"] >
                                                                  0
                                                                  ? Text(
                                                                  "Add Item ₹${pizzaList[index]["TotalPrice"]
                                                                      .toString()}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white))
                                                                  : Text(
                                                                  "Add item",
                                                                  style: const TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white)),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                  color: const Color(0xff023034),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text("Add",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
            qty > 0
                ? Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  for (int i = 0; i < pizzaList.length; i++) {
                    // FirebaseFirestore.instance.collection("AddedItem").where("ProductId",isEqualTo: pizzaList[i]['id']).get();
                    if (int.parse(pizzaList[i]['Qty'].toString()) > 0) {
                      FirebaseFirestore.instance
                          .collection("AddedItem")
                          .add({
                        "ProductId": pizzaList[i]['id'],
                        "Qty": pizzaList[i]['Qty'],
                        "Size": groupValue
                      });
                    }
                  }
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderPage(),
                      ));
                },
                child: Container(
                  height: 80,
                  color: const Color(0xff023034),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("$qty item added",
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      const SizedBox(
                        width: 7,
                      ),
                      const Icon(Icons.arrow_circle_right,
                          color: Colors.white, size: 25)
                    ],
                  ),
                ),
              ),
            )
                : const SizedBox.shrink()
          ],
        ));
  }

  void getQty() {
    qty = 0;
    for (int i = 0; i < pizzaList.length; i++) {
      qty = qty + int.parse(pizzaList[i]['Qty'].toString());
    }
    setState(() {});
  }

  // void addToItem() {
  //   qty = 0;
  //   for (int i = 0; i < pizzaList.length; i++) {
  //     if (int.parse(pizzaList[i]['Qty'].toString()) > 0) {
  //       cartItem.add(pizzaList[i]);
  //     }
  //   }
  // }

  Future<void> getProduct() async {
    pizzaList.clear();
    QuerySnapshot<Map<String, dynamic>> list =
    await FirebaseFirestore.instance.collection("Product").get();
    for (int i = 0; i < list.docs.length; i++) {
      var map = list.docs[i].data();
      map['id'] = list.docs[i].id;
      map['Qty'] = 0;
      map['TotalPrice'] = list.docs[i]['RegularPrice'];
      map['Price'] = list.docs[i]['RegularPrice'];
      pizzaList.add(map);
    }
    setState(() {});
  }
}
