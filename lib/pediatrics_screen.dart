import 'package:flutter/material.dart';

class PediatricsPage extends StatelessWidget {
  const PediatricsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABF9C), // 베이지 색
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
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              // 프로필 버튼 동작
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  '"성동구" 근처 소아과',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      '지도 표시 (예: Google Maps)',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: '근처 병원과 약국 위치 검색',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // 현재 선택된 탭: 근처 소아과 찾기
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/ai_recommend'); // AI 추천 페이지
          } else if (index == 1) {
            Navigator.pushNamed(context, '/schedule'); // 아이 일정 관리 페이지
          }
        },
        backgroundColor: const Color(0xFFDABF9C), // 베이지 색
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        selectedFontSize: 16,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/ai_image.png'),
                size: 40),
            label: 'AI로 놀이 추천받기',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/calendar_image.png'),
                size: 40),
            label: '아이 일정 관리',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/assets/images/emergency_image.png'),
                size: 40),
            label: '근처 소아과 찾기',
          ),
        ],
      ),
    );
  }
}
