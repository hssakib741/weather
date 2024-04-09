import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This Init state");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("set state call");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    var city_Name = ["Dhaka", "Chittagong", "Khulna", "Rajshahi", "Sylhet", "Barisal", "Rangpur",
      "Comilla", "Mymensingh", "Narayanganj", "Gazipur", "Jessore", "Bogra", "Dinajpur",
      "Cox's Bazar", "Tangail", "Jamalpur", "Pabna", "Naogaon", "Faridpur", "Satkhira",
      "Kushtia", "Sirajganj", "Brahmanbaria", "Joypurhat", "Narail", "Chapainawabganj",
      "Feni", "Sunamganj", "Noakhali", "Pirojpur", "Magura", "Narsingdi", "Bhola",
      "Jhalokati", "Patuakhali", "Thakurgaon", "Sherpur", "Lalmonirhat", "Habiganj",
      "Kurigram", "Meherpur", "Chuadanga", "Gaibandha", "Nilphamari", "Laxmipur",
      "Madaripur", "Rajbari", "Shariatpur", "Manikganj", "Khagrachari", "Bagerhat",
      "Satkania", "Bandarban", "Kishoreganj", "Bhairab", "Maulvibazar", "Shahzadpur",
      "Rangamati", "Gopalganj"];
    final random = new Random();
    var city = city_Name[random.nextInt(city_Name.length)];
    Map info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp = (info["temp_value"]).toString();
    String air = (info["air_speed_value"]).toString().substring(0, 4);
    if(temp=="NA")
    {
      print("NA");
    }
    else{
      temp = (info["temp_value"]).toString().substring(0,4);
      air = (info["air_speed_value"]).toString().substring(0, 4);
    }
    String icon = info['icon_value'];
    String getcity = info['city_value'];
    String hum = info['hum_value'];

    String des = info['des_value'];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Color(0xFF88d7de),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF88d7de), Color(0xFF91B8F1)])),
            child: Column(
              children: [
                Container(
                  //Search Conatainer
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if((searchController.text).replaceAll(" ", "") =="")
                          {
                            print("Blank");
                          }
                          else{
                            String searchText = searchController.text.toLowerCase();
                            Navigator.pushReplacementNamed(context, "/loading", arguments: {
                              "searchText": searchText,
                            });
                          }
                        },
                        child: Container(
                          child: Icon(Icons.search),
                          margin: EdgeInsets.fromLTRB(4, 0, 8, 0),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Search $city"),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white.withOpacity(0.5)),
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Image.network(
                                'https://openweathermap.org/img/wn/$icon@2x.png',
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "$des",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "$getcity",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin:
                        EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(
                                      fontSize: 90, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "C",
                                  style: TextStyle(
                                      fontSize: 45, fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(20),
                        height: 250,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.windy),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$air",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("km/hr")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white.withOpacity(0.5)),
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        padding: EdgeInsets.all(20),
                        height: 250,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(WeatherIcons.humidity),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "$hum",
                              style: TextStyle(
                                  fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                            Text("Percent")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Sakib "),
                      Text("Data Provide By OpenWeathermap.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}