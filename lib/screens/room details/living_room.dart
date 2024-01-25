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

class LivingRoomDetails extends StatefulWidget {
  const LivingRoomDetails({
    super.key,
    required this.homeInterior,
  });

  final HomeInterior homeInterior;
  @override
  State<LivingRoomDetails> createState() => _LivingRoomDetailsState();
}

class _LivingRoomDetailsState extends State<LivingRoomDetails> {
  late HomeInterior homeInterior = widget.homeInterior;

  bool tvTurnedOn = false;
  bool lampTurnedOn = false;
  String fanStatus = 'off';
  double temperature = 0;
  double previousTemp = 0;
  bool increase = false;
  bool fanIsOn = false;
  void fetcher() async {
    String fan = await fetchFanStatus();
    print('fann: $fan');
    double temp = await fetchTemperature();
    previousTemp = temperature;

    setState(() {
      //fanStatus = fan == 'on' ? 'on' : 'off';
      fanStatus = fan;
      temperature = temp;
      increase = previousTemp < temperature;
      fanIsOn = fan == 'on';
    });
    print('fan: $fanStatus, temp: $temperature');
  }

  @override
  void initState() {
    super.initState();
    fetcher();
    Timer.periodic(
      const Duration(seconds: 3),
      (Timer timer) {
        fetcher();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<bool, String> stateMap = {
      true: "on",
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
                                      text: stateMap[lampTurnedOn]!,
                                      fontSize: 26,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/television.svg'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Expanded(
                                  child: TitleText(
                                    text: 'Television',
                                    fontSize: 18,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: defaultPadding * 2),
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
                                        turnOnLed(value!, 1);
                                        deviceProvider.switchLed(ledNum: 1);
                                        setState(() {
                                          lampTurnedOn = value;
                                        });
                                        //TODO: led 1, living room lamp
                                      },
                                      //value: lampTurnedOn,
                                      value: deviceProvider.leds[0],
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
                                      text: stateMap[tvTurnedOn]!,
                                      fontSize: 26,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: SvgPicture.asset(
                                          'assets/svg/ceiling_lamp.svg'),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Expanded(
                                  child: TitleText(
                                    text: 'Lamp',
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
                                        turnOnLed(value!, 4);
                                        deviceProvider.switchLed(ledNum: 4);
                                        setState(() {
                                          //homeInterior.boolHumidifier = value;
                                          tvTurnedOn = value;
                                        });
                                        //sendRequest(value!, 4);
                                        // led 4, tv
                                      },
                                      //value: homeInterior.boolHumidifier!,
                                      //value: tvTurnedOn,
                                      value: deviceProvider.leds[3],
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
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(33),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                bottom: 20,
                                right: 10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                        'assets/svg/ventilator.svg'),
                                  ),
                                  const SizedBox(width: 5),
                                  TitleText(
                                    text: 'Fan Status',
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                  const Spacer(),
                                  TitleText(
                                    text: fanStatus,
                                    color: fanIsOn
                                        ? Colors.orange
                                        : Colors.black87,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                top: 20,
                                right: 10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: SvgPicture.asset(
                                        'assets/svg/thermometer.svg'),
                                  ),
                                  const SizedBox(width: 5),
                                  TitleText(
                                    text: 'Temperature',
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                  const Spacer(),
                                  Icon(
                                    increase
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: increase ? Colors.green : Colors.red,
                                  ),
                                  TitleText(
                                    text: '$temperature C',
                                    color: increase ? Colors.green : Colors.red,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
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
