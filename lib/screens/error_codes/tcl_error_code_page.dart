import 'package:flutter/material.dart';
import '../home_page.dart';

class TclErrorCodePage extends StatefulWidget {
  const TclErrorCodePage({Key? key}) : super(key: key);

  @override
  _TclErrorCodePageState createState() => _TclErrorCodePageState();
}

class _TclErrorCodePageState extends State<TclErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';

  // กำหนดกลุ่มข้อมูล TCL
  final Map<String, List<Map<String, String>>> errorGroups = {
    "อาการเสีย": [
     {
       "code": "P0",
       "problem": "บอร์ด IPM module ทำงานผิดพลาด"
     },
     {
       "code": "P1",
       "problem": "แรงดันไฟฟ้าต่ำหรือสูงเกินไป"
     },
     {
       "code": "P2",
       "problem": "กระแสไฟฟ้าสูงเกินไป"
     },
     {
       "code": "P4",
       "problem": "เซนเซอร์ตรวจวัดอุณหภูมิท่อ Discharge outdoor มีอุณหภูมิสูงเกินไป"
     },
     {
       "code": "P6",
       "problem": "ระบบปรับอากาศล็อคการทำงานจากการป้องกัน"
     },
     {
       "code": "P8",
       "problem": "ระบบ Outdoor IGBT ตรวจพบอุณหภูมิสูงเกินไป"
     },
     {
       "code": "P9",
       "problem": "ปัญหาจากชุดคอมเพรสเซอร์แบบ DC"
     },
     {
       "code": "PA",
       "problem": "แรงดันไฟฟ้ากระแสสลับของเครื่องไม่อยู่ในช่วงปกติ"
     },
     {
       "code": "PC",
       "problem": "ปัญหาจากชุดควบคุมกระแสไฟฟ้า"
     },
     {
       "code": "E1",
       "problem": "การสื่อสารระหว่างคอยล์ร้อนและคอยล์เย็นผิดพลาด"
     },
     {
       "code": "E3",
       "problem": "ความเร็วรอบพัดลมคอยล์เย็นผิดปกติ"
     },
     {
       "code": "E4",
       "problem": "เซนเซอร์อุณหภูมิห้องเสีย หรือวงจรเซนเซอร์ลัดวงจร"
     },
     {
       "code": "E5",
       "problem": "เซนเซอร์อุณหภูมิคอยล์เย็นเสีย หรือวงจรเซนเซอร์ลัดวงจร"
     },
     {
       "code": "E6",
       "problem": "เซนเซอร์ตรวจจับอุณหภูมิท่อ Condenser outdoor เสีย"
     },
     {
       "code": "E7",
       "problem": "เซนเซอร์ตรวจจับอุณหภูมิอากาศภายนอกเสีย"
     },
     {
       "code": "E8",
       "problem": "เซนเซอร์ตรวจจับอุณหภูมิท่อ Discharge outdoor เสีย"
     },
     {
       "code": "E9",
       "problem": "วงจรตรวจจับกระแสไฟฟ้าผิดพลาด"
     },
     {
       "code": "EA",
       "problem": "EEPROM เสียหาย"
     },
     {
       "code": "EE",
       "problem": "เซนเซอร์ระดับน้ำล้นทำงานผิดปกติ"
     },
     {
       "code": "ED",
       "problem": "ระบบสื่อสารของชุดควบคุมภายนอกผิดพลาด"
     },
     {
       "code": "F0",
       "problem": "ไมโครคอนโทรลเลอร์ (MCU) ของ Outdoor เสียหาย"
     },
     {
       "code": "F1",
       "problem": "ปัญหาจากระบบไฟฟ้ากระแสตรง DC บัสลัดวงจร"
     },
     {
       "code": "F2",
       "problem": "ปัญหาจากแผงวงจรตรวจจับกระแสไฟฟ้า PFC"
     },
     {
       "code": "F3",
       "problem": "คอมเพรสเซอร์ติดค้างไม่สามารถทำงานได้"
     },
     {
       "code": "F4",
       "problem": "ข้อผิดพลาดในระบบ 4-way valve"
     },
     {
       "code": "F5",
       "problem": "ความผิดพลาดในการวนโปรแกรมระบบควบคุม"
     },
     {
       "code": "F6",
       "problem": "การสื่อสารระหว่างปุ่มกดและเมนบอร์ดผิดพลาด"
     },
     {
       "code": "F7",
       "problem": "เซนเซอร์อุณหภูมิภายในของ IGBT เสีย"
     },
     {
       "code": "F8",
       "problem": "เซนเซอร์อุณหภูมิออกอากาศคอยล์เย็นเสีย"
     },
     {
       "code": "F9",
       "problem": "ระบบป้องกันการเปิดพร้อมกันทั้งโหมด Cool และ Heat"
     }
   ],
   "ไม่ใช่อาการเสีย": [
     {
       "code": "2A 3A 4A 5A 6A",
       "problem": "ถ้าปิดโหมดอยู่ ไฟกดบนเครื่องออกโดยการกดปุ่ม GEN หรือโหม กดปุ่มจนกว่าหน้าจอโทรโชว์ OF แล้วปล่อยมือ ประมาณ 5 วินาทีพัดลมก็จะหยุดไป หลังจากนั้นคอมเพรสเซอร์จะกลับมาทำงาน 100% หรือ เป็นเดิมที"
     },
     {
       "code": "H1",
       "problem": "แอร์ทำงานในโหมดละลายน้ำแข็ง (Defrost) ไม่ใช่อาการเสีย"
     },
     {
       "code": "H3",
       "problem": "ระบบป้องกันการทำงานหนักเกินของคอมเพรสเซอร์"
     },
     {
       "code": "H4",
       "problem": "ระบบป้องกันจากสวิตช์แรงดันต่ำ"
     },
     {
       "code": "H5",
       "problem": "ระบบป้องกันการทำงานหนักเกินของ Indoor coil"
     },
     {
       "code": "H6",
       "problem": "ระบบป้องกันมอเตอร์พัดลมในร่ม"
     },
     {
       "code": "H7",
       "problem": "การไม่ตรงกันของโหมดการทำงาน (กรณีระบบ Multi Split)"
     },
     {
       "code": "FF",
       "problem": "โหมดทดสอบการทำงาน"
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
        title: const Text('TCL Error Codes'),
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
                              'วิธีแก้ไข:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: MyHomePage.textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (error['code']!.startsWith('P')) 
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของสายไฟและส่วนประกอบที่เกี่ยวข้อง\n'
                                '2. ตรวจสอบแรงดันไฟฟ้าเข้าเครื่อง\n'
                                '3. ตรวจสอบการทำงานของเซนเซอร์\n'
                                '4. อาจต้องเปลี่ยนแผงวงจรหลักหรือเซนเซอร์ที่เสียหาย',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('E'))
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของสายสัญญาณระหว่างคอยล์ร้อนและคอยล์เย็น\n'
                                '2. ตรวจสอบการทำงานของเซนเซอร์\n'
                                '3. ตรวจสอบแผงวงจรควบคุมหลัก\n'
                                '4. ระบบอาจต้องการการ Reset โดยการปิดเครื่องและถอดปลั๊กทิ้งไว้ 10 นาที',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('F'))
                              Text(
                                '1. ตรวจสอบการเชื่อมต่อของสายไฟและอุปกรณ์ต่างๆ\n'
                                '2. ตรวจสอบการทำงานของคอมเพรสเซอร์\n'
                                '3. ตรวจสอบการทำงานของวาล์ว 4 ทาง\n'
                                '4. ตรวจสอบและเปลี่ยนแผงวงจรหลักถ้าจำเป็น',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else if (error['code']!.startsWith('H'))
                              Text(
                                'รหัสนี้ส่วนใหญ่เป็นการแจ้งเตือนหรือการทำงานในโหมดพิเศษ ไม่ใช่อาการเสีย\n'
                                '1. รอให้ระบบทำงานในโหมดปกติโดยอัตโนมัติ\n'
                                '2. ตรวจสอบเงื่อนไขการทำงานของเครื่อง\n'
                                '3. หากแสดงบ่อยครั้ง อาจต้องตรวจสอบระบบลมหรือตรวจเช็คการติดตั้ง',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              )
                            else 
                              Text(
                                'ปฏิบัติตามคำแนะนำที่ระบุในปัญหา หรือติดต่อช่างผู้เชี่ยวชาญ',
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