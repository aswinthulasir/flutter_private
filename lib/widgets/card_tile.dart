// import 'package:court_project/models/case_model.dart';
// import 'package:flutter/material.dart';

// class CaseCardListTile extends StatefulWidget {
//   const CaseCardListTile({super.key, required this.caseData});

//   final Case caseData;

//   @override
//   State<CaseCardListTile> createState() => _CaseCardListTileState();
// }

// class _CaseCardListTileState extends State<CaseCardListTile> {
//   late String timestamp;

//   @override
//   Widget build(BuildContext context) {
//     if (widget.caseData.timestamp.day == DateTime.now().day) {
//       timestamp = "Today";
//     } else if (widget.caseData.timestamp.day == DateTime.now().day - 1) {
//       timestamp = "Yesterday";
//     } else {
//       timestamp =
//           "${widget.caseData.timestamp.day}/${widget.caseData.timestamp.month}/${widget.caseData.timestamp.year}";
//     }
//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         child: Card(
//           shape: const RoundedRectangleBorder(
//             side: BorderSide(
//               color: Colors.black,
//               width: 1.0,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           borderOnForeground: true,
//           color: Colors.orange[50],
//           child: ListTile(
//             leading: CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: 30,
//               backgroundImage: NetworkImage(
//                 widget.caseData.imageUrl!,
//               ),
//               onBackgroundImageError: (exception, stackTrace) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Error loading image"),
//                   ),
//                 );
//               },
//             ),
//             title: Text(
//               widget.caseData.companyName,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 overflow: TextOverflow.clip,
//               ),
//             ),
//             subtitle: Text(
//               widget.caseData.jobRole,
//               style: const TextStyle(
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return PlacementDetailsScreen(
//                       placement: widget.caseData,
//                     );
//                   },
//                 ),
//               );
//             },
//             //show timestamp
//             trailing: Text(
//               timestamp,
//               style: const TextStyle(
//                 fontSize: 10,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
