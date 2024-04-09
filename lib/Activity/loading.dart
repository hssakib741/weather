import 'package:flutter/material.dart';
import 'package:weather/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String? temp;
  String? hum;
  String? air_speed;
  String? des;
  String? main;
  String? icon;
  String city="Dhaka";



  void startApp(String city) async
  {
    worker instance=worker(location: "$city");
    await instance.getData();

    temp=instance.temp;
    hum=instance.humity;
    air_speed=instance.air_speed;
    des=instance.description;
    main=instance.main;
    icon=instance.icon;

    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value" : main,
        "icon_value" : icon,
        "city_value": city,
      });
    });

  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? search = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (search != null && search.isNotEmpty) {
      city = search['searchText'] as String? ?? "Dhaka";
    }
   startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              SizedBox(height: 180,),
              Image.asset("images/wlogo.png",height: 270,width: 240,),
              Text("Weather App",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),),
              SizedBox(height: 7,),
              Text("Made By Sakib",style: TextStyle(
                fontSize: 16,
                  color: Colors.white,
                fontWeight: FontWeight.w400),),
              SizedBox(height: 50,),
              SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF88d7de),
    );

  }
}



