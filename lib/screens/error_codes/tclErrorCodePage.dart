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
     // รายการอาการเสียอื่นๆ ตามที่มีอยู่ในโค้ดเดิม
   ],
   "ไม่ใช่อาการเสีย": [
     {
       "code": "2A 3A 4A 5A 6A ",
       "problem": "ถ้าปิดโหมดอยู่ ไฟกดบนเครื่องออกโดยการกดปุ่ม GEN หรือโหม กดปุ่มจนกว่าหน้าจอโทรโชว์ OF แล้วปล่อยมือ ประมาณ 5 วินาทีพัดผ้าก็จะหยุดไป หลังจากนั้นคอมเพรสเซอร์จะกลับมาทำงาน 100% หรือ เป็นเดิมที"
     },
     // รายการอื่นๆ ตามที่มีอยู่ในโค้ดเดิม
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
        backgroundColor: _MyHomePageState.appBarColor, // Use the static appBarColor
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
                  color: _MyHomePageState.cardBackgroundColor,
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
                                    color: _MyHomePageState.textColor,
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
                          TextSpan(
                            text: 'ปัญหา: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: _MyHomePageState.textColor,
                            ),
                          ),
                          TextSpan(
                            text: error['problem'],
                            style: TextStyle(
                              fontSize: 14,
                              color: _MyHomePageState.textColor,
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