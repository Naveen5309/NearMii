// import 'package:NearMii/config/helper.dart';
// import 'package:flutter/material.dart';

// class CustomPhoneNumberField extends StatelessWidget {
//   const CustomPhoneNumberField({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       height: 50,
//       width: 300,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(color: Colors.green.shade200),
//       ),
//       child: Row(
//         children: [
//           // Country Flag
//           Container(
//             width: 30,
//             height: 30,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: AssetImage(
//                     'assets/usa_flag.png'), // Add flag image in assets
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),

//           // Country Code Dropdown
//           const Text(
//             "+1",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const Icon(Icons.arrow_drop_down, size: 20, color: Colors.green),

//           // Vertical Divider
//           VerticalDivider(color: Colors.green.shade200, thickness: 1),

//           // Phone Number Input
//           Expanded(
//             child: TextField(
//               keyboardType: TextInputType.phone,
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: "Phone number",
//                 fillColor: AppColor.greyFAFAFA,
//                 hintStyle: TextStyle(color: Colors.green.shade300),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
