import 'package:flutter/material.dart';

import 'constants.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('마이페이지')),
        elevation: 0,
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height:30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // SizedBox(width: 20),

                ClipOval(
                  child: Image.asset(
                    'lib/assets/images/baby.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                // SizedBox(width: 15),
                
                Text(
                  "김도담",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),

                // SizedBox(width: 10),

                Text(
                  "14개월 남",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),

            SizedBox(height: 35),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Text(
                    "손자녀 정보 수정",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainThemeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/baby');
                  },
                  child: Text(
                    "다른 손자녀 추가",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 205, 174, 121),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25),

            Divider(thickness: 1, color: Colors.grey.shade200),

            SizedBox(height: 25),

            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "로그아웃",
                    style: TextStyle(
                      fontSize: 17,
                      color: mainThemeColor,
                    )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(240, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: mainThemeColor, width: 1),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "회원 탈퇴",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white
                    )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainThemeColor,
                    minimumSize: Size(240, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
