// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'constants.dart';

// class MyPageScreen extends StatefulWidget {
//   const MyPageScreen({super.key});

//     @override
//   _MyPageScreenState createState() => _MyPageScreenState();
// }

// class _MyPageScreenState extends State<MyPageScreen> {

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       // extract information
//       final email = _emailController.text;
//       final emailName = email.split('@').first;

//       // request
//       final response = await http.post(
//         Uri.parse('$serverUrl/user/signup'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({
//           "email": _emailController.text,
//           "password": _passwordController.text,
//           "nickname": emailName,
//         }),
//       );

//       setState(() {
//         _isLoading = false;
//       });

//       // response
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("회원가입이 완료되었습니다!")),
//         );
//         Navigator.of(context).pushReplacementNamed('/signin');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("회원가입에 실패했습니다. 다시 시도해주세요.")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text('마이페이지'),
//         // leading: IconButton(
//         //   icon: Icon(
//         //     backIcon,
//         //     color: mainThemeColor,
//         //   ),
//         //   onPressed: () {
//         //     Navigator.of(context).pushReplacementNamed('/login');
//         //   },
//         // ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Image.asset(
//                     'lib/assets/images/baby.png',
//                     height: 40,
//                     fit: BoxFit.cover,
//                   ),

//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _selectedGender = "M";
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _selectedGender == "M" ? Colors.grey.shade300 : Colors.white,
//                     ),
//                     child: Text("남"),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       setState(() {
//                         _selectedGender = "F";
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _selectedGender == "F" ? Colors.grey.shade300 : Colors.white,
//                     ),
//                     child: Text("여"),
//                   ),
//                 ],
//               ),
//               // Image.asset(
//               //   'lib/assets/images/grandfamily.png',
//               //   height: 140,
//               //   fit: BoxFit.cover,
//               // ),
//               SizedBox(height: 45),


//               // Register Form
//               Form(
//                 key: _formKey,
//                 child: Container(
//                   width: 290,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [


//                       SizedBox(height: 35),
//                     ],
//                   ),
//                 ),
//               ),

//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                       onPressed: _submitForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: mainThemeColor,
//                         minimumSize: Size(240, 40),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                       ),
//                       child: Text(
//                         '아이 정보 등록',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),

//               SizedBox(height: 10),

  
//               ElevatedButton(

//                 child: Text("로그아웃"),
//               ),

//               ElevatedButton(

//                 child: Text("회원 탈퇴"),
//               ),
              
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }