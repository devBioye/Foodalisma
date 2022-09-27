import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodalisma/screen/foodstore.dart';
import 'package:foodalisma/service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_paystack/flutter_paystack.dart';


class CartOut extends StatefulWidget {
  //const CartOut({Key? key}) : super(key: key);
  final String price;
  CartOut({this.price});

  @override
  _CartOutState createState() => _CartOutState();
}

class _CartOutState extends State<CartOut> {
  List cart = [];
  List name = [];
  List url = [];
  List price = [];
  List noOfMeal = [];
  final sum = [0.0];
  double addSum = 0;
  int no = 1;
  Future<String> cartList() async {
    if(no == 1){
      cart = await CartDetail().getFood();
      no++;
    }
    name.clear();
    url.clear();
    price.clear();
    noOfMeal.clear();
    sum.clear();

    for(int i = 0; i < cart.length; i++){
      fd = await cart[i];
      name.add(fd.name);
      url.add(fd.url);
      price.add(fd.price);
      noOfMeal.add(fd.add);
      sum.add(fd.price * fd.add);

      print(name[i]);
    }

   //print(sum[0]);
    return 'done';

  }
  FoodCollection fd;
  Future<void> addUp() async {


    addSum = sum.sum;
    print(addSum);

    // for(int i = 0; i < sum.length; i++)
    // {
    //   setState(() {
    //     addSum += sum[i];
    //   });
    //
    // }
    // print('done');
    // print(addSum);
  }
  int a= 0;
  var secretKey = 'Your secret key here';
  var publicKey = 'Your public key here';
  final plugin = PaystackPlugin();
  void paySection() async {
    Charge charge = Charge()
      ..amount = int.parse((addSum * 100).toStringAsFixed(0))
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
      ..email = 'developerbioye@gmail.com';
    CheckoutResponse response = await plugin.checkout(context, charge: charge, method: CheckoutMethod.card);
    print(response.message);
    if(response.message == 'Success') {
      setState(() {
        amount += 1000;
      });
    }
    //09/23
    //081
    //5078 5078 5078 5078 12




  }
  int amount = 0;

  @override
  void initState() {
    //cartList();
    plugin.initialize(publicKey: publicKey);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                      return FoodStore();
                    }));

                  }),
                 SizedBox(width: 10,),
                 Text('Cart', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),),
                ],
              ),
                width: MediaQuery.of(context).size.width),
            FutureBuilder(
              future: cartList(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return CircularProgressIndicator();
                }
                else {
                  addUp();
                  return SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 1.4,
                    child: ListView.builder(
                        itemCount: name.length,
                        scrollDirection: Axis.vertical,

                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.green[100]),
                                boxShadow: [
                                  BoxShadow(color: Colors.green.withOpacity(0.1),
                                      offset: Offset(0, 10),
                                      blurRadius: 10,
                                      spreadRadius: -10)
                                ]),

                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        url[index], height: 50, width: 50,),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.5,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(name[index], style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),),
                                          Text('NGN${price[index].toString()}'),
                                        ],
                                      ),
                                    ),
                                    Text('${noOfMeal[index].toString()}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Container(
                                  height: 25,
                                  child: ElevatedButton.icon(onPressed: () async {
                                    // name.removeAt(index);
                                    // price.removeAt(index);
                                    // url.removeAt(index);
                                    // noOfMeal.removeAt(index);
                                    cart.removeAt(index);
                                    await CartDetail.deleteItem(name[index]);
                                    setState(() {






                                    });

                                    //sum.clear();
                                  },
                                    label: Text('Remove this',
                                        style: TextStyle(color: Colors.grey)),
                                    icon: Icon(
                                      Icons.delete_rounded, color: Colors.grey,),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white),),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          );
                        }
                    ),
                  );
                }
              }
            ),
            Text("Calculate and Pay", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green[300])),
            Container(width: 250,
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    paySection();

                  });

                }, child: Text('Pay Now', style: TextStyle(fontWeight: FontWeight.bold),), style: ElevatedButton.styleFrom(primary: Colors.green),)),
          ],
        ),
      ),
    );
  }
}
