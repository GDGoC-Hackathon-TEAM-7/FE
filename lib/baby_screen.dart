import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';


class NewBabyScreen extends StatefulWidget {
  const NewBabyScreen({super.key});

  @override
  _NewBabyScreenState createState() => _NewBabyScreenState();
}

class _NewBabyScreenState extends State<NewBabyScreen> {
  late String savedEmail;

  @override
  void initState() {
    super.initState();
    _createDiary();
  }

    Future<void> _createDiary() async {
    const String date = "2025-01-29";
    const String memo = "string";

    final response = await http.post(
      Uri.parse('$serverUrl/diary'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "babyId": firstBaby,
        "date": date,
        "memo": memo,
      }),
    );

    if (response.statusCode == 200) {
      print('Diary record saved successfully');
    } else {
      print('Failed to save diary record');
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _babyNameController = TextEditingController();
  final TextEditingController _babyBirthController = TextEditingController();
  String _selectedGender = "M";  // by default

  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2010, 1, 1);
    DateTime lastDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,

      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primaryColor: mainThemeColor,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogBackgroundColor: Colors.grey.shade300,
            scaffoldBackgroundColor: Colors.white,
            iconTheme: IconThemeData(
              color: mainThemeColor,
            )
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _babyBirthController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
    

      // Request
      final response = await http.post(
        Uri.parse('$serverUrl/baby'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": _babyNameController.text,
          "birth": _babyBirthController.text,
          "gender": _selectedGender,
          "email": userEmail,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      // Response
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("아이 정보가 등록되었습니다!")),
        );
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("정보 등록에 실패했습니다. 다시 시도해주세요.")),
        );
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('아이 정보 입력'),
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
              SizedBox(height: 35),
              Image.asset(
                'lib/assets/images/grandfamily.png',
                height: 140,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 45),


              // Register Form
              Form(
                key: _formKey,
                child: Container(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      // [field #1] baby name
                      TextFormField(
                        controller: _babyNameController,
                        decoration: InputDecoration(
                          labelText: "아이 이름(별명)",
                          prefixIcon: Icon(personIcon),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "아이 이름을 입력해주세요.";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 10),

                      // [field #2] baby birth date
                      TextFormField(
                        controller: _babyBirthController,
                        decoration: InputDecoration(
                          labelText: "아이 생년월일",
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "생년월일을 선택해주세요.";
                          }
                          return null;
                        },
                      ),
                      
                      SizedBox(height: 35),

                      // [field #3] gender selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = "M";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == "M" ? Colors.grey.shade300 : Colors.white,
                            ),
                            child: Text("남"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = "F";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == "F" ? Colors.grey.shade300 : Colors.white,
                            ),
                            child: Text("여"),
                          ),
                        ],
                      ),

                      SizedBox(height: 35),
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
                        minimumSize: Size(220, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '아이 정보 등록',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
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


class BabyEditScreen extends StatefulWidget {
  final String babyId;

  const BabyEditScreen({required this.babyId, super.key});

  @override
  _BabyEditScreenState createState() => _BabyEditScreenState();
}

class _BabyEditScreenState extends State<BabyEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _babyNameController = TextEditingController();
  final TextEditingController _babyBirthController = TextEditingController();
  String _selectedGender = "M"; // Default gender

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchBabyInfo();
  }

  // fetch baby information: GET /baby/{babyId}
  Future<void> _fetchBabyInfo() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.get(
      Uri.parse('$serverUrl/baby/${widget.babyId}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['result'];
      setState(() {
        _babyNameController.text = data['name'];
        _selectedGender = data['gender'];
        _babyBirthController.text =
            DateFormat('yyyy-MM-dd').format(DateTime.parse(data['birth']));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("아이 정보를 가져오는데 실패했습니다.")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // update baby information: PATCH /baby/{babyId}
  Future<void> _updateBabyInfo() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.patch(
        Uri.parse('$serverUrl/baby/${widget.babyId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": _babyNameController.text,
          "gender": _selectedGender,
          "birth": _babyBirthController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("아이 정보가 성공적으로 수정되었습니다!")),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("아이 정보 수정에 실패했습니다.")),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2010, 1, 1);
    DateTime lastDate = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        _babyBirthController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('아이 정보 수정'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Image.asset(
                'lib/assets/images/grandfamily.png',
                height: 140,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 45),

              // Form
              Form(
                key: _formKey,
                child: Container(
                  width: 290,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // [Field #1] Baby name
                      TextFormField(
                        controller: _babyNameController,
                        decoration: InputDecoration(
                          labelText: "아이 이름(별명)",
                          prefixIcon: Icon(personIcon),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "아이 이름을 입력해주세요.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),

                      // [Field #2] Baby birth date
                      TextFormField(
                        controller: _babyBirthController,
                        decoration: InputDecoration(
                          labelText: "아이 생년월일",
                          prefixIcon: Icon(Icons.calendar_today),
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "생년월일을 선택해주세요.";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35),

                      // [Field #3] Gender selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = "M";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == "M"
                                  ? Colors.grey.shade300
                                  : Colors.white,
                            ),
                            child: Text("남"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = "F";
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == "F"
                                  ? Colors.grey.shade300
                                  : Colors.white,
                            ),
                            child: Text("여"),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                    ],
                  ),
                ),
              ),

              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _updateBabyInfo,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainThemeColor,
                        minimumSize: Size(240, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        '아이 정보 수정',
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