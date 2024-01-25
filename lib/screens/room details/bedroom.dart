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

class BedroomDetails extends StatefulWidget {
  const BedroomDetails({
    super.key,
    required this.homeInterior,
  });

  final HomeInterior homeInterior;
  @override
  State<BedroomDetails> createState() => _BedroomDetailsState();
}

class _BedroomDetailsState extends State<BedroomDetails> {
  late HomeInterior homeInterior = widget.homeInterior;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<bool, String> stateMap = {
      true: "on",
      false: "Off",
    };
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Consumer<DeviceProvider>(builder: (context, deviceProvider, child) {
        return SafeArea(
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
                                      fontSize: 26,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 45,
                                        width: 45,
                                        child: SvgPicture.asset(
                                            'assets/svg/LED.svg'),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: defaultPadding,
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      TitleText(
                                        text: 'Lamp',
                                        fontSize: 18,
                                        color: Colors.black54,
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: defaultPadding * .75),
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
                                        turnOnLed(value!, 2);
                                        deviceProvider.switchLed(ledNum: 2);
                                        setState(() {
                                          homeInterior.boolHumidifier = value;
                                        });

                                        // sendRequest(value!);
                                        // TODO: led 2: bedroom light
                                      },
                                      //value: homeInterior.boolHumidifier!,
                                      value: deviceProvider.leds[1],
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
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      }),
    );
  }
}
