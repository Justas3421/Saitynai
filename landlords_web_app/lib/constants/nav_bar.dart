import 'package:flutter/material.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/auth_screen/auth_screen.dart';
import 'package:landlords_web_app/frontend/landlords_screen/landlords_screen.dart';
import 'package:landlords_web_app/frontend/login_screen/login_screen.dart';
import 'package:landlords_web_app/main.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NavBar extends StatefulWidget {
  Widget child;
  NavBar({required this.child, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  void _setChild(Widget child) {
    setState(() {
      widget.child = child;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Make Scaffold background transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 65,
        leading: ResponsiveVisibility(
          visible: false,
          visibleConditions: const [Condition.smallerThan(name: TABLET)],
          child: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    _setChild(const LandlordsScreen());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.account_circle),
                  onPressed: () {
                    _setChild(const AuthScreen());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    _setChild(const SettingsPage());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: ResponsiveVisibility(
        visible: false,
        visibleConditions: const [Condition.smallerThan(name: TABLET)],
        child: Drawer(
          backgroundColor: LandingPageColors
              .cardColor.color, // Make Drawer background transparent
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: LandingPageColors.accentColor.color,
                ),
                child: const Text(
                  'Menu',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  _setChild(const LandlordsScreen());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: const Icon(Icons.account_circle),
                title: const Text('Profile'),
                onTap: () {
                  _setChild(const AuthScreen());
                  Navigator.pop(context);
                },
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  _setChild(const SettingsPage());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: widget.child,
    );
  }
}
