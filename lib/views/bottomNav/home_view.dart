import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/constantVariables.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/views/topNav/breaking_tab_view.dart';
import 'package:news_app/views/topNav/social_tab_view.dart';
import 'package:news_app/views/topNav/trending_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late SharedPreferences _pref;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "WELCOME",
                  textAlign: TextAlign.end,
                  style: kNonActiveTabStyle,
                ),
                subtitle: Text(
                  "Pius Ifodo",
                  textAlign: TextAlign.end,
                  style: kActiveTabStyle,
                ),
                trailing: GestureDetector(
                  onTap: () => _showLogoutDialog(context),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage("assets/pax.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: kGrey1,
                  unselectedLabelStyle: kNonActiveTabStyle,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  labelStyle: kActiveTabStyle.copyWith(fontSize: 25.0),
                  tabs: const [
                    Tab(text: "Breaking News"),
                    Tab(text: "Social"),
                    Tab(text: "Trending")
                  ],
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BreakingTabView(),
            SocialTabView(),
            TrendingTabView(),
          ],
        ),
      ),
    );
  }

  Widget _yesButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () async {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            _pref = await SharedPreferences.getInstance();
            _pref.remove(ConstantVariables.logIn);

            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE2E5FF),
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: const Color(0xFFE2E5FF),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Yes, Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            SystemSound.play(SystemSoundType.click);

            Navigator.of(context).pop();
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE2E5FF),
                width: 1,
              ),
              // boxShadow: const [
              //   BoxShadow(
              //     color: Constant.accent,
              //     blurRadius: 10,
              //     offset: Offset(1, 1),
              //   ),
              // ],
              color: const Color(0xFFE2E5FF),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => ScaleAnimatedWidget.tween(
        enabled: true,
        duration: const Duration(milliseconds: 200),
        scaleDisabled: 0.5,
        scaleEnabled: 1,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 310),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Log Out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _cancelButton(context),
                    _yesButton(context),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
