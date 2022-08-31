import 'package:flutter/material.dart';

class ReUseTile extends StatelessWidget {
  final Function() onPresssed;
  final IconData iconData;
  final String title;

  const ReUseTile(
      {Key? key,
      required this.onPresssed,
      required this.iconData,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    double height48 = MediaQuery.of(context).size.height / 17.76;
    double height15 = MediaQuery.of(context).size.height / 56.838;
    double height20 = MediaQuery.of(context).size.height / 42.62;

    return GestureDetector(
      onTap: onPresssed,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: height20, vertical: height48 / 4),
        child: Row(
          children: [
            Icon(
              (iconData),
              size: 25,
            ),
            SizedBox(
              width: height15,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
