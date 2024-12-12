import 'package:flutter/material.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/constants/top_back_button.dart';
import 'package:landlords_web_app/frontend/auth_screen/auth_screen.dart';
import 'package:landlords_web_app/frontend/landlords_screen/landlords_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class NavBar extends StatefulWidget {
  final Widget child;

  const NavBar({required this.child, super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _navigateTo(BuildContext context, Widget child) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavBar(child: child)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: LandingPageColors.cardColor.color,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: LandingPageColors.accentColor.color,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
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
                Navigator.popUntil(context, (route) => route.isFirst);
                _navigateTo(context, const LandlordsScreen());
              },
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                _navigateTo(context, const AuthScreen());
              },
            ),
            ListTile(
              iconColor: Colors.white,
              textColor: Colors.white,
              leading: const Icon(Icons.settings),
              title: const Text('Property management'),
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                _navigateTo(
                  context,
                  const LandlordsScreen(isManagment: true),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // The main content behind the nav bar
          widget.child,

          // The navigation header always in front
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // Transparent background
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (Navigator.canPop(context)) ...{
                      TopBackButton(onPressed: () {
                        Navigator.pop(context);
                      }),
                    } else ...{
                      const SizedBox(width: 48),
                    },
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Drawer button
                        ResponsiveVisibility(
                          visible: false,
                          visibleConditions: const [
                            Condition.smallerThan(name: TABLET)
                          ],
                          child: IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                        ),

                        // Navigation actions for larger screens
                        ResponsiveVisibility(
                          visible: false,
                          visibleConditions: const [
                            Condition.largerThan(name: MOBILE)
                          ],
                          child: Row(
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.home, color: Colors.white),
                                onPressed: () {
                                  _navigateTo(context, const LandlordsScreen());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.account_circle,
                                    color: Colors.white),
                                onPressed: () {
                                  _navigateTo(context, const AuthScreen());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.sticky_note_2,
                                    color: Colors.white),
                                onPressed: () {
                                  _navigateTo(
                                    context,
                                    const LandlordsScreen(
                                      isManagment: true,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
