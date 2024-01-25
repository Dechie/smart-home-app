import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_better/providers/device_state.dart';
import 'package:smart_home_better/services/api.dart';

import '../../models/home_interior.dart';
import '../../utils/constants.dart';
import 'home_details.dart';

class KitchenDetails extends StatefulWidget {
  const KitchenDetails({
    super.key,
    required this.homeInterior,
  });

  final HomeInterior homeInterior;
  @override
  State<KitchenDetails> createState() => _KitchenDetailsState();
}

class _KitchenDetailsState extends State<KitchenDetails> {
  late HomeInterior homeInterior = widget.homeInterior;

  String fireStatus = 'safe';

  Map stateColor = {
    'safe': Colors.green,
    'FIRE': Colors.red,
  };
  void fetcher() async {
    String fire = await fetchFireStatus();
    print('firee: $fire');

    setState(() {
      fireStatus = fire;
    });
    print('firee: $fireStatus');
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        fetcher();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<bool, String> stateMap = {
      true: "On",
      false: "Off",
    };
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<DeviceProvider>(
        builder: (context, deviceProvider, child) => SafeArea(
            child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset(
                    homeInterior.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: height / 2,
                  ),
                  SizedBox(
                    height: height / 2,
                    width: double.infinity,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: bgColor,
                        boxShadow: [
                          BoxShadow(
                            color: bgColor,
                            blurRadius: 30,
                            spreadRadius: 25,
                            offset: Offset(5, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 100,
                              spreadRadius: 100,
                              offset: const Offset(5, 0),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: TitleText(
                                color: Colors.white,
                                text: homeInterior.title,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height / 2 - 120),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: stateMap[
                                          homeInterior.boolHumidifier]!,
                                      fontSize: 22,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/LED.svg'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Expanded(
                                  child: TitleText(
                                    text: 'Light',
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black12,
                                ),
                                const SizedBox(height: defaultPadding / 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: 'Mode',
                                      fontSize: 18,
                                      color: Colors.black54,
                                    ),
                                    GFToggle(
                                      onChanged: (bool? value) {
                                        turnOnLed(value!, 3);
                                        deviceProvider.switchLed(ledNum: 3);
                                        setState(() {
                                          homeInterior.boolHumidifier = value;
                                        });
                                        //sendRequest(value!);
                                      },
                                      //value: homeInterior.boolHumidifier!,
                                      //value: false,
                                      value: deviceProvider.leds[2],
                                      enabledTrackColor: secondaryColor,
                                      enabledThumbColor: primaryColor,
                                      type: GFToggleType.ios,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultPadding),
                        Expanded(
                          child: Container(
                            height: 200,
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(33),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleText(
                                      text: fireStatus,
                                      color: stateColor[fireStatus],
                                      fontSize: 22,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/fire_alarm.svg'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Expanded(
                                  child: TitleText(
                                    text: 'Fire Alarm',
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
