import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_home_better/screens/room%20details/bedroom.dart';
import 'package:smart_home_better/screens/room%20details/home_details.dart';
import 'package:smart_home_better/screens/room%20details/kitchen.dart';
import 'package:smart_home_better/screens/room%20details/living_room.dart';
import 'package:smart_home_better/utils/constants.dart';
import 'package:smart_home_better/models/home_device.dart';
import 'package:smart_home_better/models/home_interior.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({super.key});

  @override
  State<RoomsPage> createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding * 1.5,
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: TitleText(
                    text: 'Hello, User',
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: defaultPadding * 1.5),
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView.builder(
                controller: _pageController,
                itemCount: demoHomeInterior.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    homeCard(demoHomeInterior[index]),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                dotColor: Colors.grey.withOpacity(0.3),
                activeDotColor: secondaryColor,
                dotHeight: 10,
                dotWidth: 10,
                spacing: 5,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding * 1.5,
              vertical: defaultPadding,
            ),
            child: TitleText(
              text: 'My Devices',
              fontWeight: FontWeight.w700,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding * 1.5,
                vertical: defaultPadding,
              ),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyHomeDevices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQuery.of(context).size.width / 2 - 36,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) =>
                    deviceCard(dummyHomeDevices[index]),
              ),
            ),
          ),
        ],
      ),
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
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                homeDevice.image,
                width: 40,
                height: 40,
              ),
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
    var roomType = homeInterior.title;
    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          InkWell(
            onTap: () {
              switch (roomType) {
                case 'Living Room':
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LivingRoomDetails(
                          homeInterior: homeInterior,
                        ),
                      ),
                    );
                  }
                  break;
                case 'Bedroom':
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BedroomDetails(
                          homeInterior: homeInterior,
                        ),
                      ),
                    );
                  }
                  break;
                case 'Kitchen':
                  {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KitchenDetails(
                          homeInterior: homeInterior,
                        ),
                      ),
                    );
                  }
                  break;
              }
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
        fontSize: fontSize ?? 18,
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
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
