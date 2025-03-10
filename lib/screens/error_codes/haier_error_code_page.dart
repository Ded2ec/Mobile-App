import 'package:flutter/material.dart';
import '../home_page.dart';

class HaierErrorCodePage extends StatefulWidget {
  const HaierErrorCodePage({Key? key}) : super(key: key);

  @override
  _HaierErrorCodePageState createState() => _HaierErrorCodePageState();
}

class _HaierErrorCodePageState extends State<HaierErrorCodePage> {
  String searchQuery = '';

  final List<Map<String, dynamic>> haierErrors = [
   {
          'code': 'E12',
          'LED_blink': 1,
          'problem': 'ข้อมูลใน EEPROM เสียหาย',
          
        },
        {
          'code': 'F1',
          'LED_blink': 2,
          'problem': 'เซนเซอร์ในห้อง',
          
        },
        {
          'code': 'F22',
          'LED_blink': 3,
          'problem': 'การแสดงฟังก์ชั่นการสูญเสียกำลังไฟ',
          
        },
        {
          'code': 'F3',
          'LED_blink': 4,
          'problem': 'การป้องกัน รันฟ์สร้อยกระทำงานบกพร่อง และเซนเซอร์ในห้อง',
          
        },
        {
          'code': 'F20',
          'LED_blink': 6,
          'problem': 'มอเตอร์เข้าไม่ถึงเครื่องสูงสุด หรือ ล้ำเกินไป',
          
        },
        {
          'code': 'F4',
          'LED_blink': 8,
          'problem': 'อุณหภูมิที่ท่อท่อเย็นวัดที่ท่อกลางๆ สูงเกินไป',
          
        },
        {
          'code': 'F21',
          'LED_blink': 10,
          'problem': 'เซนเซอร์ป้องกันน้ำซึมการทำแห้งคอนเดนเซอร์เสีย',
          
        },
        {
          'code': 'F6',
          'LED_blink': 12,
          'problem': 'เซนเซอร์ตรวจจับอุณหภูมิกระเปาะเปียกเสีย',
          
        },
        {
          'code': 'F25',
          'LED_blink': 13,
          'problem': 'เซนเซอร์ตรวจจับอุณหภูมิที่ท่อกลางเสีย',
          
        },
        {
          'code': 'F11',
          'LED_blink': 18,
          'problem': 'วงจรการจับค่าตำแหน่งของมอเตอร์เสียหา',
          
        },
        {
          'code': 'F28',
          'LED_blink': 19,
          'problem': 'เซนเซอร์ในห้อง',
          
        },
        {
          'code': 'F2',
          'LED_blink': 24,
          'problem': 'คอมเพรสเซอร์ไม่การะแสไฟ',
          
        },
        {
          'code': 'F23',
          'LED_blink': 25,
          'problem': 'การแสดงฟังก์ชั่นของกระแสไฟที่เข้าไฟเยอะๆ สูงไป',
          
        }
  ];

  List<Map<String, dynamic>> get filteredErrors {
    if (searchQuery.isEmpty) {
      return haierErrors;
    }
    return haierErrors.where((error) =>
      error['code'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      error['problem'].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HAIER Error Codes'),
        backgroundColor: MyHomePage.appBarColor, // Use the static appBarColor
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหารหัสข้อผิดพลาดหรือปัญหา...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredErrors.length,
              itemBuilder: (context, index) {
                final error = filteredErrors[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: ListTile(
                    title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Error: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: '${error['code']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: MyHomePage.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                        const SizedBox(height: 8), // Add spacing
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline,
                              size: 16,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                Text(
                              'ไฟกระพริบ ${error['LED_blink']} ครั้ง',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                      subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'ปัญหา: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: MyHomePage.textColor,
                            ),
                          ),
                          TextSpan(
                            text: error['problem'],
                            style: TextStyle(
                              fontSize: 14,
                              color: MyHomePage.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 