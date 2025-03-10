import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/home_page.dart';
import '../screens/brand_detail_screen.dart';

// ====== Brand Card Widget ======
class BrandCard extends StatelessWidget {
  final String brand;
  final String subtitle;
  final String image;
  final bool isSvg;
  final Color backgroundColor;
  final bool isOutdoorOnly;

  const BrandCard({
    super.key,
    required this.brand,
    required this.subtitle,
    required this.image,
    required this.isSvg,
    required this.backgroundColor,
    required this.isOutdoorOnly,
  });

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
    return Hero(
      tag: 'brand-$brand',
      child: Material(
        child: GestureDetector(
          onTap: () async {
            // บันทึกประวัติการเข้าชมก่อน
            await _saveRecentBrand(brand);
            
            // Navigate directly to brand detail screen
            if (context.mounted) {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BrandDetailScreen(
                    brand: brand,
                    image: image,
                    isSvg: isSvg,
                    isOutdoorOnly: isOutdoorOnly,
                  ),
                ),
              );
              
              // อัปเดตประวัติการเข้าชมหลังจากกลับมา
              if (result == true) {
                // ไม่จำเป็นต้องทำอะไรเพิ่มเติม เพราะประวัติถูกอัปเดตจากหน้าแรกแล้ว
              }
            }
          },
          child: Container(
            width: 180,
            height: 260,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        image,
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                        placeholderBuilder: (BuildContext context) => Container(
                          width: 140,
                          height: 140,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        final textColor = snapshot.hasData 
                            ? Color(snapshot.data!.getInt('textColor') ?? Colors.black.value)
                            : Colors.black;
                        
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              brand,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            if (isOutdoorOnly)
                              const Text(
                                'Outdoor Unit',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            else
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 