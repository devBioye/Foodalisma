import 'package:flutter/material.dart';
import 'package:foodalisma/screen/foodstore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashWidget extends StatelessWidget {
  //const SplashWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 140,
              width: 180,
              child: Image.asset('assets/beans and dodo.png', fit: BoxFit.fill,)),
          SizedBox(height: 30),
          Container(

              child: Text('Foodalisma', style: TextStyle(fontFamily: 'Montserrat', letterSpacing: 1, fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)),
          Container(margin: EdgeInsets.only(left: 60), child: Text('Order your food now!', style: TextStyle(fontSize: 7, color: Colors.white54),),)


        ],
      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:
      Container(
        decoration: BoxDecoration(
           gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.pink[800],
                  Colors.red[200],

                ]
            ),
            boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.5), offset: Offset(0, 25),blurRadius: 3, spreadRadius: -10)]),
        width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/4),
          SplashWidget(),
          SizedBox(height: 100,),
          Container(
            width: 220,
            height: 45,
            child: ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                return FoodStore();
              }));

            },
    child: Text('Buy Food', style: TextStyle(color: Colors.red)),
    style: ElevatedButton.styleFrom(primary: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),)
            ),
          ),],
      ),
    ),);
  }
}


