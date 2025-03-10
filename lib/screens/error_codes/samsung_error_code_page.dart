import 'package:flutter/material.dart';
import '../home_page.dart';

class SamsungErrorCodePage extends StatefulWidget {
  const SamsungErrorCodePage({Key? key}) : super(key: key);

  @override
  _SamsungErrorCodePageState createState() => _SamsungErrorCodePageState();
}

class _SamsungErrorCodePageState extends State<SamsungErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // Add these constants at the top of the class
  static const String PROBLEM_LABEL = 'ปัญหา: ';
  static const String SOLUTION_LABEL = 'วิธีแก้ไข: ';

  final Map<String, List<Map<String, String>>> errorGroups = {
    "ระบบภายใน": [
      {
        "code": "E101",
        "problem": "เซ็นเซอร์อุณหภูมิห้องเสีย",
        "solution": "1. ตรวจสอบการเชื่อมต่อของเซ็นเซอร์อุณหภูมิห้อง\n2. ตรวจสอบค่าความต้านทานของเซ็นเซอร์\n3. เปลี่ยนเซ็นเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E102",
        "problem": "เซ็นเซอร์อุณหภูมิคอยล์เย็นเสีย",
        "solution": "1. ตรวจสอบการเชื่อมต่อของเซ็นเซอร์อุณหภูมิคอยล์เย็น\n2. ตรวจสอบค่าความต้านทานของเซ็นเซอร์\n3. เปลี่ยนเซ็นเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E121",
        "problem": "มอเตอร์พัดลมคอยล์เย็นทำงานผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของมอเตอร์พัดลม\n2. ตรวจสอบการหมุนของพัดลม\n3. เปลี่ยนมอเตอร์พัดลมหากพบว่าเสีย"
      },
      {
        "code": "E154",
        "problem": "พัดลมคอยล์เย็นทำงานผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของพัดลม\n2. ตรวจสอบการหมุนของพัดลม\n3. เปลี่ยนพัดลมหากพบว่าเสีย"
      },
      {
        "code": "E162",
        "problem": "ข้อผิดพลาดของ EEPROM ภายใน",
        "solution": "1. รีเซ็ตเครื่องปรับอากาศ\n2. ตรวจสอบแผงวงจรควบคุม\n3. เปลี่ยนแผงวงจรควบคุมหากจำเป็น"
      },
      {
        "code": "E163",
        "problem": "ข้อผิดพลาดของ MCU ภายใน",
        "solution": "1. รีเซ็ตเครื่องปรับอากาศ\n2. ตรวจสอบแผงวงจรควบคุม\n3. เปลี่ยนแผงวงจรควบคุมหากจำเป็น"
      }
    ],
    "ระบบภายนอก": [
      {
        "code": "E201",
        "problem": "เซ็นเซอร์อุณหภูมิภายนอกเสีย",
        "solution": "1. ตรวจสอบการเชื่อมต่อของเซ็นเซอร์อุณหภูมิภายนอก\n2. ตรวจสอบค่าความต้านทานของเซ็นเซอร์\n3. เปลี่ยนเซ็นเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E202",
        "problem": "เซ็นเซอร์อุณหภูมิคอยล์ร้อนเสีย",
        "solution": "1. ตรวจสอบการเชื่อมต่อของเซ็นเซอร์อุณหภูมิคอยล์ร้อน\n2. ตรวจสอบค่าความต้านทานของเซ็นเซอร์\n3. เปลี่ยนเซ็นเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E203",
        "problem": "เซ็นเซอร์อุณหภูมิท่อจ่ายเสีย",
        "solution": "1. ตรวจสอบการเชื่อมต่อของเซ็นเซอร์อุณหภูมิท่อจ่าย\n2. ตรวจสอบค่าความต้านทานของเซ็นเซอร์\n3. เปลี่ยนเซ็นเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E221",
        "problem": "มอเตอร์พัดลมคอยล์ร้อนทำงานผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของมอเตอร์พัดลม\n2. ตรวจสอบการหมุนของพัดลม\n3. เปลี่ยนมอเตอร์พัดลมหากพบว่าเสีย"
      },
      {
        "code": "E251",
        "problem": "ข้อผิดพลาดของวาล์วสี่ทาง",
        "solution": "1. ตรวจสอบการเชื่อมต่อของวาล์วสี่ทาง\n2. ตรวจสอบการทำงานของวาล์ว\n3. เปลี่ยนวาล์วหากพบว่าเสีย"
      },
      {
        "code": "E416",
        "problem": "อุณหภูมิท่อจ่ายสูงเกินไป",
        "solution": "1. ตรวจสอบปริมาณสารทำความเย็น\n2. ตรวจสอบการไหลเวียนของอากาศที่คอยล์ร้อน\n3. ตรวจสอบการทำงานของพัดลมคอยล์ร้อน"
      },
      {
        "code": "E422",
        "problem": "แรงดันไฟฟ้าสูงเกินไป",
        "solution": "1. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ\n2. ติดตั้งเครื่องปรับแรงดันไฟฟ้าหากจำเป็น"
      },
      {
        "code": "E440",
        "problem": "โหมดทำความร้อนทำงานผิดปกติ",
        "solution": "1. ตรวจสอบการทำงานของวาล์วสี่ทาง\n2. ตรวจสอบปริมาณสารทำความเย็น\n3. ตรวจสอบการทำงานของระบบละลายน้ำแข็ง"
      }
    ],
    "การสื่อสาร": [
      {
        "code": "E301",
        "problem": "การสื่อสารระหว่างตัวในและตัวนอกผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อสายสัญญาณระหว่างตัวในและตัวนอก\n2. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ\n3. ตรวจสอบแผงวงจรควบคุมทั้งตัวในและตัวนอก"
      },
      {
        "code": "E302",
        "problem": "การสื่อสารระหว่างแผงควบคุมหลักและจอแสดงผลผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อสายสัญญาณระหว่างแผงควบคุมหลักและจอแสดงผล\n2. ตรวจสอบแผงวงจรควบคุมและจอแสดงผล\n3. เปลี่ยนอุปกรณ์ที่เสียหาก"
      },
      {
        "code": "E306",
        "problem": "การสื่อสารระหว่างอินเวอร์เตอร์และแผงควบคุมหลักผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อสายสัญญาณระหว่างอินเวอร์เตอร์และแผงควบคุมหลัก\n2. ตรวจสอบแผงวงจรอินเวอร์เตอร์และแผงควบคุมหลัก\n3. เปลี่ยนอุปกรณ์ที่เสียหากจำเป็น"
      }
    ],
    "ระบบป้องกัน": [
      {
        "code": "E401",
        "problem": "ความดันสูงผิดปกติ",
        "solution": "1. ตรวจสอบการไหลเวียนของอากาศที่คอยล์ร้อน\n2. ตรวจสอบการทำงานของพัดลมคอยล์ร้อน\n3. ตรวจสอบปริมาณสารทำความเย็น"
      },
      {
        "code": "E404",
        "problem": "ความดันต่ำผิดปกติ",
        "solution": "1. ตรวจสอบการรั่วของสารทำความเย็น\n2. ตรวจสอบการทำงานของวาล์วขยายตัว\n3. ตรวจสอบการอุดตันของระบบ"
      },
      {
        "code": "E407",
        "problem": "อุณหภูมิคอยล์เย็นต่ำเกินไป",
        "solution": "1. ตรวจสอบการไหลเวียนของอากาศที่คอยล์เย็น\n2. ตรวจสอบการทำงานของพัดลมคอยล์เย็น\n3. ตรวจสอบปริมาณสารทำความเย็น"
      },
      {
        "code": "E408",
        "problem": "คอมเพรสเซอร์ทำงานเกินกำลัง",
        "solution": "1. ตรวจสอบปริมาณสารทำความเย็น\n2. ตรวจสอบการอุดตันของระบบ\n3. ตรวจสอบการทำงานของคอมเพรสเซอร์"
      },
      {
        "code": "E410",
        "problem": "ปริมาณสารทำความเย็นต่ำเกินไป",
        "solution": "1. ตรวจสอบการรั่วของสารทำความเย็น\n2. เติมสารทำความเย็นตามปริมาณที่กำหนด"
      },
      {
        "code": "E419",
        "problem": "การทำงานของ EEV ผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของ EEV\n2. ตรวจสอบการทำงานของ EEV\n3. เปลี่ยน EEV หากพบว่าเสีย"
      }
    ],
    "อินเวอร์เตอร์": [
      {
        "code": "E425",
        "problem": "เฟสไฟฟ้าผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อสายไฟฟ้า\n2. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ"
      },
      {
        "code": "E428",
        "problem": "กระแสไฟฟ้าสูงเกินไป",
        "solution": "1. ตรวจสอบการทำงานของคอมเพรสเซอร์\n2. ตรวจสอบปริมาณสารทำความเย็น\n3. ตรวจสอบการอุดตันของระบบ"
      },
      {
        "code": "E430",
        "problem": "แรงดันไฟฟ้า DC สูงเกินไป",
        "solution": "1. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ\n2. ตรวจสอบแผงวงจรอินเวอร์เตอร์\n3. เปลี่ยนแผงวงจรอินเวอร์เตอร์หากจำเป็น"
      },
      {
        "code": "E432",
        "problem": "อุณหภูมิของอินเวอร์เตอร์สูงเกินไป",
        "solution": "1. ตรวจสอบการระบายความร้อนของอินเวอร์เตอร์\n2. ตรวจสอบการทำงานของพัดลมระบายความร้อน\n3. ตรวจสอบแผงวงจรอินเวอร์เตอร์"
      },
      {
        "code": "E434",
        "problem": "การทำงานของคอมเพรสเซอร์ผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของคอมเพรสเซอร์\n2. ตรวจสอบการทำงานของคอมเพรสเซอร์\n3. เปลี่ยนคอมเพรสเซอร์หากพบว่าเสีย"
      },
      {
        "code": "E436",
        "problem": "การทำงานของมอเตอร์คอมเพรสเซอร์ผิดปกติ",
        "solution": "1. ตรวจสอบการเชื่อมต่อของมอเตอร์คอมเพรสเซอร์\n2. ตรวจสอบการทำงานของมอเตอร์\n3. เปลี่ยนมอเตอร์หากพบว่าเสีย"
      }
    ]
  };

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
               error['problem']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
               error['solution']!.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }
    
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAMSUNG Error Codes'),
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
                final groupName = errorGroups.entries
                    .firstWhere(
                      (entry) => entry.value.contains(error),
                      orElse: () => MapEntry('', []),
                    )
                    .key;

                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: ExpansionTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'กลุ่ม: $groupName',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
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
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: PROBLEM_LABEL,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                            const SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: SOLUTION_LABEL,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: error['solution'],
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