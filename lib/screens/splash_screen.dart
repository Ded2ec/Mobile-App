import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'home_page.dart';

// ====== Splash Screen Page ======
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  bool _showProgress = false;
  bool _showText = true;
  late Animation<double> _textOpacity;
  late Animation<double> _imageOpacity;
  late Animation<double> _progressOpacity;

  @override
  void initState() {
    super.initState();
    
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _imageOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    _progressOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    ));

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _showProgress = true;
      });
      _progressController.forward();
    });

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
        context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => 
              const MyHomePage(title: 'P&M Electronics'),
            transitionDuration: const Duration(milliseconds: 1500), 
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: CurvedAnimation( 
                  parent: animation,
                  curve: Curves.easeOut,
                ),
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _textOpacity,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textOpacity.value,
                    child: Container( 
                      height: 50, 
                      alignment: Alignment.center, 
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        child: AnimatedTextKit(
                          isRepeatingAnimation: false, 
                          animatedTexts: [
                            RotateAnimatedText(
                              'Air Tech',
                              textStyle: const TextStyle(
                                fontSize: 38.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                              rotateOut: false, 
                              duration: const Duration(milliseconds: 1500),
                            ),
                          ],
                          totalRepeatCount: 1,
                          displayFullTextOnTap: false,
                          stopPauseOnTap: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _imageOpacity,
                child: Container(  
                  width: 350,
                  height: 350,
                  alignment: Alignment.center, 
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: SvgPicture.asset(
                      'assets/images/output.svg',
                      fit: BoxFit.contain,
                      allowDrawingOutsideViewBox: true,
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
              if (_showProgress) ...[
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: _progressOpacity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: AnimatedBuilder(
                      animation: _progressController,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: _progressController.value,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
} 