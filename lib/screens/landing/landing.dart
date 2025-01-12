import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatternCarousel extends StatefulWidget {
  const PatternCarousel({super.key});

  @override
  _PatternCarouselState createState() => _PatternCarouselState();
}

class _PatternCarouselState extends State<PatternCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> patterns = [
    {
      'path': 'assets/pattern1.svg',
      'backgroundColor': "#ffffff",
    },
    {
      'path': 'assets/pattern2.svg',
      'backgroundColor': "#000000",
    },
    {
      'path': 'assets/pattern3.svg',
      'backgroundColor': "#252144",
    },
    {
      'path': 'assets/pattern4.svg',
      'backgroundColor': "#ffffff",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % patterns.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentPage = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: patterns.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final pattern = patterns[index];
              final backgroundColor = Color(
                int.parse(pattern['backgroundColor']!.replaceFirst('#', '0xFF')),
              );

              return Container(
                  color: backgroundColor,
                  child: SvgPicture.asset(pattern['path'],
                                        fit: BoxFit.cover,
                                        ),
                );
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
