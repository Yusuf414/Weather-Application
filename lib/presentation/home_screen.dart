import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather_app/data/model/current_weather_data.dart';
import 'package:weather_app/data/model/five_days_data.dart';
import 'package:weather_app/logic/home_logic/home_controller.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomeController>(
        builder: (controller) => Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/try.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Stack(
                  children: [
                    //  Padding(
                    //    padding: const EdgeInsets.only(top:30,left:300),
                    //    child: IconButton(
                    //                                 splashColor: Colors.green,
                    //                                   onPressed: () {
                    //                                     controller.city =
                    //                                         controller
                    //                                             .cityLocation;
                    //                                     print("hello");
                    //                                     controller
                    //                                         .updateWeather();
                    //                                   },
                    //                                   icon: Icon(
                    //                                     Icons.location_on,
                    //                                     color: Colors.blue,
                    //                                   )),
                    //  ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            padding: const EdgeInsets.only(
                              top: 30,
                            ),
                            child: TextField(
                              onChanged: (value) => controller.city = value,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) {
                                controller.city = value;
                                controller.updateWeather();
                              },
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'flutterfonts.ttf'),
                                hintText: 'SEARCH',
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                controller.city = controller.cityLocation;
                                controller.updateWeather();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Get My',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'flutterfonts.ttf'),
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: BoxConstraints(),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.9),
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: OverflowBox(
                          minWidth: 0.0,
                          maxWidth: MediaQuery.of(context).size.width,
                          minHeight: 0.0,
                          maxHeight: MediaQuery.of(context).size.height / 4,
                          child: Stack(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                width: double.infinity,
                                height: double.infinity,
                                child: Card(
                                  color: Colors.white,
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                              

                                                Text(
                                                  (controller.currentWeatherData !=
                                                          null)
                                                      ? '${controller.city}'
                                                          .toUpperCase()
                                                      : 'loading',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'flutterfonts'),
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Text(
                                                DateFormat()
                                                    .add_MMMMEEEEd()
                                                    .format(DateTime.now()),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption!
                                                    .copyWith(
                                                      color: Colors.black45,
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'flutterfonts',
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Column(
                                              children: [
                                                Text(
                                                  (controller.currentWeatherData
                                                              .weather !=
                                                          null)
                                                      ? '${controller.currentWeatherData.weather![0].description}'
                                                      : '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                          color: Colors.black45,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'flutterfonts'),
                                                ),
                                                Text(
                                                  (controller.currentWeatherData
                                                              .main !=
                                                          null)
                                                      ? '${(controller.currentWeatherData.main!.temp! - 273.15).round().toString()}\u2103'
                                                      : '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline2!
                                                      .copyWith(
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24,
                                                          fontFamily:
                                                              'flutterfonts'),
                                                ),
                                                Text(
                                                  (controller.currentWeatherData
                                                              .main !=
                                                          null)
                                                      ? 'min: ${(controller.currentWeatherData.main!.tempMin! - 273.15).round().toString()}\u2103 / max: ${(controller.currentWeatherData.main!.tempMax! - 273.15).round().toString()}\u2103'
                                                      : '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .copyWith(
                                                          color: Colors.black45,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'flutterfonts'),
                                                ),
                                                // SizedBox(height: 20),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: (controller
                                                                      .currentWeatherData
                                                                      .weather !=
                                                                  null)
                                                              ? controller.selectImageForWeather(
                                                                  controller
                                                                      .currentWeatherData
                                                                      .weather![
                                                                          0]
                                                                      .icon!)
                                                              : AssetImage(
                                                                  'assets/images/default.png'),
                                                          fit: BoxFit.contain),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      (controller.currentWeatherData
                                                                  .wind !=
                                                              null)
                                                          ? 'wind ${controller.currentWeatherData.wind!.speed!} m/s'
                                                          : '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'flutterfonts'),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "other cities".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'flutterfonts'),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 170,
                              child: ListView.separated(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.dataList.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  CurrentWeatherData? data;
                                  (controller.dataList.length > 0)
                                      ? data = controller.dataList[index]
                                      : data = null;
                                  return Container(
                                    width: 140,
                                    height: 150,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              (data != null)
                                                  ? "${data.name}"
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          'flutterfonts'),
                                            ),
                                            Text(
                                              (data != null)
                                                  ? "${(data.main!.temp! - 273.15).round().toString()}\u2103"
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily:
                                                          'flutterfonts'),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: (data != null)
                                                      ? controller
                                                          .selectImageForWeather(
                                                              data.weather![0]
                                                                  .icon!)
                                                      : AssetImage(
                                                          'assets/images/default.png'),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              (data != null)
                                                  ? "${data.weather![0].description}"
                                                  : '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption!
                                                  .copyWith(
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'flutterfonts'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'forcast next 5 days'.toUpperCase(),
                                    style:Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        fontFamily: 'flutterfonts'),
                                  ),
                                  Icon(
                                    Icons.next_plan_outlined,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: SfCartesianChart(
                                  primaryXAxis: CategoryAxis(),
                                  series: <ChartSeries<FiveDayData, String>>[
                                    SplineSeries<FiveDayData, String>(
                                      dataSource: controller.fiveDaysData,
                                      xValueMapper: (FiveDayData f, _) =>
                                          f.dateTime,
                                      yValueMapper: (FiveDayData f, _) =>
                                          f.temp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
