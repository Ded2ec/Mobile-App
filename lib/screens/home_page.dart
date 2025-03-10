import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../widgets/brand_card.dart';
import 'brand_detail_screen.dart';

// ====== Home Page ======
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  static Color textColor = Colors.black;
  static Color brandTextColor = Colors.black;
  static Color appBarColor = Colors.blue;
  static Color cardBackgroundColor = const Color(0xFFE0E0E0);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late Color appBackgroundColor;
  final searchController = TextEditingController();
  String searchQuery = '';
  List<String> recentBrands = [];

  final Color _defaultCardColor = const Color(0xFFE0E0E0);
  final Color _defaultAppColor = Colors.white;
  final Color _defaultAppBarColor = Colors.blue;

  final List<Color> textColorOptions = [
    Colors.black,      // Default
    Colors.blue,       // Blue
    Colors.red,       // Red
    Colors.green,     // Green
    Colors.purple,    // Purple
    Colors.orange,    // Orange
    Colors.teal,      // Teal
    Colors.indigo,    // Indigo
  ];

  // Add color name mapping
  final Map<Color, String> colorNames = {
    Colors.black: 'สีดำ',
    Colors.blue: 'สีน้ำเงิน',
    Colors.red: 'สีแดง',
    Colors.green: 'สีเขียว',
    Colors.purple: 'สีม่วง',
    Colors.orange: 'สีส้ม',
    Colors.teal: 'สีเขียวมิ้นท์',
    Colors.indigo: 'สีน้ำเงินเข้ม',
  };

  List<Map<String, dynamic>> brands = [
    {'name': 'PANASONIC', 'image': 'assets/images/list-panasonic.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
    {'name': 'LG', 'image': 'assets/images/list-lg.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
    {'name': 'CARRIER', 'image': 'assets/images/list-carrier.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
    {'name': 'DAIKIN', 'image': 'assets/images/list-daikin.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
    {'name': 'HAIER', 'image': 'assets/images/list-haier.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': true},
    {'name': 'MITSUBISHI', 'image': 'assets/images/list-mitsubishi.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
    {'name': 'TCL', 'image': 'assets/images/list-tcl.svg', 'subtitle': 'Air Conditioner', 'isOutdoorOnly': false},
  ];

  List<Map<String, dynamic>> getFilteredBrands() {
    if (searchQuery.isEmpty) {
      return brands;
    }
    return brands.where((brand) =>
      brand['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
      brand['subtitle']!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadColors();
    _loadRecentBrands();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadRecentBrands();
    }
  }

  Future<bool> didPopRoute() async {
    _loadRecentBrands();
    return false;
  }

  Future<void> _loadColors() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      appBackgroundColor = Color(prefs.getInt('backgroundColor') ?? Colors.white.value);
      MyHomePage.cardBackgroundColor = Color(prefs.getInt('cardColor') ?? _defaultCardColor.value);
      MyHomePage.appBarColor = Color(prefs.getInt('appBarColor') ?? _defaultAppBarColor.value);
      MyHomePage.textColor = Color(prefs.getInt('textColor') ?? Colors.black.value);
      MyHomePage.brandTextColor = MyHomePage.textColor;
    });
  }

  Future<void> saveColors() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cardColor', MyHomePage.cardBackgroundColor.value);
    await prefs.setInt('appColor', appBackgroundColor.value);
    await prefs.setInt('appBarColor', MyHomePage.appBarColor.value);
    await prefs.setInt('textColor', MyHomePage.textColor.value);
  }

  void resetColors() {
    setState(() {
      MyHomePage.cardBackgroundColor = _defaultCardColor;
      appBackgroundColor = _defaultAppColor;
      MyHomePage.appBarColor = _defaultAppBarColor;
      MyHomePage.textColor = Colors.black;
      MyHomePage.brandTextColor = Colors.black;
    });
    saveColors();
  }

  Future<void> _loadRecentBrands() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      recentBrands = prefs.getStringList('recentBrands') ?? [];
    });
  }

  Future<void> _saveRecentBrand(String brandName) async {
    if (!recentBrands.contains(brandName)) {
      recentBrands.insert(0, brandName);
      if (recentBrands.length > 5) {
        recentBrands = recentBrands.sublist(0, 5);
      }
    } else {
      // Move to top if already exists
      recentBrands.remove(brandName);
      recentBrands.insert(0, brandName);
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('recentBrands', recentBrands);
  }

  void _showColorPickerDialog(String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(type == 'card' ? 'เลือกสีพื้นหลัง Card' : 
                    type == 'appbar' ? 'เลือกสี AppBar' : 'เลือกสีตัวหนังสือ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: type == 'text' ? [
              // Text color options with names
              ...textColorOptions.map((color) => ListTile(
                title: Text(
                  colorNames[color] ?? 'สี',
                  style: TextStyle(color: color),
                ),
                tileColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    MyHomePage.textColor = color;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              )).toList(),
            ] : type == 'card' ? [
              // สีอ่อนสำหรับ Card
              ListTile(
                title: const Text('Soft Blue'),
                tileColor: const Color(0xFFE3F2FD),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFE3F2FD);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Pink'),
                tileColor: const Color(0xFFFCE4EC),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFFCE4EC);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Green'),
                tileColor: const Color(0xFFE8F5E9),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFE8F5E9);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Purple'),
                tileColor: const Color(0xFFF3E5F5),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFF3E5F5);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Yellow'),
                tileColor: const Color(0xFFFFFDE7),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFFFFDE7);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Orange'),
                tileColor: const Color(0xFFFFF3E0),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFFFF3E0);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Soft Cyan'),
                tileColor: const Color(0xFFE0F7FA),
                onTap: () {
                  setState(() {
                    MyHomePage.cardBackgroundColor = const Color(0xFFE0F7FA);
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
            ] : [
              // สีเข้มสำหรับ AppBar
              ListTile(
                title: const Text('Blue'),
                tileColor: Colors.blue,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.blue;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Red'),
                tileColor: Colors.red,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.red;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Green'),
                tileColor: Colors.green,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.green;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Purple'),
                tileColor: Colors.purple,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.purple;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Orange'),
                tileColor: Colors.orange,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.orange;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Teal'),
                tileColor: Colors.teal,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.teal;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Indigo'),
                tileColor: Colors.indigo,
                onTap: () {
                  setState(() {
                    MyHomePage.appBarColor = Colors.indigo;
                  });
                  saveColors();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ตั้งค่าธีม',
                style: TextStyle(fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  resetColors();
                  Navigator.pop(context);
                },
                tooltip: 'รีเซ็ตสีทั้งหมด',
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSettingsTile(
                'เปลี่ยนสีแถบด้านบน',
                Icons.palette,
                () {
                  Navigator.pop(context);
                  _showColorPickerDialog('appbar');
                },
              ),
              _buildSettingsTile(
                'เปลี่ยนสีพื้นหลังเมนู',
                Icons.format_paint,
                () {
                  Navigator.pop(context);
                  _showColorPickerDialog('card');
                },
              ),
              _buildSettingsTile(
                'เปลี่ยนสีตัวหนังสือ',
                Icons.text_fields,
                () {
                  Navigator.pop(context);
                  _showColorPickerDialog('text');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSettingsTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (appBackgroundColor == null) {
      return const Center(child: CircularProgressIndicator());
    }

    _loadRecentBrands();

    final filteredBrands = getFilteredBrands();

    return GestureDetector(
      onTap: () {
        searchController.clear();
        setState(() {
          searchQuery = '';
        });
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: appBackgroundColor,
        appBar: AppBar(
          backgroundColor: MyHomePage.appBarColor,
          elevation: 0,
          toolbarHeight: 140,
          title: Column(
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'ค้นหาแบรนด์...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.search, color: Colors.blue),
                    suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            searchController.clear();
                            setState(() {
                              searchQuery = '';
                            });
                          },
                        )
                      : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                    size: 26,
                  ),
                  onPressed: () => _showSettingsDialog(context),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Text(
                    'แบรนด์ยอดนิยม',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredBrands.length,
                    itemBuilder: (context, index) {
                      final brand = filteredBrands[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: BrandCard(
                          brand: brand['name']!,
                          subtitle: brand['subtitle']!,
                          image: brand['image']!,
                          isSvg: true,
                          backgroundColor: MyHomePage.cardBackgroundColor,
                          isOutdoorOnly: brand['isOutdoorOnly']!,
                        ),
                      );
                    },
                  ),
                ),
                if (recentBrands.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    child: Text(
                      'เข้าชมล่าสุด',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyHomePage.textColor,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: recentBrands.length,
                    itemBuilder: (context, index) {
                      final brandName = recentBrands[index];
                      final brand = brands.firstWhere(
                        (b) => b['name'] == brandName,
                        orElse: () => brands[0],
                      );
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Card(
                          elevation: 1,
                          color: MyHomePage.cardBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            leading: Container(
                              width: 36,
                              height: 36,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: SvgPicture.asset(
                                brand['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Text(
                              brand['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: MyHomePage.textColor,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              brand['subtitle']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: MyHomePage.textColor.withOpacity(0.7),
                              ),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              size: 16,
                              color: MyHomePage.textColor.withOpacity(0.7),
                            ),
                            onTap: () async {
                              await _saveRecentBrand(brand['name']!);
                              if (context.mounted) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BrandDetailScreen(
                                      brand: brand['name']!,
                                      image: brand['image']!,
                                      isSvg: true,
                                      isOutdoorOnly: brand['isOutdoorOnly']!,
                                    ),
                                  ),
                                );
                                
                                if (result == true) {
                                  _loadRecentBrands();
                                }
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
} 