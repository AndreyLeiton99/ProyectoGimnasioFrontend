import 'package:flutter/material.dart';

import '../app_theme.dart';

class TitleView extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final VoidCallback? onTap;

  const TitleView({
    super.key,
    required this.titleTxt,
    required this.subTxt,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              titleTxt,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: GymAppTheme.fontName,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                letterSpacing: 0.5,
                color: GymAppTheme.lightText,
              ),
            ),
          ),
          InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: <Widget>[
                  Text(
                    subTxt,
                    style: const TextStyle(
                      fontFamily: GymAppTheme.fontName,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: GymAppTheme.nearlyDarkBlue,
                    ),
                  ),
                  const SizedBox(
                    height: 38,
                    width: 26,
                    child: Icon(
                      Icons.arrow_forward,
                      color: GymAppTheme.darkText,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
