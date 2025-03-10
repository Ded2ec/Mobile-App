import 'package:flutter/material.dart';
import '../home_page.dart';

class PanasonicErrorCodePage extends StatefulWidget {
  const PanasonicErrorCodePage({Key? key}) : super(key: key);

  @override
  _PanasonicErrorCodePageState createState() => _PanasonicErrorCodePageState();
}

class _PanasonicErrorCodePageState extends State<PanasonicErrorCodePage> {
  String searchQuery = '';

  final List<Map<String, dynamic>> panasonicErrors = [
     {
    "code": "E0",
    "LED_blink": "ไฟ RUN กระพริบ 1 ครั้งในวินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "ระบบการทำลายน้ำแข็งล้มเหลว หรือเสียหายชำรุด"
  },
  {
    "code": "P3",
    "LED_blink": "ไฟ RUN กระพริบ 1 ครั้งในวินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "อยู่ในสถานะการละลายน้ำแข็ง (ปุ่มกดละลายน้ำแข็งค้าง)"
  },
  {
    "code": "P1",
    "LED_blink": "ไฟ RUN กระพริบ 2 ครั้งใน 4 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "อยู่ในสถานะการต่อคอมเพรสเซอร์โดยตรง"
  },
  {
    "code": "E2",
    "LED_blink": "ไฟ RUN กระพริบ 2 ครั้งใน 4 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "ขดลวดเซ็นเซอร์อีวาพอเรเตอร์เสียหาย"
  },
  {
    "code": "E3",
    "LED_blink": "ไฟ RUN กระพริบ 3 ครั้งใน 5 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "ขดลวดเซ็นเซอร์คอยล์ร้อนเสียหาย"
  },
  {
    "code": "P5",
    "LED_blink": "ไฟ RUN กระพริบ 4 ครั้งใน 6 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "คอมเพรสเซอร์โหลดคู่มอเตอร์"
  },
  {
    "code": "P6",
    "LED_blink": "ไฟ RUN กระพริบ 5 ครั้งใน 7 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "คอมเพรสเซอร์โหลดคู่มอเตอร์ 5 kW."
  },
  {
    "code": "E9",
    "LED_blink": "ไฟ RUN กระพริบ 6 ครั้งใน 8 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "กำลังละลายน้ำแข็งต่อเนื่อง"
  },
  {
    "code": "F4",
    "LED_blink": "ไฟ RUN กระพริบ 7 ครั้งใน 9 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "สภาวะป้องกันความดันต่ำเกินต่ำ (Low-pressure)"
  },
  {
    "code": "F2",
    "LED_blink": "ไฟ RUN กระพริบ 8 ครั้งใน 10 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "ขาดไฟฟ้าภายในห้องเย็น, ลำลุ"
  },
  {
    "code": "EA",
    "LED_blink": "ไฟ RUN กระพริบ 9 ครั้งใน 11 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "เกิดโอเวอร์โหลดในระบบ"
  },
  {
    "code": "F5",
    "LED_blink": "ไฟ RUN กระพริบ 10 ครั้งใน 12 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "ปีกน้ำแข็งบล็อกเซ็นเซอร์"
  },
  {
    "code": "E5",
    "LED_blink": "ไฟ RUN กระพริบ 11 ครั้งใน 13 วินาที",
    "status": "เมื่อหยุดเครื่อง หลอดไฟอลาร์มติด, ไฟรัน (RUN) กระพริบ",
    "problem": "เซ็นเซอร์อุณหภูมิห้องเย็นผิดพลาดผิดปกติหรือหลุดออก"
  },
  {
    "code": "E2",
    "LED_blink": "ไฟ TIMER กระพริบตลอด",
    "status": "ไฟ TIMER กระพริบตลอด",
    "problem": "ขดลวดเซ็นเซอร์อีวาพอเรเตอร์เสียหาย"
  },
  {
    "code": "E3",
    "LED_blink": "ไฟ RUN กระพริบตลอด",
    "status": "ไฟ RUN กระพริบตลอด",
    "problem": "ขดลวดเซ็นเซอร์คอยล์ร้อนเสียหาย"
  },
  {
    "code": "E5",
    "LED_blink": "ไฟ DEFROST กระพริบตลอด",
    "status": "ไฟ DEFROST กระพริบตลอด",
    "problem": "เซ็นเซอร์อุณหภูมิห้องเย็นผิดปกติ"
  },
  {
    "code": "F5",
    "LED_blink": "ไฟ อลาร์มแดง กระพริบตลอด",
    "status": "ไฟ อลาร์มแดง กระพริบตลอด",
    "problem": "ปีกน้ำแข็งบล็อกเซ็นเซอร์"
  },
  {
    "code": "F2",
    "LED_blink": "ไฟ DEFROST กระพริบตลอด",
    "status": "ไฟ DEFROST กระพริบตลอด",
    "problem": "คอมเพรสเซอร์โหลดผิดปกติ"
  },
  {
    "code": "E1",
    "LED_blink": "ไฟ RUN กระพริบตลอด",
    "status": "ไฟ RUN กระพริบตลอด",
    "problem": "เซ็นเซอร์อุณหภูมิผิดปกติ"
  },
  {
    "code": "P6",
    "LED_blink": "ไฟ DEFROST กระพริบ TIMER กระพริบ",
    "status": "ไฟ DEFROST กระพริบ TIMER กระพริบ",
    "problem": "ระบบ EEPROM หล่อมลายผิดปกติ"
  },
  {
    "code": "N0",
    "LED_blink": "ไฟ RUN กระพริบตลอด",
    "status": "ไฟ RUN กระพริบตลอด",
    "problem": "อยู่ในโหมดทดสอบ (ปกติ)"
  },
  {
    "code": "P3",
    "LED_blink": "ไฟ DEFROST ติดตลอด",
    "status": "ไฟ DEFROST ติดตลอด",
    "problem": "กำลังละลายน้ำแข็ง"
  }
  ];

  List<Map<String, dynamic>> get filteredErrors {
    if (searchQuery.isEmpty) {
      return panasonicErrors;
    }
    return panasonicErrors.where((error) =>
      error['code'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
      error['problem'].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PANASONIC Error Codes'),
        backgroundColor: MyHomePage.appBarColor, // Use the static appBarColor
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหารหัสข้อผิดพลาดหรือปัญหา...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredErrors.length,
              itemBuilder: (context, index) {
                final error = filteredErrors[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.lightbulb_outline,
                              size: 16,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${error['LED_blink']}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                       
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'สถานะ: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                   // color: MyHomePage.textColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '${error['status']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: MyHomePage.textColor,
                                  ),
                                ),
                              ],
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