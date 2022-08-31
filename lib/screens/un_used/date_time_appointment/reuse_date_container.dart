// import 'package:flutter/material.dart';

// class ReUseDateContainer extends StatelessWidget {
//   final String day;
//   final String date;
//   final bool isSelected;
//   final Function() onTap;


//   const ReUseDateContainer(
//       {Key? key,
//       required this.day,
//       required this.date,
//       required this.isSelected,
//       required this.onTap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 80,
//       margin: const EdgeInsets.symmetric(horizontal: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
//       decoration: BoxDecoration(
//           color: isSelected
//               ? const Color.fromARGB(255, 31, 123, 108)
//               : Colors.grey.withOpacity(0.6),
//           borderRadius: BorderRadius.circular(15)),
//       child: GestureDetector(onTap:(){} ,
//         child: Column(
//           children: [
//             Text(
//               day,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               date,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.normal,
//                 color: isSelected ? Colors.white : Colors.black,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
