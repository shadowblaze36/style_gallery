import 'package:flutter/material.dart';
import 'dart:math' as math;

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _PurpleBox(),
          //const _HeaderLogo(),
          child,
        ],
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          child: const Image(
            height: 75,
            image: AssetImage(
              'assets/White_Tegra_CMYK.png',
            ),
          )),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _redBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble(), top: 100, left: 30),
          Positioned(child: _Bubble(), top: -10, left: 70),
          Positioned(child: _Bubble(), top: 200, left: -70),
          Positioned(child: _Bubble(), top: 70, left: -40),
          Positioned(child: _Bubble(), bottom: 50, left: -10),
          Positioned(child: _Bubble(), bottom: 100, left: 90),
          Positioned(child: _Bubble(), top: 40, right: 100),
          Positioned(child: _Bubble(), top: 70, right: 10),
          Positioned(child: _Bubble(), bottom: 90, right: 70),
          Positioned(child: _Bubble(), bottom: 10, right: 5),
          Positioned(child: _Bubble(), bottom: 150, right: -50),
        ],
      ),
    );
  }

  BoxDecoration _redBackground() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(133, 46, 44, 1),
        Color.fromRGBO(162, 43, 42, 1),
      ]));
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 4,
      child: Material(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        clipBehavior: Clip.antiAlias,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: 100,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
          ),
        ),
      ),
    );
  }
}
