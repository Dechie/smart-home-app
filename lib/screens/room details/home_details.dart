import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_better/models/home_interior.dart';
import 'package:smart_home_better/utils/constants.dart';

class HomeDetails extends StatefulWidget {
  const HomeDetails({
    super.key,
    required this.homeInterior,
  });

  final HomeInterior homeInterior;
  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  late HomeInterior homeInterior = widget.homeInterior;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
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
                          const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 30,
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
                                    text: homeInterior.humidifier!,
                                    fontSize: 26,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child:
                                        SvgPicture.asset('assets/svg/home.svg'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              Expanded(
                                child: TitleText(
                                  text: 'Humidifier air',
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
                                      sendRequest(value!);
                                    },
                                    //value: homeInterior.boolHumidifier!,
                                    value: false,
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
                                    text: homeInterior.airPurifier!,
                                    fontSize: 26,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child:
                                        SvgPicture.asset('assets/svg/home.svg'),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: defaultPadding,
                              ),
                              Expanded(
                                child: TitleText(
                                  text: 'Air Purifier',
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
                                    onChanged: (bool? value) {},
                                    value: homeInterior.boolAirPurifier!,
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
                      children: [
                        TitleText(
                          text: 'Main Light',
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  // Customize the colors, shapes, and other properties here
                                  activeTrackColor: secondaryColor,
                                  inactiveTrackColor: bgColor,
                                  thumbColor: bgColor,
                                  overlayColor: secondaryColor.withOpacity(0.3),
                                  thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayShape: RoundSliderOverlayShape(
                                      overlayRadius: 24.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 100,
                                  value: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      // _value = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(
                                  'assets/svg/ceiling_lamp.svg'),
                            )
                          ],
                        ),
                        const Spacer(),
                        TitleText(
                          text: 'Floor Light',
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  // Customize the colors, shapes, and other properties here
                                  activeTrackColor: secondaryColor,
                                  inactiveTrackColor: bgColor,
                                  thumbColor: bgColor,
                                  overlayColor: secondaryColor.withOpacity(0.3),
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0),
                                  overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 24.0),
                                ),
                                child: Slider(
                                  min: 0,
                                  max: 100,
                                  //value: _value2,
                                  value: 0,
                                  onChanged: (value) {
                                    setState(() {
                                      //_value2 = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child:
                                  SvgPicture.asset('assets/svg/floor_lamp.svg'),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  void sendRequest(bool state) async {
    var dio = Dio();

    Map<bool, String> statemp = {
      true: "on",
      false: "off",
    };
    var st = statemp[state];
    var url, response;
    try {
      //url = 'http://192.168.180.190:80/fan/$st';
      url = 'http://192.168.180.190:80/led1/$st';
      print(url);
      response = await dio.get(url);
    } catch (e) {
      print(e);
    }

    print(response.statusCode);
  }
}

class TitleText extends StatelessWidget {
  TitleText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  final String text;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: fontSize ?? 22,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  SubTitleText({
    super.key,
    required this.text,
    this.color,
    this.fontWeight,
  });

  final String text;
  Color? color;
  FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
        color: color ?? Colors.black,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
