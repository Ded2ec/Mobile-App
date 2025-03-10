import 'package:flutter/material.dart';
import '../home_page.dart';

class CarrierErrorCodePage extends StatefulWidget {
  const CarrierErrorCodePage({Key? key}) : super(key: key);

  @override
  _CarrierErrorCodePageState createState() => _CarrierErrorCodePageState();
}

class _CarrierErrorCodePageState extends State<CarrierErrorCodePage> {
  String searchQuery = '';
  String selectedMainCode = '';
  String selectedGroup = '';

  // Add these constants at the top of the class
  static const String PROBLEM_LABEL = 'ปัญหา: ';
  static const String STATUS_LABEL = 'สถานะการทำงาน: ';
  static const String CONTROL_LABEL = 'จุดสังเกต: ';
  static const String SOLUTION_LABEL = 'วิธีแก้ไข: ';

  final Map<String, List<Map<String, String>>> errorData = {
    '00': [
      {
        'group': 'PC บอร์ด/ภายใน',
        'code': '0C',
        'problem': 'เซ็นเซอร์อุณหภูมิห้อง(TA)ขาดหรือขอร์ท',
        'status': 'ทำงานต่อเนื่อง',
        'control': 'แสดงว่าพบข้อบกพร่อง',
        'solution': '1. วัดเซ็นเซอร์อุณหภูมิห้อง\n \t\t             2. ถ้าเซ็นเซอร์ปกติตรวจ PC. บอร์ค',
      },
        {
        'group': 'PC บอร์ด/ภายใน',
        'code': '0D',
        'problem': 'สายสัญญาณไฟฟ้า (PowerTA) หลวมหรือหลุด',
        'status': 'หยุดทำงาน',
        'control': 'แสงดมลเมื่อพบข้อบกพร่อง',
        'solution': '1. ตรวจสอบสายไฟฟ้า\n \t\t             2. รีเซ็ทเครื่องหรือรีบูต PC นอก',
      },
        {
        'group': 'PC บอร์ด/ภายใน',
        'code': '11',
        'problem': 'ปัญหาจาก PC. บอร์ด อื่นๆ',
        'status': 'ดับหมด',
        'control': 'แสดงว่าเมื่อพบข้อบกพร่อง',
        'solution': 'เปลี่ยน PC. บอร์ด',
      },
        {
        'group': 'ไม่แสดง',
        'code': '12',
        'problem': 'ปัญหาจาก PC. บอร์ด อื่นๆ',
        'status': 'ทำงานต่อเนื่อง',
        'control': 'แสดงผลเมื่อพบข้อบกพร่อง 01',
        'solution': 'เปลี่ยน PC บอร์ด',
      }
      // เพิ่มข้อมูลอื่นๆs
    ],
    '01': [
      {
        'group': 'สายเชื่อมต่อสัญญาณอนุกรม',
        'code': '04',
        'problem': 'ไม่มีสัญญาณตอบกลับไปยังภายในเมื่อเริ่มทำงาน\n \t\t (1) สารเชื่อมต่อเสียง \n \t\t (2)สารทำความเย็นรั่วขาด เทอร์โมฯคอมเพรสเซอร์ทำงาน',
        'status': 'ทำงานต่อเนื่อง',
        'control': 'กระพริบเมื่อไม่มีสัญญาณตอบกลับปกติเมื่อสัญญาณรีเซ็ท',
        'solution': '1. เมื่อภายนอกไม่ทำงาน \n \t\t(1) วัดสายเชื่อมต่อและแก้ไข\n \t\t(2) วัดฟิวส์ 25A ชุดอินเวอร์เตอร์\n \t\t(3) ตรวจฟิวส์ 3.15A บนบอร์ดอินเวอร์เตอร์\n 2. ถ้ามีรหัสอีน ให้ดูเทอร์โมลดัทคอมเพรสเซอร์ตัด และปริมาณสารทำความเย็นรั่ว หรือขาด\n3. เครื่องทำงานปกติขณะทดสอบ ถ้ามีสัญญาณอนุกรมระหว่างขา 2 กับ 3 จุดต่อภายในเปลี่ยนบอร์ดอินเวอร์เตอร์ ถ้าไม่มีสัญญาณขา 2 กับ 3 เปลี่ยนบอร์ดชุดภายใน',
      },
       {
        'group': 'สายเชื่อมต่อสัญญาณอนุกรม',
        'code': '05',
        'problem': 'ไม่มีคำสั่งสัญญาณไปยังภายนอก',
        'status': 'ทำงานต่อเนื่อง',
        'control': 'กระพริบเมื่อไม่มีสัญญาณตอบกลับปกติเมื่อสัญญาณรีเซ็ท',
        'solution': 'เครื่องทำงานปกติขณะทดสอบถ้ามีสัญญาณอนุกรมระหว่าง ขา 2 กับ 3 จุดต่อภายในเปลี่ยนบอร์ดอินเวอร์เตอร์ ถ้าไม่มีสัญญาณขา 2 กับ 3 เปลี่ยนบอร์ดชุดภายใน',
      },
    ],
      '02': [
       {
    "group": "PC บอร์ดภายใน",
    "code": "14",
    "problem": "วงจรป้องกันกระแสเย็น-เวอร์เตอร์เกินทำงาน(ทำงานช่วงสั้นๆ)",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "เมื่อเปิดอีกครั้งการทำงานทั้งหมดหยุดทันทีเปลี่ยน PC. บอร์ด"
  },
  {
    "group": "PC บอร์ดภายใน",
    "code": "16",
    "problem": "วงจรตรวจสอบคำแหน่งมอเตอร์ซอร์ท",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. ถอดสายต่อคอมเพรสเซอร์ออกวงจรอ่านต่ำแหน่งไม่ทำงานเปลี่ยน PC. บอร์ด \n                2. วัดความด้านทานชดลวดคอม-เพรสเซอร์พบว่าซอร์ทเปลี่ยนคอมเพรสเซอร์"
  },
  {
    "group": "PC บอร์ดภายใน",
    "code": "17",
    "problem": "วงจรวัดกระแสทำงานผิดพลาด",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "เมื่อเปิดอีกครั้งการทำงานทั้งหมดหยุดทันทีเปลี่ยน PC. บอร์ด"
  },
  {
    "group": "PC บอร์ดภายใน",
    "code": "18",
    "problem": "สายเซ็นเชอร์อุณหภูมิอากาศ ภายนอกขาด หมุด หรือ ซอร์ท",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. วัดเซ็นเซอร์อุณหภูมิภายนอก(TE.) \n                2. ตรวจสอบ PC. บอร์ด"
  },
  {
    "group": "PC บอร์ดภายใน",
    "code": "19",
    "problem": "สายเข็นเชอร์อุณหภูมิติจชาร์จ หลุดหรือซอร์ท",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. ตรวจสอบเซ็นเซอร์อุณหภูมิติจชาร์จ(TD) \n                2. ตรวจสอบ PC. บอร์ด"
  },
  {
    "group": "PC บอร์ดภายใน",
    "code": "1A",
    "problem": "ระบบขับพัดลมภายนอกทำงาน ผิดพลาด",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "ตัวอ่านตำแหน่งทำงานผิดพลาดวงจรกระแสเกินทำงานจากมอเตอร์ติดชัดเป็นต้นเปลี่ยนPC. บอร์ดหรือมอเตอร์พัดลม"
  }
  ,
  {
    "group": "ไม่แสดงผล",
    "code": "1b",
    "problem": "เซ็นเซอร์วัดอุณภูมิภายนอกเสีย)",
    "status": "ทำงานต่อเนื่อง",
    "control": "-",
    "solution": "1. วัดเซ็นเซอร์ภายนอก(TE) \n 2. ตรวจสอบ PC. บอร์ด"
  },
  {
    "group": "PC บอร์ดภายนอก",
    "code": "1C",
    "problem": "วงจรขับคอมเพรสเซอร์เมียคอมเพรสเซอร์เสีย(ติดขัด เป็นต้น)",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "เมื่อทำงานได้ประมาณ 20 วินาทีวงจรอ่านตำแหน่งพบว่าบกพร่องต้องเปลี่ยนคอมเพรสเซอร์"
  }
    ],
    '03': [
      {
        "group": "ปัญหาอื่นรวมคอมเพรสเซอร์",
    "code": "07",
    "problem": "สัญญาณอนุกรมทำงานเริมต้นหลังจากนั้นหยุดส่ง\n   (1) เทอร์โมสคัทคอมเพรสเซอร์ตัดหรือสารทำความเย็นขาด, รั่ว\n   (2) ไฟฟ้ากระพริบ",
    "status": "ทำงานต่อเนื่อ",
    "control": "กระพริบเมื่อไม่มีสัญญาณตอบกลับปกติเมื่อสัญญาณรีเซ็ท",
    "solution": "1. ตัดต่อด้วยช่วงเวลาประมาณ 10-40นาที (ไม่มีรหัสบกพร่องเกิดขึ้น)ตรวจสอบสารทำความเย็นรั่วขาด\n                2. เครื่องทำงานปกติขณะทดสอบถ้ามีสัญญาณอนุกรมระหว่าง ขา 2 กับ 3 จุดต่อคอยล์เย็นเปลี่ยนบอร์คอินเวอร์เดอร์ ถ้าไม่มีสัญญาณขา 2 กับ 3 เปลี่ยนบอร์ดชุคคอยล์เย็น"
      },
         {
        "group": "ปัญหาอื่นรวมคอมเพรสเซอร์",
    "code": "1d",
    "problem": "คอมเพรสเซอร์ไม่หมุน(วงจะป้องกันไม่ทำงานเมื่อคอมทำงาน)",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. คอมเพรสเซอร์เสีย\n                2. ใส่สายคอมเพรสเซอร์ผิด(เฟสผิด)"
      },
      {
              "group": "ปัญหาอื่นรวมคอมเพรสเซอร์",
    "code": "1E",
    "problem": "คุณหภูมิคิงชาร์จเกิน 117°C",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. ตรวจเซ็นเซอร์ติจชาร์จ (TD) \n                2. เอาอากาศออก\n                3. PMV เสีย"
      },
       {
              "group": "ปัญหาอื่นรวมคอมเพรสเซอร์",
    "code": "1F",
    "problem": "คอมเพรสเซอร์เลีย",
    "status": "ดับหมด",
    "control": "แสดงผลเมื่อพบข้อบกพร่อง",
    "solution": "1. วัดแรงดันไฟฟ้า（220V士 10%6） \n                2. ระบบทำความเย็นโหลดเกิน ดูการติดตั้งและการระบายลมคอยล์ร้อนไม่ย้อนกลับ"
      },
      {
         "group": "ปัญหาอื่นรวมคอมเพรสเซอร์",
    "code": "08",
    "problem": "วาล์ว 4 ทางทำงานย้อนกลับ(เซ็นเซอร์ TC มีค่าต่ำในช่วงทำความร้อน)",
    "status": "ทำงานต่อเนื่อง",
    "control": "-",
    "solution": "1. ตรวจสอบการทำงานวาล์ว 4 ทาง"
      },
    ]
  };

