import 'package:flutter/material.dart';
import '../home_page.dart';

class DaikinErrorCodePage extends StatefulWidget {
  const DaikinErrorCodePage({Key? key}) : super(key: key);

  @override
  _DaikinErrorCodePageState createState() => _DaikinErrorCodePageState();
}

class _DaikinErrorCodePageState extends State<DaikinErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล Daikin
  final Map<String, List<Map<String, String>>> errorGroups = {
    "ระบบแอร์/คอยล์เย็น": [
      {
        "code": "A0",
        "problem": "อุปกรณ์ป้องกันภายนอกทำงาน"
      },
      {
        "code": "A1",
        "problem": "PCB ตัวในห้องผิดปกติ"
      },
      {
        "code": "A3",
        "problem": "ระบบควบคุมระดับน้ำทิ้งทำงานผิดปกติ"
      },
      {
        "code": "A5",
        "problem": "ระบบป้องกันความเย็นต่ำหรือระบบควบคุมความร้อนสูงทำงาน"
      },
      {
        "code": "A6",
        "problem": "มอเตอร์พัดลมชำรุดหรือทำงานผิดปกติ"
      },
      {
        "code": "A7",
        "problem": "ชุดบังคับทิศทางลมทำงานผิดปกติ"
      },
      {
        "code": "A8",
        "problem": "ช่องจ่ายไฟมีปัญหา"
      },
      {
        "code": "A9",
        "problem": "วาล์วขยายตัวควบคุมด้วยไฟฟ้าผิดปกติ"
      },
      {
        "code": "AF",
        "problem": "ระบบน้ำทิ้งล้น (ในร่ม)"
      }
    ],
    "ระบบคอยล์ร้อน": [
      {
        "code": "E0",
        "problem": "อุปกรณ์ป้องกันทำงาน (ภายนอก)"
      },
      {
        "code": "E1",
        "problem": "PCB ตัวนอกห้องผิดปกติ"
      },
      {
        "code": "E3",
        "problem": "ความดันสูงมีปัญหา"
      },
      {
        "code": "E4",
        "problem": "ความดันต่ำมีปัญหา"
      },
      {
        "code": "E5",
        "problem": "คอมเพรสเซอร์มอเตอร์ล็อค"
      },
      {
        "code": "E6",
        "problem": "คอมเพรสเซอร์ล็อคเนื่องจากกระแสเกิน"
      },
      {
        "code": "E7",
        "problem": "มอเตอร์พัดลมคอยล์ร้อนล็อค"
      },
      {
        "code": "E8",
        "problem": "กระแสไฟเข้าเกิน"
      },
      {
        "code": "E9",
        "problem": "วาล์วขยายตัวควบคุมด้วยไฟฟ้าทำงานผิดปกติ (ภายนอก)"
      }
    ],
    "การสื่อสารและเซนเซอร์": [
      {
        "code": "F3",
        "problem": "อุณหภูมิท่อระบายความร้อนผิดปกติ"
      },
      {
        "code": "F6",
        "problem": "ความดันสูงผิดปกติ (ในโหมดทำความเย็น)"
      },
      {
        "code": "H0",
        "problem": "เซนเซอร์ในระบบคอมเพรสเซอร์ทำงานผิดปกติ"
      },
      {
        "code": "H3",
        "problem": "สวิตช์ความดันสูงทำงานผิดปกติ"
      },
      {
        "code": "H4",
        "problem": "สวิตช์ความดันต่ำทำงานผิดปกติ"
      },
      {
        "code": "H6",
        "problem": "เซนเซอร์ตรวจจับตำแหน่งทำงานผิดปกติ"
      },
      {
        "code": "H7",
        "problem": "เซนเซอร์มอเตอร์พัดลมภายนอกมีปัญหา"
      },
      {
        "code": "H8",
        "problem": "เซนเซอร์กระแสไฟฟ้าทำงานผิดปกติ"
      },
      {
        "code": "H9",
        "problem": "เซนเซอร์อุณหภูมิอากาศภายนอกทำงานผิดปกติ"
      },
      {
        "code": "J3",
        "problem": "เซนเซอร์อุณหภูมิท่อระบายความร้อนทำงานผิดปกติ"
      },
      {
        "code": "J5",
        "problem": "เซนเซอร์อุณหภูมิท่อดูดทำงานผิดปกติ"
      },
      {
        "code": "J6",
        "problem": "เซนเซอร์อุณหภูมิแลกเปลี่ยนความร้อนทำงานผิดปกติ"
      },
      {
        "code": "J7",
        "problem": "เซนเซอร์อุณหภูมิท่อของเหลวทำงานผิดปกติ"
      },
      {
        "code": "J8",
        "problem": "เซนเซอร์อุณหภูมิท่อก๊าซทำงานผิดปกติ"
      },
      {
        "code": "J9",
        "problem": "เซนเซอร์อุณหภูมิท่อก๊าซแลกเปลี่ยนความร้อนทำงานผิดปกติ"
      },
      {
        "code": "JA",
        "problem": "เซนเซอร์ความดันท่อระบายความร้อนทำงานผิดปกติ"
      },
      {
        "code": "JC",
        "problem": "เซนเซอร์ความดันท่อดูดทำงานผิดปกติ"
      },
      {
        "code": "C4",
        "problem": "เซนเซอร์อุณหภูมิแลกเปลี่ยนความร้อนทำงานผิดปกติ (ในร่ม)"
      },
      {
        "code": "C5",
        "problem": "เซนเซอร์อุณหภูมิแลกเปลี่ยนความร้อนทำงานผิดปกติ (ในร่ม)"
      },
      {
        "code": "C9",
        "problem": "เซนเซอร์อุณหภูมิอากาศดูดเข้าทำงานผิดปกติ"
      },
      {
        "code": "CA",
        "problem": "เซนเซอร์อุณหภูมิอากาศระบายออกทำงานผิดปกติ"
      },
      {
        "code": "CE",
        "problem": "เซนเซอร์อินฟราเรดสำหรับตรวจจับมนุษย์ทำงานผิดปกติ"
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
        title: const Text('DAIKIN Error Codes'),
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
                            if (error['code']!.startsWith('A')) 
                              Text(
                                '1. ตรวจสอบระบบไฟฟ้าและการเชื่อมต่อของคอยล์เย็น\n'
                                '2. ตรวจเช็คแผงวงจรหลักของเครื่องภายใน\n'
                                '3. ตรวจสอบการทำงานของพัดลมและมอเตอร์\n'
                                '4. ตรวจสอบระบบระบายน้ำทิ้ง หรือติดต่อช่างผู้เชี่ยวชาญ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('E'))
                              Text(
                                '1. ตรวจสอบระบบไฟฟ้าและการเชื่อมต่อของคอยล์ร้อน\n'
                                '2. ตรวจวัดความดันในระบบทำความเย็น\n'
                                '3. ตรวจสอบการทำงานของคอมเพรสเซอร์\n'
                                '4. ตรวจสอบพัดลมคอยล์ร้อน',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('H') || error['code']!.startsWith('J') || error['code']!.startsWith('C') || error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของเซนเซอร์\n'
                                '2. ตรวจวัดค่าความต้านทานของเซนเซอร์\n'
                                '3. ตรวจสอบคอนเน็คเตอร์และสายไฟ\n'
                                '4. เปลี่ยนเซนเซอร์ที่เสียหรือแผงวงจรที่มีปัญหา',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'กรุณาติดต่อช่างผู้เชี่ยวชาญหรือศูนย์บริการ Daikin ใกล้บ้านคุณ',
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