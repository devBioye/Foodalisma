import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutFood extends StatefulWidget {
  //const AboutFood({Key? key}) : super(key: key);
  final String name;
  final double price;
  final String url;
  final String detail;
  final String location;
  final bool isFav;
  AboutFood({this.name, this.price, this.url, this.detail, this.location, this.isFav});


  @override
  _AboutFoodState createState() => _AboutFoodState();
}

class _AboutFoodState extends State<AboutFood> {
  Color favorite;
  bool isFav = true;
  @override
  void initState() {
    isFav = widget.isFav;
    if(isFav){
      favorite = Colors.white;
    }
    else{
      favorite = Colors.red;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(isFav);
    return Scaffold(
        body:
        Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(widget.url),fit: BoxFit.cover),

                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height/2.6,),
                  Row(
                    children: [
                      IconButton(
                        color: Colors.white,
                          icon: Icon(Icons.arrow_back_ios_rounded,size: 35,), onPressed: (){
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return FoodStore();
                          // }));
                        Navigator.pop(context);

                      }),
                      SizedBox(width: MediaQuery.of(context).size.width/1.4),
                      IconButton(
                          color: favorite,
                          icon: Icon(Icons.favorite, size: 35,), onPressed: (){



                            print(widget.isFav);

                            print(isFav);
                        if(!isFav)
                        {
                          setState(() {

                            favorite = Colors.white;
                            isFav = !isFav;
                          });
                        }
                        else
                        {
                          setState(() {
                            favorite = Colors.red;
                            isFav = !isFav;
                          });
                        }

                      }),

                    ],
                  )
                ],),
                height: MediaQuery.of(context).size.height/2.1,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.6),
                      child: Text(widget.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  Container(
                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.45),
                      child: Text('NGN${widget.price.toString()}', style: TextStyle(color: Colors.green),)),
                ],
              ),
              SizedBox(height: 17,),
              Container(
                  child:
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.6),
                          child: Text('Ingredient', style: TextStyle(fontFamily: 'Montserrat',fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green[300]),)),
                      Container(
                        width: MediaQuery.of(context).size.width/1.2,
                         margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/11.4),
                          child: Text(widget.detail, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),)),
                    ],
                  ),
              ),
              SizedBox(height: 35,),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18),
                        child: Icon(Icons.location_on, size: 35, color: Colors.green[400],), decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.green[200])),),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                           margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
                            child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'JosefinSans-Font'))),
                        Container(
                            //margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 3.4),
                            child: Text(widget.location))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 18),
                      child: Icon(Icons.delivery_dining, size: 35,), decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),border: Border.all(color: Colors.green[200])),),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 2),
                            child: Text('Delivery Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, fontFamily: 'JosefinSans-Font'))),
                        Container(
                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width / 1.65),
                            child: Text('05:00PM'))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),


    ));
  }
}
