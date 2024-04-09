import 'package:http/http.dart';
import 'dart:convert';
import 'secrets.dart';



class worker{


  String? location;
  worker({this.location})
  {
    location=this.location;
  }


  String? temp;
  String? humity;
  String? air_speed;
  String? description;
  String? main;
  String? icon;

  Future<void> getData() async
  {
    try{
      Response response=await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$openWeatherMapApiKey"));
      Map data= jsonDecode(response.body);

      print(data);

      //Getting temp,humidity
      Map temp_data=data['main'];
      double get_Temp=temp_data['temp']-273.15;
      String get_Humidity=temp_data['humidity'].toString();

      //getting air_speed
      Map wind=data['wind'];
      double get_air_speed=wind['speed']/0.27777777777778;

      //getting deecription
      List weather_data=data['weather'];
      Map weather_main_data=weather_data[0];
      String get_main_des=weather_main_data['main'];
      String get_desc=weather_main_data['description'];



      //assign value
      temp=get_Temp.toString();
      humity=get_Humidity;
      air_speed=get_air_speed.toString();
      description=get_desc.toString();
      main=get_main_des.toString();
      icon=weather_main_data["icon"].toString();
    }
    catch(e){
      temp="NA";
      humity="NA";
      air_speed="NA";
      description="NA";
      main="NA";
      icon="03";
    }



  }

}

