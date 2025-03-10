import 'package:flutter/material.dart';
import '../home_page.dart';

class MitsubishiErrorCodePage extends StatefulWidget {
  const MitsubishiErrorCodePage({Key? key}) : super(key: key);

  static const String PROBLEM_LABEL = 'ปัญหา: ';
  static const String STATUS_LABEL = 'สถานะการทำงาน: ';
  static const String CONTROL_LABEL = 'จุดสังเกต: ';
  static const String SOLUTION_LABEL = 'วิธีแก้ไข: ';
  static const String Errorss = 'Error';

  @override
  State<MitsubishiErrorCodePage> createState() => _MitsubishiErrorCodePageState();
}

class _MitsubishiErrorCodePageState extends State<MitsubishiErrorCodePage> {
  String searchQuery = '';
  String selectedGroup = '';
  
  final Map<String, List<Map<String, dynamic>>> errorGroups = {
      'ปัญหาเกี่ยวกับเซ็นเซอร์': [
      {
        "code": "E1",
        "LED_blink": "ไฟ OPERATION กระพริบ 1 ครั้ง",
        "LED_out": "กะพริบ 1 ครั้ง ทุก 2 วินาที",
        "problem": "เซ็นเซอร์อุณหภูมิห้องเสียหาย",
        "test": "เมื่อหยุดเครื่อง ไฟ OPERATION กระพริบ"
      },
      {
        "code": "E2",
        "LED_blink": "ไฟ OPERATION กระพริบ 2 ครั้ง",
        "LED_out": "กะพริบ 2 ครั้ง ทุก 3 วินาที", 
        "problem": "เซ็นเซอร์แลกเปลี่ยนความร้อนเสียหาย",
        "test": "เมื่อหยุดเครื่อง ไฟ OPERATION กระพริบ"
      },
      {
        "code": "E3",
        "LED_blink": "ไฟ OPERATION กระพริบ 3 ครั้ง",
        "LED_out": "กะพริบ 3 ครั้ง ทุก 3 วินาที",
        "problem": "เซ็นเซอร์ท่อคอนเดนเซอร์เสียหาย",
        "test": "เมื่อหยุดเครื่อง ไฟ OPERATION กระพริบ"
      }
    ],
    'อาการเสียเครื่องตัวในบ้าน': [
      {
        "code": "00",
        "problem": "ไม่มี (ปกติ)"
      },
      {
        "code": "E6 E7",
        "problem": "สัญญาณแบบอนุกรม"
      },
        {
        "code": "Fb",
        "problem": "ระบบควบคุมเครื่องภายในบ้าน"
      },
         {
        "code": "P1",
        "problem": "เทอร์มิสเตอร์อุณหภูมิห้อง"
      },
          {
        "code": "P2 P9",
        "problem": "คออส์เทอร์มิสเตอร์ของเครื่องภายในบ้าน"
      },
        {
        "code": "PB",
        "problem": "มอเตอร์พัดลมของเครื่องภายในบ้าน"
      },
       {
        "code": "E8 E9 EC",
        "problem": "การสื่อสารระหว่างเครื่องภายในบ้านเครื่องภายนอกบ้าน,การรับสัญญาณขัดข้อง"
      },
       {
        "code": "FC",
        "problem": "ข้อมูลหน่วยความจำถาวร"
      },
       {
        "code": "Fd",
        "problem": "แรงตันไฟฟ้าไม่ถูกต้อง"
      },
      {
        "code": "P8",
        "problem": "อุณหภูมิวาล์ว 4 ทางท่อ"
      },
       {
        "code": "PL",
        "problem": "ระบบสารทำความเย็นของเครื่องภายนอกบ้าน"
      },
       {
        "code": "U3",
        "problem": "Discharge เทอร์มิสเตอร์"
      },
        {
        "code": "U4",
        "problem": "เทอร์มิสเตอร์การละลายน้ำแข็ง \n ทอร์มิสเตอร์คุณหภูมิตรีบ \n เทอร์มิสเตอร์อุณหภูมิแผ่นวงจะควบคุมอิเล็กทรอนิกส์ \n เทอร์มิสเตอร์คุณหภูมิแวดล้อม \n เทอร์มิสเตอร์อุณหภูมิเครื่องแลกเปลี่ยนความร้อนของเครื่องภายนอกบ้าน"
        
      },
      {
        "code": "UE",
        "problem": "ราตัวเปิด-ปิด (วาล์วปิด)"
      },
      {
        "code": "UP",
        "problem": "ระบบไฟฟ้าของเครื่องภายนอกบ้าน"
      }
     
    ],
  };

  List<Map<String, dynamic>> get filteredErrors {
    if (selectedGroup.isEmpty && searchQuery.isEmpty) {
      return errorGroups.values.expand((errors) => errors).toList();
    }
    var errors = selectedGroup.isEmpty
        ? errorGroups.values.expand((errors) => errors).toList()
        : errorGroups[selectedGroup] ?? [];
    
    if (searchQuery.isEmpty) return errors;
    
    return errors.where((error) {
      final searchLower = searchQuery.toLowerCase();
      return error['code'].toString().toLowerCase().contains(searchLower) ||
             error['problem'].toString().toLowerCase().contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MITSUBISHI Error Codes'),
        backgroundColor: MyHomePage.appBarColor, // Use the static appBarColor
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'ค้นหารหัสข้อผิดพลาด',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Filter Chips
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
                      )).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Error List
          Expanded(
            child: ListView.builder(
              itemCount: filteredErrors.length,
              itemBuilder: (context, index) {
                final error = filteredErrors[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MitsubishiErrorCodePage.Errorss,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' ${error['code']}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyHomePage.textColor, // Update to use static textColor
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MitsubishiErrorCodePage.STATUS_LABEL,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${error['LED_out']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MitsubishiErrorCodePage.CONTROL_LABEL,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${error['LED_blink']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MitsubishiErrorCodePage.PROBLEM_LABEL,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${error['problem']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: MitsubishiErrorCodePage.SOLUTION_LABEL,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: '${error['test']}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: MyHomePage.textColor, // Update to use static textColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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