import 'package:flutter/material.dart';
import 'package:smart_home_better/screens/home_page.dart';

import '../utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _tabController2;
  late TabController _tabController3;

  final _tabs = [
    const Tab(text: 'Electricity'),
    const Tab(text: 'Water'),
  ];

  final _tabs2 = [
    const Tab(text: '24 hours'),
    const Tab(text: '1 week'),
    const Tab(text: '1 month'),
  ];

  final _tabs3 = [
    const Tab(text: '24 hours'),
    const Tab(text: '1 week'),
    const Tab(text: '1 month'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController2 = TabController(length: 2, vsync: this);
    _tabController3 = TabController(length: 3, vsync: this);

    _tabController.index = 2;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: 'Settings',
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: defaultPadding),
            Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: defaultPadding),
                TitleText(
                  text: 'Statistics',
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            TabBar(
              controller: _tabController2,
              tabs: _tabs,
              labelColor: secondaryColor,
              indicatorColor: secondaryColor,
              labelStyle: const TextStyle(fontSize: 18),
              unselectedLabelColor: Colors.black,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: secondaryColor.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(80),
              ),
              child: TabBar(
                controller: _tabController3,
                tabs: _tabs2,
                labelColor: secondaryColor,
                //indicatorColor: secondaryColor,
                labelStyle: const TextStyle(fontSize: 18),
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: secondaryColor.withOpacity(0.2),
                  border: Border.all(
                    width: 1,
                    color: secondaryColor.withOpacity(0.4),
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            const SizedBox(height: defaultPadding * 2),
            Expanded(
                child: Center(
              child: TitleText(
                text: 'Chart will be here',
              ),
            )),
          ],
        ),
      ),
    );
  }
}
