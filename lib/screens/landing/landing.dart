import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatternCarousel extends StatefulWidget {
  const PatternCarousel({Key? key}) : super(key: key);

  @override
  _PatternCarouselState createState() => _PatternCarouselState();
}

class _PatternCarouselState extends State<PatternCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> patterns = [
    {
      'path': 'assets/Pattern1.svg',
      'backgroundColor': "#251241",
    },
    {
      'path': 'assets/Pattern2.svg',
      'backgroundColor': "#000000",
    },
    {
      'path': 'assets/Pattern3.svg',
      'backgroundColor': "#ff95a9",
    },
    {
      'path': 'assets/Pattern4.svg',
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
                child: _TilingPattern(patternPath: pattern['path']),
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 16,
            right: 16,
            child:Hero(
            tag: 'getStartedButton',
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/role-selection');
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF000000),
                      Color.fromARGB(255, 30, 3, 55), 

                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 20, 3, 50),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4), 
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}

class _TilingPattern extends StatelessWidget {
  final String patternPath;

  const _TilingPattern({Key? key, required this.patternPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            for (double x = 0; x < width; x += 100) // Tile width
              for (double y = 0; y < height; y += 100) // Tile height
                Positioned(
                  left: x,
                  top: y,
                  child: SvgPicture.asset(
                    patternPath,
                    width: 100, // Size of each SVG tile
                    height: 100,
                  ),
               ),
          ],
        );
      },
    );
  }
}