  List<Map<String, String>> _getFilteredData() {
    // If no main code is selected, combine all data from all main codes
    if (selectedMainCode.isEmpty) {
      List<Map<String, String>> allData = [];
      errorData.values.forEach((codeList) {
        allData.addAll(codeList);
      });
      
      // Apply search filter if exists
      if (searchQuery.isNotEmpty) {
        return allData.where((error) =>
          error['code']!.toLowerCase().contains(searchQuery) ||
          error['problem']!.toLowerCase().contains(searchQuery) ||
          error['solution']!.toLowerCase().contains(searchQuery)
    ).toList();
      }
      
      return allData;
    }
    
    // If main code is selected, filter by main code
    var filteredList = errorData[selectedMainCode]!;
    
    // Apply group filter if selected
    if (selectedGroup.isNotEmpty) {
      filteredList = filteredList.where((error) => 
        error['group'] == selectedGroup
      ).toList();
    }
    
    // Apply search filter if exists
    if (searchQuery.isNotEmpty) {
      filteredList = filteredList.where((error) =>
        error['code']!.toLowerCase().contains(searchQuery) ||
        error['problem']!.toLowerCase().contains(searchQuery) ||
        error['solution']!.toLowerCase().contains(searchQuery)
      ).toList();
    }
    
    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARRIER Error Codes'),
        backgroundColor: MyHomePage.appBarColor, // Use the static appBarColor
      ),
      body: Column(
        children: [
          // Search Bar
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
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          // Main Code Selection
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('รหัสหลัก:', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ...errorData.keys.map((code) => 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: FilterChip(
                      label: Text(code),
                      selected: selectedMainCode == code,
                      onSelected: (selected) {
                        setState(() {
                          selectedMainCode = selected ? code : '';
                          selectedGroup = '';
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (selectedMainCode.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('กลุ่ม:', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ...errorData[selectedMainCode]!
                      .map((e) => e['group']!)
                      .toSet()
                      .map((group) => 
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChip(
                            label: Text(group),
                            selected: selectedGroup == group,
                            onSelected: (selected) {
                              setState(() {
                                selectedGroup = selected ? group : '';
                              });
                            },
                          ),
                        ),
                      ),
                ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredData().length,
              itemBuilder: (context, index) {
                final error = _getFilteredData()[index];
                // Find the main code for this error
                String mainCode = '';
                errorData.forEach((key, value) {
                  if (value.any((e) => e['code'] == error['code'])) {
                    mainCode = key;
                  }
                });

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
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
                              child: Text(
                                'รหัสหลัก: $mainCode',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue[700],
                                  fontWeight: FontWeight.w500,
                                ),
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
                            'กลุ่ม: ${error['group']}',
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
                                    text: STATUS_LABEL,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: error['status'],
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
                                    text: CONTROL_LABEL,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
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