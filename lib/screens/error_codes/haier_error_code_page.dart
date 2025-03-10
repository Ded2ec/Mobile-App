import 'package:flutter/material.dart';
import '../home_page.dart';

class HaierErrorCodePage extends StatefulWidget {
  const HaierErrorCodePage({Key? key}) : super(key: key);

  @override
  _HaierErrorCodePageState createState() => _HaierErrorCodePageState();
}

class _HaierErrorCodePageState extends State<HaierErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล Haier
  final Map<String, List<Map<String, String>>> errorGroups = {
    "ระบบไฟฟ้า": [
      {
        "code": "E1",
        "problem": "แรงดันไฟฟ้าสูงเกินไป",
        "LED_blink": "1"
      },
      {
        "code": "E2",
        "problem": "ป้องกันกระแสไฟเกิน/คอยล์เย็น",
        "LED_blink": "2"
      },
      {
        "code": "E3",
        "problem": "ความเร็วพัดลมในร่มต่ำเกินไป",
        "LED_blink": "3"
      },
      {
        "code": "E4",
        "problem": "เซนเซอร์คอยล์เย็นลัดวงจรหรือวงจรเปิด",
        "LED_blink": "4"
      },
      {
        "code": "E5",
        "problem": "เซนเซอร์อุณหภูมิห้องลัดวงจร/วงจรเปิด",
        "LED_blink": "5"
      },
      {
        "code": "E6",
        "problem": "การสื่อสารระหว่างในร่มและนอกร่มล้มเหลว",
        "LED_blink": "6"
      },
      {
        "code": "P1",
        "problem": "ป้องกันความดันสูง",
        "LED_blink": "7"
      }
    ],
    "ระบบนอกอาคาร": [
      {
        "code": "P3",
        "problem": "ป้องกันแรงดันต่ำ",
        "LED_blink": "9"
      },
      {
        "code": "P4",
        "problem": "อุณหภูมิท่อระบายความร้อนสูงเกินไป",
        "LED_blink": "10"
      },
      {
        "code": "P5",
        "problem": "ป้องกันอุณหภูมิต่ำในโหมดทำความเย็น",
        "LED_blink": "11"
      },
      {
        "code": "P6",
        "problem": "ป้องกันโหมดความดันต่ำ",
        "LED_blink": "12"
      },
      {
        "code": "P7",
        "problem": "ป้องกันการละลายน้ำแข็ง",
        "LED_blink": "13"
      },
      {
        "code": "P8",
        "problem": "ป้องกันอุณหภูมิท่อระบายสูงเกินไป",
        "LED_blink": "16"
      }
    ],
    "เซนเซอร์/อุปกรณ์": [
      {
        "code": "F1",
        "problem": "คอมเพรสเซอร์ล้มเหลว",
        "LED_blink": "15"
      },
      {
        "code": "F2",
        "problem": "PFC ล้มเหลว",
        "LED_blink": "17"
      },
      {
        "code": "F3",
        "problem": "คอมเพรสเซอร์เริ่มทำงานล้มเหลว",
        "LED_blink": "18"
      },
      {
        "code": "F4",
        "problem": "IPM ล้มเหลว",
        "LED_blink": "19"
      },
      {
        "code": "F5",
        "problem": "การตั้งค่าจัมเปอร์ผิดพลาด",
        "LED_blink": "20"
      },
      {
        "code": "F6",
        "problem": "เซนเซอร์อุณหภูมิคอยล์นอกร่มลัดวงจรหรือวงจรเปิด",
        "LED_blink": "21"
      },
      {
        "code": "F7",
        "problem": "เซนเซอร์อุณหภูมิอากาศภายนอกลัดวงจรหรือวงจรเปิด",
        "LED_blink": "22"
      },
      {
        "code": "F8",
        "problem": "เซนเซอร์ท่อดูดลัดวงจรหรือวงจรเปิด",
        "LED_blink": "23"
      },
      {
        "code": "F9",
        "problem": "เซนเซอร์ทางออกคอมเพรสเซอร์ลัดวงจรหรือวงจรเปิด",
        "LED_blink": "24"
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
        title: const Text('HAIER Error Codes'),
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (error['LED_blink'] != null)
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
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        Text.rich(
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
                      ],
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
                                '1. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้แอร์\n'
                                '2. ตรวจสอบเซนเซอร์และการเชื่อมต่อ\n'
                                '3. ตรวจสอบพัดลมคอยล์เย็นและมอเตอร์\n'
                                '4. ตรวจสอบแผงวงจรควบคุมภายใน',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('P'))
                              Text(
                                '1. ตรวจสอบสารทำความเย็นและความดันในระบบ\n'
                                '2. ทำความสะอาดแผงคอยล์ร้อนและคอยล์เย็น\n'
                                '3. ตรวจสอบการทำงานของวาล์ว\n'
                                '4. ตรวจสอบฟิลเตอร์อากาศ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบคอมเพรสเซอร์และการเชื่อมต่อ\n'
                                '2. ตรวจสอบการทำงานของ PFC หรือ IPM\n'
                                '3. ตรวจสอบเซนเซอร์ภายนอกอาคาร\n'
                                '4. ตรวจสอบแผงวงจรควบคุมภายนอก',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'กรุณาติดต่อช่างผู้เชี่ยวชาญหรือศูนย์บริการ Haier ใกล้บ้านคุณ',
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