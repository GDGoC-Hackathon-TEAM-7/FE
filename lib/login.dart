import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'constants.dart';

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
                  backgroundColor: mainThemeColor,
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
                    side: BorderSide(color: mainThemeColor, width: 1),
                  ),
                ),
                child: Text(
                  '로그인 (기존 사용자)',
                  style: TextStyle(
                    color: mainThemeColor,
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


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

    @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // extract information
      final email = _emailController.text;
      final emailName = email.split('@').first;

      // request
      final response = await http.post(
        Uri.parse('$serverUrl/user/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _emailController.text,
          "password": _passwordController.text,
          "nickname": emailName,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      // response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("회원가입이 완료되었습니다!")),
        );
        Navigator.of(context).pushReplacementNamed('/signin');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("회원가입에 실패했습니다. 다시 시도해주세요.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text('회원가입'),
        leading: IconButton(
          icon: Icon(
            backIcon,
            color: mainThemeColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/splash_image.png',
                height: 130,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 25),

              Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 24,
                  color: mainThemeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Divider(thickness: 1, height: 1, color: mainThemeColor),

              SizedBox(height: 20),


              // SignUp Form
              Form(
                key: _formKey,
                child: Container(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // [field #1] email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "이메일 주소",
                          prefixIcon: Icon(personIcon),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "이메일을 입력해주세요.";
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "올바른 이메일 주소를 입력해주세요.";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // [field #2] password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호 (숫자 4자리)",
                          prefixIcon: Icon(lockIcon),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "비밀번호를 입력해주세요.";
                          } else if (value.length != 4 || !RegExp(r'^\d{4}$').hasMatch(value)) {
                            return "숫자 4자리를 입력해주세요.";
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: 10),

                      // [field #3] password confirmation
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호 재확인",
                          prefixIcon: Icon(lockIcon),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "비밀번호를 다시 입력해주세요.";
                          } else if (value != _passwordController.text) {
                            return "비밀번호가 일치하지 않습니다.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),


              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainThemeColor,
                        minimumSize: Size(240, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '회원가입',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // extract information
      final email = _emailController.text;
      final password = _passwordController.text;

      // request
      final response = await http.post(
        Uri.parse('$serverUrl/user/login?email=$email&password=$password'),
      );  

      setState(() {
        _isLoading = false;
      });

      // response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 성공!")),
        );
        Navigator.of(context).pushReplacementNamed('/baby');
      } else if (response.statusCode == 401) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인 실패! 이메일 또는 비밀번호를 확인해주세요.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("로그인에 실패했습니다. 다시 시도해주세요.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // title: Text('로그인'),
        leading: IconButton(
          icon: Icon(
            backIcon,
            color: mainThemeColor,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height:30),

              Image.asset(
                'lib/assets/images/splash_image.png',
                height: 140,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 20),

              Text(
                '로그인',
                style: TextStyle(
                  fontSize: 24,
                  color: mainThemeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              Divider(thickness: 1, height: 1, color: mainThemeColor),

              SizedBox(height: 30),


              // SignIn Form
              Form(
                key: _formKey,
                child: Container(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // [field #1] email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "이메일 주소",
                          prefixIcon: Icon(personIcon),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "이메일을 입력해주세요.";
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return "올바른 이메일 주소를 입력해주세요.";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // [field #2] password
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "비밀번호",
                          prefixIcon: Icon(lockIcon),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "비밀번호를 입력해주세요.";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainThemeColor,
                        minimumSize: Size(240, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '로그인',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}