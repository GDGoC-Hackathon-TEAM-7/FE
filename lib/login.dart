import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

    @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/splash_image.png',
                height: 190,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 35),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signup');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBDAD91),
                  minimumSize: Size(240, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  '가입하기 (신규 사용자)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/signin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size(240, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Color(0xFFBDAD91), width: 1),
                  ),
                ),
                child: Text(
                  '로그인 (기존 사용자)',
                  style: TextStyle(
                    color: Color(0xFFBDAD91),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN UP'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Center(
        child: Text('empty screen for SIGNUP', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SIGN IN'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ),
      body: Center(
        child: Text('empty screen for SIGNIN', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}