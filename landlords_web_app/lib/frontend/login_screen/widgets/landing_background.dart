import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:landlords_web_app/constants/colors.dart';

class LandingBackground extends StatelessWidget {
  final String? title;
  final bool showTopBackButton;
  const LandingBackground(
      {super.key, this.title, this.showTopBackButton = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Color.fromARGB(255, 34, 2, 53)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            if (title == null) ...{
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            } else ...{
              Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title!,
                        style: theme.textTheme.headlineMedium!.copyWith(
                          color: ColorSeed.darkPrimaryText.color,
                        ),
                      )))
            }
          ],
        ),
      ),
    );
  }
}
