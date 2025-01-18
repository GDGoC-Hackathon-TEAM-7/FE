import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PediatricsScreen extends StatelessWidget {
  const PediatricsScreen({Key? key}) : super(key: key);

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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GoogleMap(
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(37.5639, 127.0364), // 성동구 좌표
                        zoom: 14.0,
                      ),
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                          markerId: const MarkerId('hospital1'),
                          position: const LatLng(37.5645, 127.0383), // 예시 병원 위치
                          infoWindow: const InfoWindow(title: '도담 소아과'),
                        ),
                        Marker(
                          markerId: const MarkerId('hospital2'),
                          position: const LatLng(37.5622, 127.0347), // 예시 병원 위치
                          infoWindow: const InfoWindow(title: '사랑 소아과'),
                        ),
                      },
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
