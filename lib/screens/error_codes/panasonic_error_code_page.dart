import 'package:flutter/material.dart';
import '../home_page.dart';

class PanasonicErrorCodePage extends StatefulWidget {
  const PanasonicErrorCodePage({Key? key}) : super(key: key);

  @override
  _PanasonicErrorCodePageState createState() => _PanasonicErrorCodePageState();
}

class _PanasonicErrorCodePageState extends State<PanasonicErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล Panasonic
  final Map<String, List<Map<String, String>>> errorGroups = {
    "เซนเซอร์": [
      {
        "code": "H11",
        "problem": "เซนเซอร์วัดอุณหภูมิห้องมีปัญหา"
      },
      {
        "code": "H12",
        "problem": "เซนเซอร์วัดอุณหภูมิคอมเพรสเซอร์มีปัญหา"
      },
      {
        "code": "H14",
        "problem": "เซนเซอร์วัดอุณหภูมิ Air Inlet มีปัญหา"
      },
      {
        "code": "H15",
        "problem": "เซนเซอร์วัดอุณหภูมิท่อจ่ายลมมีปัญหา"
      },
      {
        "code": "H16",
        "problem": "เซนเซอร์วัดกระแสไฟฟ้ามีปัญหา"
      },
      {
        "code": "H19",
        "problem": "เครื่องภายในไม่สามารถกำหนดรอบมอเตอร์ได้"
      },
      {
        "code": "H23",
        "problem": "เซนเซอร์วัดอุณหภูมิของเหลวมีปัญหา"
      },
      {
        "code": "H27",
        "problem": "เซนเซอร์วัดอุณหภูมิอากาศมีปัญหา"
      }
    ],
    "การสื่อสาร": [
      {
        "code": "H30",
        "problem": "เซนเซอร์อุณหภูมิท่อก๊าซร้อนมีปัญหา"
      },
      {
        "code": "H31",
        "problem": "เซนเซอร์วัดความชื้นมีปัญหา"
      },
      {
        "code": "H32",
        "problem": "เซนเซอร์วัดอุณหภูมิท่อก๊าซเย็นมีปัญหา"
      },
      {
        "code": "H33",
        "problem": "เซนเซอร์วัดการเชื่อมต่อผิดมีปัญหา"
      },
      {
        "code": "H34",
        "problem": "เซนเซอร์วัดอุณหภูมิ Heat sink อุปกรณ์ความร้อนมีปัญหา"
      },
      {
        "code": "H36",
        "problem": "เซนเซอร์วัดอุณหภูมิท่อก๊าซมีปัญหา"
      },
      {
        "code": "H97",
        "problem": "กลไกพัดลมภายนอกเกิดการติดขัด"
      },
      {
        "code": "H98",
        "problem": "การป้องกันความดันสูงภายในทำงาน"
      },
      {
        "code": "H99",
        "problem": "การป้องกันความเย็นตัวในภายในห้องทำงาน"
      }
    ],
    "การป้องกัน": [
      {
        "code": "F11",
        "problem": "4-way valve switching abnormal"
      },
      {
        "code": "F17",
        "problem": "การแช่แข็งของเครื่องภายในระหว่างการสแตนด์บาย"
      },
      {
        "code": "F90",
        "problem": "การป้องกันวงจรมีปัญหา"
      },
      {
        "code": "F91",
        "problem": "การป้องกันระบบทำความเย็นมีปัญหา"
      },
      {
        "code": "F93",
        "problem": "รอบคอมเพรสเซอร์ผิดปกติ"
      },
      {
        "code": "F94",
        "problem": "การป้องกันความดันดิสชาร์จเกิน"
      },
      {
        "code": "F95",
        "problem": "การป้องกันความดันคอนเดนเซอร์สูงเกิน"
      },
      {
        "code": "F96",
        "problem": "การป้องกันเกิดความร้อนสูงเกินที่ทรานซิสเตอร์กำลัง"
      },
      {
        "code": "F97",
        "problem": "การป้องกันความร้อนสูงเกินที่คอมเพรสเซอร์"
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
        title: const Text('PANASONIC Error Codes'),
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
                            if (error['code']!.startsWith('H1') || error['code']!.startsWith('H2') || error['code']!.startsWith('H3')) 
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของเซนเซอร์และขั้วต่อ\n'
                                '2. วัดค่าความต้านทานของเซนเซอร์\n'
                                '3. ตรวจสอบแผงวงจรควบคุมหลัก\n'
                                '4. เปลี่ยนเซนเซอร์หรือแผงวงจรที่มีปัญหา',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('H9'))
                              Text(
                                '1. ตรวจสอบกลไกการทำงานของพัดลม\n'
                                '2. ตรวจสอบมอเตอร์พัดลมและการหมุน\n'
                                '3. ตรวจสอบแหล่งจ่ายไฟ\n'
                                '4. ตรวจสอบวงจรควบคุมพัดลม',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบการทำงานของวาล์ว 4 ทาง\n'
                                '2. ตรวจสอบความดันของระบบ\n'
                                '3. ตรวจสอบการรั่วของสารทำความเย็น\n'
                                '4. ตรวจสอบการทำงานของคอมเพรสเซอร์',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'กรุณาติดต่อช่างผู้เชี่ยวชาญหรือศูนย์บริการ Panasonic ใกล้บ้านคุณ',
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