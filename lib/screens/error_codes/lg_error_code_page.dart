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

  // กำหนดกลุ่มข้อมูล LG
  final Map<String, List<Map<String, String>>> errorGroups = {
    "เซนเซอร์และการเชื่อมต่อ": [
      {
        "code": "CH01",
        "problem": "เซนเซอร์วัดอุณหภูมิห้องผิดปกติ"
      },
      {
        "code": "CH02",
        "problem": "เซนเซอร์วัดอุณหภูมิ Indoor coil ผิดปกติ"
      },
      {
        "code": "CH06",
        "problem": "เซนเซอร์วัดอุณหภูมิ Outdoor coil ผิดปกติ"
      },
      {
        "code": "CH09",
        "problem": "EEPROM ผิดพลาด"
      },
      {
        "code": "CH10",
        "problem": "พัดลมคอยล์เย็นทำงานผิดปกติ"
      },
      {
        "code": "CH21",
        "problem": "DC ลิงค์ไฟฟ้าสูงเกินไป"
      },
      {
        "code": "CH22",
        "problem": "DC ลิงค์ไฟฟ้าต่ำเกินไป"
      },
      {
        "code": "CH23",
        "problem": "ความดันก๊าซต่ำ"
      },
      {
        "code": "CH26",
        "problem": "คอมเพรสเซอร์เริ่มทำงานผิดปกติ"
      },
      {
        "code": "CH27",
        "problem": "คอมเพรสเซอร์ล็อค/ติดขัด"
      },
      {
        "code": "CH32",
        "problem": "อุณหภูมิท่อ Discharge สูงเกินไป"
      }
    ],
    "การสื่อสารและควบคุม": [
      {
        "code": "CH05",
        "problem": "การสื่อสารระหว่างคอยล์เย็นและคอยล์ร้อนผิดปกติ"
      },
      {
        "code": "CH12",
        "problem": "การสื่อสารกับรีโมทควบคุมผิดปกติ"
      },
      {
        "code": "CH52",
        "problem": "การติดต่อสื่อสารของแผงวงจรมีปัญหา"
      },
      {
        "code": "CH53",
        "problem": "การตั้งค่าความเร็วรอบของคอมเพรสเซอร์ผิดปกติ"
      },
      {
        "code": "CH60",
        "problem": "ข้อมูล EEPROM ผิดพลาด"
      },
      {
        "code": "CH61",
        "problem": "อุณหภูมิ Condenser สูงเกินไป"
      },
      {
        "code": "CH62",
        "problem": "อุณหภูมิ Heat sink สูงเกินไป"
      },
      {
        "code": "CH67",
        "problem": "มอเตอร์พัดลมคอยล์ร้อนผิดปกติ"
      }
    ],
    "การป้องกันและความปลอดภัย": [
      {
        "code": "CH29",
        "problem": "กระแสไฟฟ้าเฟสของคอมเพรสเซอร์เกิน"
      },
      {
        "code": "CH31",
        "problem": "แรงดันไฟฟ้าเกินค่าที่กำหนด"
      },
      {
        "code": "CH40",
        "problem": "แรงดันไฟฟ้าไม่เพียงพอหรือเกิน"
      },
      {
        "code": "CH41",
        "problem": "อุณหภูมิในหรือนอกอาคารไม่อยู่ในช่วงการทำงาน"
      },
      {
        "code": "CH44",
        "problem": "เซนเซอร์อุณหภูมิท่อกลับลมมีปัญหา"
      },
      {
        "code": "CH45",
        "problem": "เซนเซอร์อุณหภูมิท่อจ่ายลมมีปัญหา"
      },
      {
        "code": "CH46",
        "problem": "เซนเซอร์ความดันต่ำมีปัญหา"
      },
      {
        "code": "CH51",
        "problem": "ความจุเครื่องไม่ตรงกัน"
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
        title: const Text('LG Error Codes'),
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
                            if (error['code']!.startsWith('CH0') || error['code']!.startsWith('CH1') || error['code']!.startsWith('CH2')) 
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของเซนเซอร์และสายไฟ\n'
                                '2. ตรวจสอบค่าความต้านทานของเซนเซอร์\n'
                                '3. ตรวจสอบแผงวงจรควบคุม\n'
                                '4. เปลี่ยนเซนเซอร์หรือแผงวงจรที่มีปัญหา',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('CH3') || error['code']!.startsWith('CH4'))
                              Text(
                                '1. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้เครื่อง\n'
                                '2. ตรวจสอบการทำงานของระบบป้องกัน\n'
                                '3. ตรวจสอบความดันของระบบทำความเย็น\n'
                                '4. ตรวจสอบการทำงานของคอมเพรสเซอร์',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('CH5') || error['code']!.startsWith('CH6'))
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อสายสัญญาณระหว่างคอยล์เย็นและคอยล์ร้อน\n'
                                '2. ตรวจสอบแรงดันไฟฟ้าที่จ่ายให้ระบบ\n'
                                '3. ตรวจสอบการทำงานของแผงวงจรควบคุม\n'
                                '4. ตรวจสอบซอฟต์แวร์และการตั้งค่าระบบ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'ปฏิบัติตามคำแนะนำในคู่มือการซ่อมบำรุงของ LG หรือติดต่อช่างผู้เชี่ยวชาญ\n'
                                'สำหรับรหัสข้อผิดพลาดที่ไม่มีข้อมูลโดยละเอียด',
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