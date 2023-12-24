import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:velocity/consts/images.dart';
import 'package:velocity/consts/strings.dart';
import 'package:velocity/controller/home_controller.dart';
import 'package:velocity/models/current_weather_model.dart';
import 'package:velocity/sevices/api_services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = Get.put(HomeController());
  Widget build(BuildContext context) {
    var date = DateFormat('yMMMd').format(DateTime.now());

    var theme = Theme.of(context);
    var hourData;

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            '$date',
            style: TextStyle(color: theme.primaryColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  homeController.changeTheme();
                },
                icon: Icon(
                  homeController.changeThemeIcon(),
                  color: theme.iconTheme.color,
                )),
            IconButton(
              onPressed: () async {
                homeController.searchWeather();
              },
              icon: Icon(
                Icons.search,
                color: theme.iconTheme.color,
              ),
            ),
            IconButton(
              onPressed: () {
                homeController.currentLocation();
              },
              icon: Icon(
                Icons.my_location_rounded,
                color: theme.iconTheme.color,
              ),
            )
          ],
        ),
        body: GetBuilder<HomeController>(builder: (context) {
          return homeController.loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: homeController.currentweatherdataList.length,
                  itemBuilder: (context, index) {
                    CurrentWeatherData data =
                        homeController.currentweatherdataList[index];
                    var forecastdayList = data.forecast?.forecastday;

                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.location!.name.toString(),
                                style: TextStyle(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: Vx.dp12,
                                    fontSize: 32),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        'https:${data.current!.condition!.icon}',
                                        width: 70,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, right: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${data.current!.tempC.toString()}$degree',
                                                style: TextStyle(
                                                  color: theme.primaryColor,
                                                  fontSize: 54,
                                                ),
                                              ),
                                              Text(
                                                data.current!.condition!.text
                                                    .toString(),
                                                style: TextStyle(
                                                  color: theme.primaryColor,
                                                  fontSize: 14,
                                                  letterSpacing: Vx.dp6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          clouds,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.current!.cloud.toString(),
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          humidity,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        data.current!.humidity.toString(),
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          windspeed,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        " ${data.current!.windKph.toString()}km/h",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              SizedBox(
                                height: 150,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: data.forecast!.forecastday![index]
                                      .hour!.length,
                                  itemBuilder: (context, hourIndex) {
                                    hourData = data.forecast!
                                        .forecastday![index].hour![hourIndex];

                                    return Container(
                                      width: 100,
                                      padding: EdgeInsets.all(8),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[200],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            DateFormat.jm().format(
                                                DateTime.parse(hourData.time!)),
                                            style: TextStyle(
                                                color: Colors.grey[200]),
                                          ),
                                          Image.network(
                                            'https:${hourData.condition!.icon}',
                                            width: 80,
                                          ),
                                          Text(
                                            '${hourData.tempC.toString()}$degree',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                color: Colors.transparent,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Next 3 days',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: theme.iconTheme.color),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.forecast!.forecastday!.length,
                                itemBuilder: (context, index) {
                                  var day = data.forecast!.forecastday![index];

                                  return Card(
                                    color: theme.cardColor,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            DateFormat.MMMEd().format(
                                                DateTime.parse(
                                                    day.date.toString())),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: theme.primaryColor),
                                          ),
                                          Expanded(
                                            child: TextButton.icon(
                                                onPressed: () {},
                                                icon: Image.network(
                                                  'https:${day.day!.condition!.icon.toString()}',
                                                  width: 40,
                                                ),
                                                label: Text(
                                                  day.day!.condition!.text
                                                      .toString(),
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      color: Colors.grey[400],
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )),
                                          ),
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text:
                                                    '${day.day!.maxtempC.toString()}$degree/',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        theme.iconTheme.color)),
                                            TextSpan(
                                                text:
                                                    '${day.day!.mintempC.toString()}$degree',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                        theme.iconTheme.color))
                                          ]))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
        }));
  }
}
