import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TrinityLogo extends StatelessWidget {
  const TrinityLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AutoSizeText(
                'Trinity Hosting',
                style: TextStyle(fontSize: 50),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              AutoSizeText('With the speed of God'),
            ],
          )
        ],
      ),
    )
    ;
  }
}
