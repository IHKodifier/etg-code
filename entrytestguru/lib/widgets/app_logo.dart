import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 200,
      child: Image.asset(
        'assets/images/ETG-Logo-Light.png',
        fit: BoxFit.cover,
        semanticLabel: 'EntryTestGuru Logo',
      ),
    );
  }
}
