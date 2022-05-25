// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class resetPassword extends StatefulWidget {
//   const resetPassword({Key? key}) : super(key: key);

//   @override
//   State<resetPassword> createState() => _resetPasswordState();
// }

// class _resetPasswordState extends State<resetPassword> {
//   bool passwordObscured = true;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: Container(
//                 padding: EdgeInsets.all(0),
//                 height: 150,
//                 child: Image.asset(
//                   "assets/images/password.png",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 40),
//               child: Text(
//                 "Reset\nPassword",
//                 style: GoogleFonts.poppins(
//                     textStyle: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 30)),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 40, right: 40, top: 0),
//               child: TextField(
//                 obscureText: passwordObscured,
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.lock_reset_outlined,
//                       size: 20,
//                     ),
//                     suffixIcon: IconButton(
//                         iconSize: 20,
//                         onPressed: () {
//                           setState(() {
//                             passwordObscured = !passwordObscured;
//                           });
//                         },
//                         icon: Icon(passwordObscured
//                             ? Icons.visibility_off
//                             : Icons.visibility)),
//                     hintText: "New Password"),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(left: 40, right: 40, top: 0),
//               child: TextField(
//                 obscureText: passwordObscured,
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(
//                       Icons.lock_reset_outlined,
//                       size: 20,
//                     ),
//                     hintText: "Confirm New Password"),
//               ),
//             ),
//             Center(
//                 child: Container(
//               padding: EdgeInsets.only(
//                 left: 40,
//                 right: 40,
//               ),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Submit",
//                   style: GoogleFonts.poppins(
//                       textStyle: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12)),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   primary: Colors.blue,
//                   padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
//                 ),
//               ),
//             )),
//           ],
//         ),
//       ),
//     );
//   }
// }
