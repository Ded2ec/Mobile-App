import 'package:flutter/material.dart';
import '../home_page.dart';

class CarrierErrorCodePage extends StatefulWidget {
  const CarrierErrorCodePage({Key? key}) : super(key: key);

  @override
  _CarrierErrorCodePageState createState() => _CarrierErrorCodePageState();
}

class _CarrierErrorCodePageState extends State<CarrierErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล Carrier
  final Map<String, List<Map<String, String>>> errorGroups = {
    "คอยล์เย็น": [
      {
        "code": "E1",
        "problem": "เซนเซอร์อุณหภูมิห้องผิดปกติ"
      },
      {
        "code": "E2",
        "problem": "เซนเซอร์คอยล์เย็นผิดปกติ"
      },
      {
        "code": "E3",
        "problem": "ความจุไม่สามารถตรวจจับได้หรือผิดปกติ"
      },
      {
        "code": "E4",
        "problem": "EEPROM (IC ความจำ) ผิดปกติ"
      },
      {
        "code": "E5",
        "problem": "มอเตอร์พัดลมในร่มผิดปกติ"
      },
      {
        "code": "E6",
        "problem": "การสื่อสารระหว่างตัวใน/ตัวนอกมีปัญหา"
      },
      {
        "code": "E7",
        "problem": "สวิตช์โหมดทำงานผิดปกติ"
      }
    ],
    "คอยล์ร้อน": [
      {
        "code": "F1",
        "problem": "กระแสไฟฟ้าเฟสผิดปกติ"
      },
      {
        "code": "F2",
        "problem": "แรงดันไฟฟ้าของวงจรหลักไม่ปกติ"
      },
      {
        "code": "F3",
        "problem": "เซนเซอร์ท่อระบายความร้อนผิดปกติ"
      },
      {
        "code": "F4",
        "problem": "เซนเซอร์อุณหภูมิอากาศภายนอกผิดปกติ"
      },
      {
        "code": "F5",
        "problem": "เซนเซอร์ท่อดูดก๊าซผิดปกติ"
      },
      {
        "code": "F6",
        "problem": "เซนเซอร์อุณหภูมิท่อจ่ายลมผิดปกติ"
      },
      {
        "code": "F7",
        "problem": "EEPROM (IC ความจำ) ตัวนอกผิดปกติ"
      },
      {
        "code": "F8",
        "problem": "มอเตอร์พัดลมคอยล์ร้อนผิดปกติ"
      },
      {
        "code": "F9",
        "problem": "IPM (Intelligent Power Module) ผิดปกติ"
      }
    ],
    "ระบบป้องกัน": [
      {
        "code": "P1",
        "problem": "ระบบป้องกันแรงดันสูง/ต่ำผิดปกติ"
      },
      {
        "code": "P2",
        "problem": "ระบบป้องกันอุณหภูมิสูงที่ท่อระบายความร้อน"
      },
      {
        "code": "P3",
        "problem": "ระบบป้องกันอุณหภูมิต่ำในโหมดทำความเย็น"
      },
      {
        "code": "P4",
        "problem": "ระบบป้องกันอุณหภูมิสูงในโหมดทำความร้อน"
      },
      {
        "code": "P5",
        "problem": "ระบบป้องกันอุณหภูมิสูงที่ท่อระบายความร้อนในโหมดทำความเย็น"
      },
      {
        "code": "P6",
        "problem": "ระบบป้องกันคอมเพรสเซอร์ทำงานมากเกินไป"
      },
      {
        "code": "P7",
        "problem": "ระบบป้องกันพายุหรือลมแรง"
      },
      {
        "code": "P8",
        "problem": "ระบบป้องกันอุณหภูมิระบายความร้อนสูงเกินไป"
      },
      {
        "code": "P9",
        "problem": "ระบบป้องกันการทำงานผิดปกติของวาล์ว 4 ทาง"
      }
    ]
  };

  // เพิ่มฟังก์ชันหาชื่อกลุ่มจาก error code
  String getGroupNameForError(String errorCode) {
    for (var entry in errorGroups.entries) {
      if (entry.value.any((error) => error['code'] == errorCode)) {
        return entry.key;
      }
    }
    return '';
  }

  List<Map<String, String>> _getFilteredErrors() {
    List<Map<String, String>> filteredList = [];
    
    if (selectedGroup.isEmpty) {
      // ถ้าไม่ได้เลือกกลุ่ม ให้แสดงทั้งหมด
      filteredList = errorGroups.values.expand((group) => group).toList();
    } else {
      // แสดงเฉพาะกลุ่มที่เลือก
      filteredList = errorGroups[selectedGroup] ?? [];
    }

    // กรองตามคำค้นหา
    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((error) {
        return error['code']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
               error['problem']!.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARRIER Error Codes'),
        backgroundColor: MyHomePage.appBarColor,
      ),
      body: Column(
        children: [
          // ช่องค้นหา
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหารหัสข้อผิดพลาดหรือปัญหา...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          // แถบเลือกกลุ่ม
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      FilterChip(
                        label: const Text('ทั้งหมด'),
                        selected: selectedGroup.isEmpty,
                        onSelected: (selected) {
                          setState(() {
                            selectedGroup = '';
                          });
                        },
                      ),
                      ...errorGroups.keys.map((group) => FilterChip(
                        label: Text(group),
                        selected: selectedGroup == group,
                        onSelected: (selected) {
                          setState(() {
                            selectedGroup = selected ? group : '';
                          });
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // แสดงรายการ Error Codes
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredErrors().length,
              itemBuilder: (context, index) {
                final error = _getFilteredErrors()[index];
                final groupName = getGroupNameForError(error['code']!);
                
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: ExpansionTile(
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text.rich(
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
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            groupName,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'ปัญหา: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'คำแนะนำในการแก้ไข:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: MyHomePage.textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (error['code']!.startsWith('E')) 
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของเซนเซอร์และวงจรควบคุม\n'
                                '2. ตรวจสอบค่าความต้านทานของเซนเซอร์\n'
                                '3. ตรวจสอบการทำงานของพัดลมในร่ม\n'
                                '4. ตรวจสอบหรือเปลี่ยนแผงวงจรหลักของเครื่องภายใน',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ\n'
                                '2. ตรวจสอบการเชื่อมต่อของเซนเซอร์คอยล์ร้อน\n'
                                '3. ตรวจสอบพัดลมคอยล์ร้อนและมอเตอร์\n'
                                '4. ตรวจสอบการทำงานของ IPM และแผงวงจรหลัก',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('P'))
                              Text(
                                '1. ตรวจสอบความดันของระบบทำความเย็น\n'
                                '2. ตรวจสอบการไหลเวียนของอากาศที่คอยล์ร้อน\n'
                                '3. ตรวจสอบการทำงานของวาล์วในระบบ\n'
                                '4. ตรวจสอบการรั่วของสารทำความเย็น',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'กรุณาติดต่อช่างผู้เชี่ยวชาญหรือศูนย์บริการ Carrier ใกล้บ้านคุณ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
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