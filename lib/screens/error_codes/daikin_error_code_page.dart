import 'package:flutter/material.dart';
import '../home_page.dart';

class DaikinErrorCodePage extends StatefulWidget {
  const DaikinErrorCodePage({Key? key}) : super(key: key);

  @override
  _DaikinErrorCodePageState createState() => _DaikinErrorCodePageState();
}

class _DaikinErrorCodePageState extends State<DaikinErrorCodePage> {
  String searchQuery = '';

  final List<Map<String, String>> daikinErrors = [
    {
      'code': 'A1',
      'problem': 'แผง PCB ชุดคอยล์เย็นเสียหรือไฟฟ้าตก',
    },
     {
      'code': 'A5',
      'problem': 'ระบบป้องกันการเป็นน้ำแข็ง',
    },
     {
      'code': 'A6',
      'problem': 'มอเตอร์คอยล์เย็นเสียหรือแผง PCB เสีย',
    },
     {
      'code': 'C4',
      'problem': 'เซ็นเชอร์น้ำแข็งค่าความต้านทานผิดปกติ',
    },
     {
      'code': 'C9',
      'problem': 'เซ็นเซอร์อุณหภูมิค่าความต้านทานผิดปกติ',
    },
     {
      'code': 'CC',
      'problem': 'เซ็นเซอร์ความชื้นค่าความต้านทานผิดปกติ',
    },
     {
      'code': 'U4',
      'problem': 'การส่งสัญญาณระห่างชุดคอยล์เย็นกับคอยล์ร้อนผิดปกติหรือแผง PCB ชุดคอยล์ร้อนเสีย',
    },
     {
      'code': 'F3',
      'problem': 'การทำงานผิดปกติของอุณหภูมิท่อด้านจ่าย',
    },
     {
      'code': 'L5',
      'problem': 'คอมเพรสเซอร์หรือแผง PCB ชุดคอยล์ร้อนเสีย',
    },
     {
      'code': 'H6',
      'problem': 'คอมเพรสเซอร์กินกระแสสูง',
    },
    {
      'code': 'H9',
      'problem': 'เซนเซอร์อุณหภูมิอากาศของชุดคอยล์ร้อนผิดปกติ',
    },
    {
      'code': 'J3',
      'problem': 'เซนเซอร์อุณหภูมิท่อด้านส่งผิดปกติ',
    },
    {
      'code': 'J6',
      'problem': 'เซนเซอร์อุณหภูมิแลกเปลี่ยนความร้อนผิดปกติ',
    },
    {
      'code': 'J8',
      'problem': 'เซนเซอร์อุณหภูมิท่อของเหลวผิดปกติ',
    },
    {
      'code': 'E7',
      'problem': 'มอเตอร์พัดลมคอยล์ร้อนเสียหรือ PCB เสีย',
    },
  ];

  List<Map<String, String>> get filteredErrors {
    if (searchQuery.isEmpty) {
      return daikinErrors;
    }
    return daikinErrors.where((error) =>
      error['code']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
      error['problem']!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DAIKIN Error Codes'),
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
                    title: Text.rich(
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
                            text: error['code'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyHomePage.textColor,
                            ),
                          ),
                        ],
                      ),
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