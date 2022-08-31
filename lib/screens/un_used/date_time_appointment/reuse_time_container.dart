// import 'package:flutter/material.dart';

// class ReUseTimeContainer extends StatelessWidget {
//   final String time;

//   final bool isSelected;

//   const ReUseTimeContainer(
//       {Key? key, required this.time, required this.isSelected})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50,
//       // margin: const EdgeInsets.symmetric(horizontal: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//           color: isSelected
//               ? const Color.fromARGB(255, 31, 123, 108)
//               : Colors.grey.withOpacity(0.6),
//           borderRadius: BorderRadius.circular(10)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const Icon(
//             Icons.watch_later_outlined,
//             color: Colors.white,
//             size: 22,
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Text(
//             time,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.normal,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           ),
//           const SizedBox(
//             width: 5,
//           ),
//           Text(
//             "Am",
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.normal,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
