import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';

class ErrorCodeScreen extends StatefulWidget {
  final String brand;
  final bool isOutdoorOnly;

  const ErrorCodeScreen({
    required this.brand,
    required this.isOutdoorOnly,
    Key? key,
  }) : super(key: key);

  @override
  State<ErrorCodeScreen> createState() => _ErrorCodeScreenState();
}

class _ErrorCodeScreenState extends State<ErrorCodeScreen> {
  String searchQuery = '';
  Color brandTextColor = Colors.black;

  @override
  void initState() {
    super.initState();
    _loadTextColor();
  }

  Future<void> _loadTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      brandTextColor = Color(prefs.getInt('textColor') ?? Colors.black.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final String baseBrand = widget.brand.split(' (')[0];
    final bool hasOuterText = widget.brand.contains('(ตัวนอก)');

    final Map<String, List<Map<String, dynamic>>> errorCodes = {
      'TCL': [
        {
          'code': 'P0',
          'problem': 'บอร์ด IPM module ทำงานผิดพลาด',
        },
        // Add more codes here
      ],
      // Add more brands here
    };

    final brandCodes = errorCodes[widget.brand] ?? [];
    final filteredCodes = brandCodes.where((error) =>
      error['code']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
      error['problem']!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.brand} Error Code'),
        backgroundColor: MyHomePage.appBarColor,
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
              itemCount: filteredCodes.length,
              itemBuilder: (context, index) {
                final error = filteredCodes[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  color: MyHomePage.cardBackgroundColor,
                  child: ExpansionTile(
                    title: Text.rich(
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.brand == 'HAIER' && error['LED_blink'] != null)
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
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'สถานะ: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        ],
                        if (error['control'] != null) ...[
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'การควบคุม: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        ],
                        if (error['solution'] != null) ...[
                          const SizedBox(height: 8),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'วิธีแก้ไข: ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                      ],
                    ),
                    children: [
                      if (error['solution'] != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'วิธีแก้ไข:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: brandTextColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                error['solution'],
                                style: TextStyle(color: brandTextColor),
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