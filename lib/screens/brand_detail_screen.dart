import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';
import 'error_codes/carrier_error_code_page.dart';
import 'error_codes/daikin_error_code_page.dart';
import 'error_codes/tcl_error_code_page.dart';
import 'error_codes/haier_error_code_page.dart';
import 'error_codes/lg_error_code_page.dart';
import 'error_codes/panasonic_error_code_page.dart';
import 'error_codes/mitsubishi_error_code_page.dart';

// ====== Brand Detail Page ======
class BrandDetailScreen extends StatelessWidget {
  static final Map<String, String> brandDescriptions = {
    'PANASONIC': 'แบรนด์ญี่ปุ่นที่มีประวัติยาวนานในการผลิตเครื่องใช้ไฟฟ้า โดดเด่นด้านเทคโนโลยี Inverter ที่ให้พลังงานคงที่ในระดับกลางและต่ำ มีระบบฟอกอากาศและควบคุมความชื้นอัตโนมัติ การออกแบบที่ทันสมัยและประหยัดพลังงาน',
    'LG': 'แบรนด์เกาหลีที่โดดเด่นด้านดีไซน์และเทคโนโลยี AI มีระบบ Dual Inverter Compressor ประหยัดพลังงานและลดเสียงรบกวน ฟังก์ชัน ThinQ ควบคุมแอร์ผ่านสมาร์ทโฟน มีระบบฟอกอากาศและฆ่าเชื้อแบคทีเรีย',
    'CARRIER': 'แบรนด์อเมริกันที่เป็นผู้นำด้านระบบปรับอากาศ มีเทคโนโลยี Smart Auto Mode ปรับความเร็วพัดลมอัตโนมัติตามคุณภาพอากาศ ระบบกรองอากาศประสิทธิภาพสูง และการควบคุมอุณหภูมิที่แม่นยำ',
    'DAIKIN': 'แบรนด์ญี่ปุ่นที่มีชื่อเสียงด้านเทคโนโลยีระบบปรับอากาศระดับโลก มีระบบ Streamer Discharge ที่ช่วยฟอกอากาศและฆ่าเชื้อโรค เทคโนโลยี Inverter ประหยัดพลังงานสูง คอมเพรสเซอร์ทนทาน และระบบควบคุมอุณหภูมิแม่นยำ',
    'HAIER': 'แบรนด์จีนที่มีความเชี่ยวชาญด้านอุปกรณ์เครื่องใช้ไฟฟ้า เทคโนโลยี Self-Cleaning ป้องกันเชื้อราและแบคทีเรีย ระบบ Hyper PCB ทำให้ทำงานได้เสถียรแม้ไฟตก คอมเพรสเซอร์ทนทานและประหยัดพลังงาน',
    'MITSUBISHI': 'แบรนด์ญี่ปุ่นที่ขึ้นชื่อเรื่องความทนทานและประหยัดพลังงาน ระบบ Fast Cooling ทำให้เย็นเร็วทันใจ เทคโนโลยี Dual Barrier Coating ลดการสะสมของฝุ่นและคราบน้ำมัน ใช้น้ำยาทำความเย็น R32 ที่เป็นมิตรต่อสิ่งแวดล้อม',
    'TCL': 'แบรนด์จีนที่ให้ความคุ้มค่าราคาประหยัด ระบบ Gentle Breeze กระจายลมได้อย่างนุ่มนวล คอมเพรสเซอร์ Inverter ช่วยประหยัดไฟ ดีไซน์ทันสมัย รองรับการควบคุมผ่านแอป',
  };

  final String brand;
  final String image;
  final bool isSvg;
  final bool isOutdoorOnly;

  const BrandDetailScreen({
    required this.brand,
    required this.image,
    required this.isSvg,
    required this.isOutdoorOnly,
    Key? key,
  }) : super(key: key);

  // เพิ่มฟังก์ชัน saveRecentBrand เพื่อบันทึกประวัติ
  Future<void> _saveRecentBrand(String brandName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> recentBrands = prefs.getStringList('recentBrands') ?? [];
    
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
    
    await prefs.setStringList('recentBrands', recentBrands);
  }

  @override
  Widget build(BuildContext context) {
    // บันทึกประวัติตอนเข้าสู่หน้านี้
    _saveRecentBrand(brand);
    
    return WillPopScope(
      onWillPop: () async {
        // อัปเดต state เมื่อกดกลับ
        Navigator.pop(context, true); // ส่งค่า true กลับไปหน้าหลัก
        return false; // จัดการ pop เอง
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(brand),
          backgroundColor: MyHomePage.appBarColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // อัปเดต state เมื่อกดปุ่มกลับ
              Navigator.pop(context, true); // ส่งค่า true กลับไปหน้าหลัก
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: 'brand-$brand',
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: isSvg
                    ? SvgPicture.asset(
                        image,
                        fit: BoxFit.contain,
                      )
                    : Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'ข้อมูลเครื่องปรับอากาศ ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: brand,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: MyHomePage.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      brandDescriptions[brand] ?? 'Brand description not available.',
                      style: TextStyle(
                        fontSize: 16,
                        color: MyHomePage.textColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // แก้ไขส่วนนี้เพื่อนำทางไปยังหน้า Error Code ที่เหมาะสม
                          Widget errorPage;
                          if (brand == 'CARRIER') {
                            errorPage = const CarrierErrorCodePage();
                          } else if (brand == 'DAIKIN') {
                            errorPage = const DaikinErrorCodePage();
                          } else if (brand == 'TCL') {
                            errorPage = const TclErrorCodePage();
                          } else if (brand == 'HAIER') {
                            errorPage = const HaierErrorCodePage();
                          } else if (brand == 'LG') {
                            errorPage = const LGErrorCodePage();
                          } else if (brand == 'PANASONIC') {
                            errorPage = const PanasonicErrorCodePage();
                          } else if (brand == 'MITSUBISHI') {
                            errorPage = const MitsubishiErrorCodePage();
                          } else {
                            return; // ไม่มีหน้า Error Code สำหรับแบรนด์นี้
                          }
                          
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => errorPage,
                            ),
                          );
                        },
                        icon: const Icon(Icons.error_outline, color: Colors.red),
                        label: const Text(
                          'รหัสข้อผิดพลาด',
                          style: TextStyle(color: Colors.red),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 