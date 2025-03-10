import 'package:flutter/material.dart';
import '../home_page.dart';

class LGErrorCodePage extends StatefulWidget {
  const LGErrorCodePage({Key? key}) : super(key: key);

  @override
  _LGErrorCodePageState createState() => _LGErrorCodePageState();
}

class _LGErrorCodePageState extends State<LGErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล
  final Map<String, List<Map<String, String>>> errorGroups = {
    'โค้ดแสดงความผิดปกติของคอยล์เป็น': [
     {
    "code": "1",
    "problem": "เซ็นเซอร์อุณหภูมิห้องเสีย"
  },
  {
    "code": "2",
    "problem": "เซ็นเซอร์อุณหภูมิท่อคอยล์เย็นขาเข้าเสีย"
  },
  {
    "code": "3",
    "problem": "รีโมทแบบสายมีปัญหา"
  },
  {
    "code": "4",
    "problem": "ไฟเวอร์ไดร์เสีย(ลอคฟัน)"
  },
  {
    "code": "5",
    "problem": "การสื่อสัญญาณระหว่างคอยล์เย็น-คอยล์ร้อนมีปัญหา"
  },
  {
    "code": "6",
    "problem": "เซ็นเซอร์อุณหภูมิท่อคอยล์เย็นขาออกเสีย"
  },
  {
    "code": "9",
    "problem": "EEPROM มีปัญหา(หน่วยความจำคอยล์เย็นเสีย)"
  },
  {
    "code": "10",
    "problem": "มอเตอร์พัดลมเย็น ล็อค/ไม่หมุน"
  },
  {
    "code": "12",
    "problem": "เซ็นเซอร์อุณหภูมิท่อคอยล์เย็น(กลางแลกเปลี่ยนเย็น) เสีย"
  },
    ],
    'โค้ดแสดงความผิดปกติของคอยดร้อน': [
      {
    "code": "21",
    "problem": "แรงดันไฟ DC /ไฟ แรงดันไฟต่ำมากเกินไป(IPM เสีย/ มีปัญหา)"
  },
  {
    "code": "22",
    "problem": "กระแสค่าไฟสูงวงจร(CT 2 ไอเวอร์ไดรฟ์)"
  },
  {
    "code": "23",
    "problem": "แรงดันไฟ DC Link ค่าต่ำผิดปกติ(ไฟฟ้าขาเข้าอาจไม่เพียงพอ)"
  },
  {
    "code": "26",
    "problem": "แรงดันไฟ DC Comp มีปัญหา"
  },
  {
    "code": "27",
    "problem": "PSC มีปัญหา"
  },
  {
    "code": "29",
    "problem": "กระแสคอมเพรสเซอร์ในแต่ละเฟสผิดปกติ(สายหลุด/หลวม/สายขาด)"
  },
    ],
    'โค้ดแสดงความผิดปกติของคอยล์ร้อน': [
      {
    "code": "32",
    "problem": "อุณหภูมิท่อคอยล์แคนเดนเซอร์ (หลายๆค่า) สูงเกินไป"
  },
  {
    "code": "34",
    "problem": "เซ็นเซอร์High Pressure จับแรงดันได้สูงเกินไป"
  },
  {
    "code": "35",
    "problem": "เซ็นเซอร์Low Pressure จับแรงดันได้ต่ำเกินไป"
  },
  {
    "code": "36(38)",
    "problem": "น้ำแข็งจับ"
  },
  {
    "code": "37",
    "problem": "อัตราส่วนการอัดอากาศต่างๆผิดปกติ"
  },
  {
    "code": "40",
    "problem": "เซ็นเซอร์วัดระบบแรงดัน (CT) มีปัญหา"
  },
  {
    "code": "41",
    "problem": "เซ็นเซอร์วัดอุณหภูมิปล่อยลมร้อน (หลายๆค่า) มีปัญหา"
  },
  {
    "code": "42",
    "problem": "เซ็นเซอร์Low Pressure เสีย/ มีปัญหา"
  },
  {
    "code": "43",
    "problem": "เซ็นเซอร์High Pressure เสีย/ มีปัญหา"
  },
  {
    "code": "44",
    "problem": "เซ็นเซอร์อุณหภูมิอุณหภูมิเสีย (อุณหภูมิอากาศภายนอกห้อง)"
  },
  {
    "code": "45",
    "problem": "เซ็นเซอร์อุณหภูมิท่อไม่ปล่อยลมร้อน (คอลเลค) มีปัญหา"
  },
  {
    "code": "46",
    "problem": "เซ็นเซอร์ท่อดูดมีปัญหา(Suction-Pipe Sensor Error)"
  },
  {
    "code": "51",
    "problem": "ขาดแรงลมที่ดูดเจอลมเย็นและเกิดลมรั่ว(ไม่ตรงกับแผนที่ไม่สมดุล)"
  },
  {
    "code": "53",
    "problem": "การสื่อสัญญาณระหว่างคอยล์เย็น-คอยล์ร้อน มีปัญหา"
  },
  {
    "code": "61",
    "problem": "อุณหภูมิเย็นและท่อไอน้ำแบบเซอร์มิสเตอร์"
  },
  {
    "code": "62",
    "problem": "Heat Sink ร้อนเกิน(อุณหาจะร้อนไม่แลกเปลี่ยนกับ IPM)"
  },
  {
    "code": "67",
    "problem": "DC Motor คอยล์ร้อนมีปัญหา(สายขาด/ หลวม/ มอเตอร์เสีย)"
  },
  {
    "code": "72",
    "problem": "วาวส์4 Way มีปัญหาหลุด/หลวม/ เสีย"
  }
    ],
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
        title: const Text('LG Error Codes'),
        backgroundColor: MyHomePage.appBarColor, // Use the static appBarColor
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
                  child: ListTile(
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
                                  fontWeight: FontWeight.w500,
                            ),
                          ),
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