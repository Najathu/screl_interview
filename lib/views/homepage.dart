import 'package:flutter/material.dart';
import 'package:screl_interview/views/search.dart';
import 'package:screl_interview/views/whether_widget.dart';

class HomePage extends StatelessWidget {
final String imgurl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDIzIHeThJx7V_Pku4j7Sn-nwT_vcvEafzhQ&usqp=CAU';
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF0277BD),
        title:Text('Weather App'),

        actions: [
          IconButton( onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherPage()));
          }, icon: Icon(Icons.search),)
        ],),


      body:Container(constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(imgurl),
    fit: BoxFit.fill,
    ),),


   child: WeatherWidget(), )
    );
  }
}