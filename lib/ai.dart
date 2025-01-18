import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Aiscreen extends StatefulWidget {
  const Aiscreen({Key? key}) : super(key: key);

  @override
  State<Aiscreen> createState() => _AiscreenState();
}

class _AiscreenState extends State<Aiscreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [];
  String _email = "aaa@naver.com";
  bool _isLoading = false;

  // API 호출 함수
  Future<String> sendMessage(String email, String message) async {
    const String apiUrl = 'http://43.201.255.118:8888/ai/chatbot/talk';
    try {
      // URL 생성 및 파라미터 추가
      final Uri requestUrl = Uri.parse(apiUrl).replace(queryParameters: {
        'email': email,
        'message': message,
      });

      // POST 요청 보내기
      final response = await http.post(
        requestUrl,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 응답 디코딩
        final decodedBody = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decodedBody);

        // 결과 값만 반환
        return data['result'] ?? '결과 없음';
      } else {
        return '서버 오류: ${response.statusCode}';
      }
    } catch (e) {
      return '네트워크 오류: $e';
    }
  }

  // 메시지 전송
  void _handleSendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      // 빈 메시지 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('메시지를 입력해주세요!')),
      );
      return;
    }

    setState(() {
      _messages.add({'type': 'user', 'text': message});
      _messageController.clear();
      _isLoading = true;
    });

    // API 호출 및 응답 처리
    final response = await sendMessage(_email, message);

    setState(() {
      _messages.add({'type': 'bot', 'text': response});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABF9C),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          '도담도담',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final isUserMessage = _messages[index]['type'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Colors.brown[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      _messages[index]['text']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFDABF9C)),
                  onPressed: _handleSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
