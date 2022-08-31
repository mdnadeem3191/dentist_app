import 'package:flutter/material.dart';

class StarDisplayWidget extends StatelessWidget {
  final double value;
  final Widget filledStar;
  final Widget unfilledStar;
  const StarDisplayWidget(
      {Key? key,
      required this.filledStar,
      required this.unfilledStar,
      required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value ? filledStar : unfilledStar;
      }),
    );
  }
}

class StarDisplay extends StarDisplayWidget {
  const StarDisplay({Key? key, double value = 0.0})
      : super(
          key: key,
          value: value,
          filledStar: const Icon(Icons.star),
          unfilledStar: const Icon(Icons.star_border),
        );
}
