import 'package:flutter/material.dart';

class CarouselLogin extends StatefulWidget {
  const CarouselLogin({super.key});
  @override
  _CarouselLoginState createState() => _CarouselLoginState();
}

class _CarouselLoginState extends State<CarouselLogin> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<String> _images = [
    'assets/play.png',
    'assets/team.png',
    'assets/time.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
