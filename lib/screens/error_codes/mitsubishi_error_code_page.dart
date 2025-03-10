import 'package:flutter/material.dart';
import '../home_page.dart';

class MitsubishiErrorCodePage extends StatefulWidget {
  const MitsubishiErrorCodePage({Key? key}) : super(key: key);

  @override
  State<MitsubishiErrorCodePage> createState() => _MitsubishiErrorCodePageState();
}

class _MitsubishiErrorCodePageState extends State<MitsubishiErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล Mitsubishi
  final Map<String, List<Map<String, String>>> errorGroups = {
    "ระบบแผงวงจร": [
      {
        "code": "E1",
        "problem": "แผงวงจรรีโมทคอนโทรลผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "สังเกตที่รีโมทคอนโทรล"
      },
      {
        "code": "E2",
        "problem": "แผงวงจรหลักผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "สังเกตที่บอร์ดควบคุมหลัก"
      },
      {
        "code": "E3",
        "problem": "การสื่อสารระหว่างรีโมทคอนโทรลและตัวในห้องมีปัญหา",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบการส่งสัญญาณระหว่างรีโมทและเครื่อง"
      },
      {
        "code": "E4",
        "problem": "การสื่อสารระหว่างตัวในห้องและตัวนอกห้องมีปัญหา",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบการเชื่อมต่อระหว่างเครื่องใน/นอก"
      },
      {
        "code": "E5",
        "problem": "แรงดันไฟฟ้าผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบแรงดันไฟฟ้าขาเข้า"
      }
    ],
    "เซนเซอร์": [
      {
        "code": "E6",
        "problem": "เซนเซอร์อุณหภูมิตัวในห้องผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบเซนเซอร์วัดอุณหภูมิห้อง"
      },
      {
        "code": "E7",
        "problem": "เซนเซอร์อุณหภูมิคอยล์เย็นผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบเซนเซอร์แผงคอยล์เย็น"
      },
      {
        "code": "E8",
        "problem": "เซนเซอร์อุณหภูมิตัวนอกห้องผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบเซนเซอร์อุณหภูมิภายนอก"
      },
      {
        "code": "E9",
        "problem": "เซนเซอร์อุณหภูมิคอยล์ร้อนผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบเซนเซอร์แผงคอยล์ร้อน"
      },
      {
        "code": "EA",
        "problem": "เซนเซอร์อุณหภูมิท่อดิสชาร์จผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบเซนเซอร์ท่อทางออกคอมเพรสเซอร์"
      }
    ],
    "ระบบมอเตอร์": [
      {
        "code": "EE",
        "problem": "มอเตอร์พัดลมตัวในห้องทำงานผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบมอเตอร์และพัดลมคอยล์เย็น"
      },
      {
        "code": "EF",
        "problem": "มอเตอร์พัดลมตัวนอกห้องทำงานผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบมอเตอร์และพัดลมคอยล์ร้อน"
      }
    ],
    "ระบบป้องกัน": [
      {
        "code": "F1",
        "problem": "ความดันสูงผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน/ทำงานต่อหลังแก้ไข",
        "control": "ตรวจสอบความดันของระบบ"
      },
      {
        "code": "F3",
        "problem": "อุณหภูมิคอมเพรสเซอร์สูงเกินไป",
        "status": "ระบบแอร์หยุดการทำงาน/ทำงานต่อหลังแก้ไข",
        "control": "ตรวจสอบอุณหภูมิที่คอมเพรสเซอร์"
      },
      {
        "code": "F4",
        "problem": "คอมเพรสเซอร์ทำงานผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบการทำงานของคอมเพรสเซอร์"
      },
      {
        "code": "F5",
        "problem": "กระแสไฟฟ้าเกินกำหนด",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบกำลังไฟฟ้าที่ใช้"
      },
      {
        "code": "F6",
        "problem": "IPM (Intelligent Power Module) ผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบโมดูลแปลงกำลังไฟฟ้า"
      },
      {
        "code": "F8",
        "problem": "PFC (Power Factor Correction) ผิดปกติ",
        "status": "ระบบแอร์หยุดการทำงาน",
        "control": "ตรวจสอบวงจรแก้ไขค่าตัวประกอบกำลัง"
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
               error['problem']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
               (error['status'] != null && error['status']!.toLowerCase().contains(searchQuery.toLowerCase())) ||
               (error['control'] != null && error['control']!.toLowerCase().contains(searchQuery.toLowerCase()));
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MITSUBISHI Error Codes'),
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
                        if (error['status'] != null) ...[
                          const SizedBox(height: 4),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'สถานะการทำงาน: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: error['status'],
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: MyHomePage.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (error['control'] != null) ...[
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'จุดสังเกต: ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextSpan(
                                      text: error['control'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: MyHomePage.textColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                            Text(
                              'วิธีแก้ไข:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: MyHomePage.textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (error['code']!.startsWith('E1') || error['code']!.startsWith('E2') || error['code']!.startsWith('E3') || error['code']!.startsWith('E4') || error['code']!.startsWith('E5')) 
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของสายไฟระหว่างชุดควบคุม\n'
                                '2. ตรวจวัดแรงดันไฟฟ้าที่จ่ายให้ระบบ\n'
                                '3. ตรวจสอบแผงวงจรที่เกี่ยวข้อง\n'
                                '4. เปลี่ยนอุปกรณ์ที่มีปัญหา',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('E6') || error['code']!.startsWith('E7') || error['code']!.startsWith('E8') || error['code']!.startsWith('E9') || error['code']!.startsWith('EA'))
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของเซนเซอร์\n'
                                '2. วัดค่าความต้านทานของเซนเซอร์\n'
                                '3. ตรวจสอบสายไฟและขั้วต่อ\n'
                                '4. เปลี่ยนเซนเซอร์ถ้าจำเป็น',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('EE') || error['code']!.startsWith('EF'))
                              Text(
                                '1. ตรวจสอบการหมุนของพัดลม\n'
                                '2. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้มอเตอร์\n'
                                '3. ตรวจสอบขดลวดของมอเตอร์\n'
                                '4. เปลี่ยนมอเตอร์หรือพัดลมถ้าจำเป็น',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบความดันของระบบทำความเย็น\n'
                                '2. ตรวจสอบการทำงานของคอมเพรสเซอร์\n'
                                '3. ตรวจสอบสารทำความเย็นในระบบ\n'
                                '4. ตรวจสอบแผงวงจรที่เกี่ยวข้อง',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'กรุณาติดต่อช่างผู้เชี่ยวชาญหรือศูนย์บริการ Mitsubishi ใกล้บ้านคุณ',
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