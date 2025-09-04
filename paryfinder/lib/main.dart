import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrusel Estilo Celular',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF2F1B5C), // Fondo color #2F1B5C
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Imágenes repetidas para carrusel 1
  final List<String> imagenes1 = [
    'assets/images/Felina .png',
    'assets/images/dakity .png',
    'assets/images/mono .png',
    'assets/images/Felina .png',
    'assets/images/dakity .png',
    'assets/images/mono .png',
  ];

  // Imágenes repetidas para carrusel 2
  final List<String> imagenes2 = [
    'assets/images/dakity .png',
    'assets/images/mono .png',
    'assets/images/Felina .png',
    'assets/images/dakity .png',
    'assets/images/mono .png',
    'assets/images/Felina .png',
  ];

  late PageController _pageController1;
  late PageController _pageController2;

  int _currentPage1 = 0;
  int _currentPage2 = 0;

  Timer? _timer1;
  Timer? _timer2;

  @override
  void initState() {
    super.initState();

    _pageController1 = PageController(viewportFraction: 0.5);
    _pageController2 = PageController(viewportFraction: 0.5);

    _timer1 = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage1 < imagenes1.length - 1) {
        _currentPage1++;
      } else {
        _currentPage1 = 0;
      }
      _pageController1.animateToPage(
        _currentPage1,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });

    _timer2 = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage2 < imagenes2.length - 1) {
        _currentPage2++;
      } else {
        _currentPage2 = 0;
      }
      _pageController2.animateToPage(
        _currentPage2,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer1?.cancel();
    _timer2?.cancel();
    _pageController1.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi App Estilo Celular'),
        backgroundColor: Color(0xFF2F1B5C),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Container(
            width: 200,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar...',
                hintStyle: TextStyle(color: Colors.white54),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.blue[700],
                prefixIcon: Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2F1B5C)),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Opción 1'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('Opción 2'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Carrusel 1',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _pageController1,
                itemCount: imagenes1.length,
                itemBuilder: (context, index) {
                  bool active = index == _currentPage1;
                  return _buildImageCard(imagenes1[index], active);
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Carrusel 2',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _pageController2,
                itemCount: imagenes2.length,
                itemBuilder: (context, index) {
                  bool active = index == _currentPage2;
                  return _buildImageCard(imagenes2[index], active);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath, bool active) {
    final double marginTop = active ? 0 : 30;
    final double scale = active ? 1.0 : 0.85;

    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.only(top: marginTop, bottom: 20, left: 10, right: 10),
      transform: Matrix4.identity()..scale(scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5), // Sombra blanca suave
            blurRadius: 20,
            spreadRadius: 1,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AspectRatio(
          aspectRatio: 9 / 16,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
