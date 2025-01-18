import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<Map<String, String>> _timeline = []; // 타임라인 데이터 저장
  int _currentIndex = 1; // 하단 네비게이션 현재 선택된 인덱스

  void _addRecord(String category) {
    setState(() {
      _timeline.add({
        'time': TimeOfDay.now().format(context), // 현재 시간 추가
        'category': category,
      });
    });
  }

  void _showFullScreenDialog(String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '손자녀와 함께한 특별한 오늘을 "$title"로 기록해 보세요!',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFDABF9C),
                ),
                child: const Text(
                  '닫기',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('손자녀와 함께한 특별한 오늘을 "$title"로 기록해 보세요!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDABF9C), // 따뜻한 베이지 색
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '도담도담',
          style: TextStyle(
            fontSize: 24, // 글자 크기 증가
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {
              _showDialog('프로필');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 상단 프로필 섹션
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40, // 크기 증가
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '"김도담" 14개월 남',
                      style: TextStyle(
                        fontSize: 22, // 글자 크기 증가
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '1월 17일 (금)',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon:
                      const Icon(Icons.more_vert, color: Colors.grey, size: 30),
                  onPressed: () {
                    _showDialog('옵션');
                  },
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // 아이콘 섹션
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('lib/assets/images/meal_image.png',
                          width: 50, height: 50),
                      onPressed: () {
                        _addRecord('식사');
                      },
                    ),
                    const Text(
                      '식사',
                      style: TextStyle(fontSize: 16), // 글자 크기 증가
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('lib/assets/images/diaper_image.png',
                          width: 50, height: 50),
                      onPressed: () {
                        _addRecord('기저귀');
                      },
                    ),
                    const Text(
                      '기저귀',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('lib/assets/images/sleep_image.png',
                          width: 50, height: 50),
                      onPressed: () {
                        _addRecord('취침');
                      },
                    ),
                    const Text(
                      '취침',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Image.asset('lib/assets/images/sun_image.png',
                          width: 50, height: 50),
                      onPressed: () {
                        _addRecord('기상');
                      },
                    ),
                    const Text(
                      '기상',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1),
          // 타임라인 섹션
          Expanded(
            child: ListView.builder(
              itemCount: _timeline.length,
              itemBuilder: (context, index) {
                final record = _timeline[index];
                return ListTile(
                  leading: const Icon(Icons.access_time,
                      color: Colors.yellow, size: 30),
                  title: Text(record['time']!,
                      style: const TextStyle(fontSize: 18)),
                  subtitle: Text(record['category']!,
                      style: const TextStyle(fontSize: 16)),
                );
              },
            ),
          ),
          // 하단 버튼 섹션
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showFullScreenDialog('사진 첨부');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDEDED),
                    minimumSize:
                        const Size(double.infinity, 50), // 버튼 폭을 화면 전체로
                  ),
                  child: const Text(
                    '사진 첨부',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16), // 버튼 간 간격
                ElevatedButton(
                  onPressed: () {
                    _showFullScreenDialog('메모 추가');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDEDED),
                    minimumSize:
                        const Size(double.infinity, 50), // 버튼 폭을 화면 전체로
                  ),
                  child: const Text(
                    '메모 추가',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.pushNamed(context, '/ai_recommend'); // AI 추천 페이지
          } else if (index == 1) {
            Navigator.pushNamed(context, '/schedule'); // 아이 일정 관리 페이지
          } else if (index == 2) {
            Navigator.pushNamed(context, '/pediatrics'); // 근처 소아과 찾기 페이지
          }
        },
        backgroundColor: const Color(0xFFDABF9C),
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
