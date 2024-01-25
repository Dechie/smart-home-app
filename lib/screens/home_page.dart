import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_better/screens/room%20details/home_details.dart';
import 'package:smart_home_better/screens/rooms_page.dart';
import 'package:smart_home_better/utils/constants.dart';
import 'package:smart_home_better/models/home_device.dart';
import 'package:smart_home_better/models/home_interior.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RoomsPage(),
    );
  }

  SizedBox deviceCard(HomeDevice homeDevice) {
    return SizedBox(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              homeDevice.image,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: defaultPadding - 6),
            FittedBox(
              child: TitleText(
                text: homeDevice.title,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: defaultPadding / 2),
            FittedBox(
              child: Text(
                homeDevice.subtitle,
                style: GoogleFonts.ubuntu(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding homeCard(HomeInterior homeInterior) {
    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeDetails(
                    homeInterior: homeInterior,
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                homeInterior.image,
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: defaultPadding),
            child: TitleText(
              text: homeInterior.title,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
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
