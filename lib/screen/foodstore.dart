import 'package:flutter/material.dart';
import 'package:foodalisma/screen/aboutfood.dart';
import 'package:foodalisma/screen/cart_out.dart';
import 'package:foodalisma/service.dart';

class FoodStore extends StatefulWidget {
  //const FoodStore({Key? key}) : super(key: key);
final bool isFav;
FoodStore({this.isFav});
  @override
  _FoodStoreState createState() => _FoodStoreState();
}

class _FoodStoreState extends State<FoodStore> {
  String currency = 'NGN';
  String location = '19b, Anu street, Ikotun, Lagos, Nigeria';
  int cartNo = 0;
  double height = 0;
  bool isHeight = false;
  TextEditingController txtCtrl;

  Color favColor = Colors.black;
  List<FoodCollection> foodcollection = [
    FoodCollection(name: 'Amala and Egusi', price: 2000.00, detail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', location: '19b, Anu street, Ikotun, Lagos, Nigeria', url: 'assets/Amala.jpg', add: 0, favColor: Colors.grey, isFav: true),
    FoodCollection(name: 'Beans and Plantain', price: 1200.00, detail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', location: '19b, Anu street, Ikotun, Lagos, Nigeria', url: 'assets/beans and dodo.png', add: 0, favColor: Colors.grey, isFav: true),
    FoodCollection(name: 'Ofada Rice', price: 1500.00, detail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', location: '19b, Anu street, Ikotun, Lagos, Nigeria', url: 'assets/ofadarice.png', add: 0, favColor: Colors.grey, isFav: true),
    FoodCollection(name: 'Wheat with Gbegiri Soup', price: 2000.00, detail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', location: '19b, Anu street, Ikotun, Lagos, Nigeria', url: 'assets/Yoruba-Foods_Ewedu-and-Gbegiri-soup.jpg', add: 0, favColor: Colors.grey, isFav: true),
    FoodCollection(name: 'Eba and Efo', price: 1000.00, detail: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt', location: '19b, Anu street, Ikotun, Lagos, Nigeria', url: 'assets/eba and efo.jpg', add: 0, favColor: Colors.grey, isFav: true)
  ];
  void aboutDeveloper(){
    Alert().showAlertDialog(context, 'About Developer', 'Cooked by Beeb Codes(Twitter handle: @Paza_Xs)');
  }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.16,
                      ),
                      IconButton(icon: Icon(Icons.search), onPressed: (){
                        setState(() {
                          if(!isHeight) {
                            height = 50;
                            isHeight = !isHeight;

                          }
                          else
                            {
                              height = 0;
                              isHeight = !isHeight;

                            }
                        });

                      }),
                    ],

                  ),

                ),
                SizedBox(height: 30),
                Container(
                  child: Column(
                    children: [
                      Text('Foodalisma', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', color: Colors.green[600]),),
                      Text('Buy your delicious meal now', style: TextStyle(fontSize: 10, fontFamily: 'JosefinSans-Font',),),
                    ],
                  ),
                ),
                Container(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    Container(
                      child: IconButton(icon: Icon(Icons.home),onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return FoodStore();
                        }));

                      },)
                    ),
                    Container(child: Row(
                      children: [
                        IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                            return CartOut();
                          }));

                        },),
                        Text(cartNo.toString(),style: TextStyle(fontSize: 12, color: Colors.red),),
                      ],
                    ),),
                    Container(child: IconButton(icon: Icon(Icons.info_rounded), onPressed: (){
                      aboutDeveloper();

                    },),),

                  ],)
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.36,
                    width: MediaQuery.of(context).size.width,
                    child:
                  GridView.builder(
                    itemCount: foodcollection.length,

                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height/0.75, ),
                      itemBuilder: (context, index){
                        return Container(

                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green)),
                          //width: 50,

                          child:
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 120),
                                IconButton(icon: Icon(Icons.favorite, color: foodcollection[index].favColor,), onPressed: (){
                                  if(!foodcollection[index].isFav)
                                    {
                                      setState(() {
                                        foodcollection[index].favColor = Colors.grey;
                                        foodcollection[index].isFav = !foodcollection[index].isFav;
                                      });
                                    }
                                  else
                                    {
                                      setState(() {
                                        foodcollection[index].favColor = Colors.red;
                                        foodcollection[index].isFav = !foodcollection[index].isFav;
                                      });
                                    }

                                })
                              ],
                            ),
                            GestureDetector(
                                onTap: (){
                                  print('next page');
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return AboutFood(name: foodcollection[index].name, detail: foodcollection[index].detail, url: foodcollection[index].url, price: foodcollection[index].price, location: foodcollection[index].location, isFav: foodcollection[index].isFav,);
                                  }));
                                },

                                child: Image.asset(foodcollection[index].url.toString(), height: 100, width: 140,)),
                            Container(
                              child: Column(
                                children: [
                                  Text(foodcollection[index].name.toString(), style: TextStyle(fontWeight: FontWeight.bold),),
                                  Row(
                                    children: [
                                      Text(' $currency${foodcollection[index].price}', style: TextStyle(fontSize: 12, color: Colors.green[300]),),
                                      SizedBox(height: 30),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            SizedBox(width: 45),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  foodcollection[index].add++;
                                                  cartNo++;
                                                });
                                                if(foodcollection[index].add == 1){
                                                  CartDetail.createItem(index, foodcollection[index].name, foodcollection[index].url, foodcollection[index].price.toString(), foodcollection[index].add.toString());
                                                }
                                                else if(foodcollection[index].add == 0){
                                                  CartDetail.deleteItem(foodcollection[index].name);
                                                }
                                                else{
                                                  CartDetail.updateMealNo(foodcollection[index].name, foodcollection[index].add.toString());
                                                }

                                              },
                                              child: Icon(Icons.add, size: 16,),
                                            ),
                                            SizedBox(width: 5,),

                                            Text(foodcollection[index].add.toString(), style: TextStyle(fontSize: 14)),
                                            SizedBox(width: 5,),
                                            GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  if(foodcollection[index].add == 0){

                                                  }
                                                  else {
                                                    foodcollection[index].add--;
                                                    cartNo--;
                                                  }
                                                });
                                                if(foodcollection[index].add == 1){
                                                  CartDetail.createItem(index, foodcollection[index].name, foodcollection[index].url, foodcollection[index].price.toString(), foodcollection[index].add.toString());
                                                }
                                                else if(foodcollection[index].add == 0){
                                                  CartDetail.deleteItem(foodcollection[index].name);
                                                }
                                                else{
                                                  CartDetail.updateMealNo(foodcollection[index].name, foodcollection[index].add.toString());

                                                }

                                              },
                                              child: Icon(Icons.remove, size: 16,),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                          ,);
                      })

                    ,),
                )

              ],
            ),
              AnimatedContainer(
                height: height,
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 40),
                duration: Duration(milliseconds: 800),
                child: Center(child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.4,
                    child: TextField(
                      controller: txtCtrl,
                      
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: 'Search for your food'),
                      style: TextStyle(fontSize: 22,),)))),
           ],
          ),
        ),
      ),
    );
  }
}
class Alert {
  showAlertDialog(BuildContext context, String header, String content) {
    AlertDialog alert = AlertDialog(title: Text(header),
      content: Text(content),
      actions: [
        ElevatedButton(child: Text('OK'), onPressed: () {
          Navigator.pop(context);
        },)
      ],);
    showDialog(context: context, builder: (BuildContext context) {
      return alert;
    });
  }
}