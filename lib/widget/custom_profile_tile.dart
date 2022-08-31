import 'package:flutter/material.dart';

class ProfileReUseTile extends StatelessWidget {
  final Widget? trailing;
  final String title;
  final String subTitle;

  const ProfileReUseTile(
      {Key? key, this.trailing, required this.title, required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
          title: Row(
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Text(
            subTitle,
            style:
                TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.9)),
          ),
          trailing: trailing,
        ),
      ),
      Divider(
        color: Colors.black.withOpacity(0.3),
        thickness: 1,
      )
    ]);
  }
}
