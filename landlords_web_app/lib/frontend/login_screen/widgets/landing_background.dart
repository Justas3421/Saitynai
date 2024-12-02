import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingBackground extends StatelessWidget {
  const LandingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: const Offset(-100, 0),
                child: Transform.rotate(
                  angle: 45 * 3.14 / 180,
                  child: Container(
                    color:
                        const Color.fromRGBO(132, 143, 218, 0.403921568627451),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Transform.translate(
                offset: const Offset(100, 0),
                child: Transform.rotate(
                  angle: 45 * 3.14 / 180,
                  child: Container(
                    color:
                        const Color.fromRGBO(132, 143, 218, 0.403921568627451),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(),
          ),
        ),
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
      ],
    );
  }
}
