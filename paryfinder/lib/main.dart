import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartyFinder',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imagenes1 = [
    'assets/images/Felina .png',
    'assets/images/dakity .png',
    'assets/images/mono .png',
    'assets/images/Felina .png',
    'assets/images/dakity .png',
    'assets/images/mono .png',
  ];

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
    _pageController1 = PageController(viewportFraction: 0.6);
    _pageController2 = PageController(viewportFraction: 0.6);

    _timer1 = Timer.periodic(Duration(seconds: 3), (timer) {
      _currentPage1 = (_currentPage1 + 1) % imagenes1.length;
      _pageController1.animateToPage(
        _currentPage1,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    });

    _timer2 = Timer.periodic(Duration(seconds: 3), (timer) {
      _currentPage2 = (_currentPage2 + 1) % imagenes2.length;
      _pageController2.animateToPage(
        _currentPage2,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Party Finder'),
          backgroundColor: Colors.deepPurpleAccent.shade700.withOpacity(0.9),
          elevation: 8,
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
                  hintStyle: TextStyle(color: Colors.white60),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white12,
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          backgroundColor: Color(0xFF1C1B2F),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Text(
                  'Menú',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                title: Text('Inicio'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Perfil'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                'Desatacados',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 330,
                child: PageView.builder(
                  controller: _pageController1,
                  itemCount: imagenes1.length,
                  itemBuilder: (context, index) {
                    bool active = index == _currentPage1;
                    return _buildImageCard(imagenes1[index], active);
                  },
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Destacados',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 330,
                child: PageView.builder(
                  controller: _pageController2,
                  itemCount: imagenes2.length,
                  itemBuilder: (context, index) {
                    bool active = index == _currentPage2;
                    return _buildImageCard(imagenes2[index], active);
                  },
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath, bool active) {
    final double marginTop = active ? 0 : 30;
    final double scale = active ? 1.0 : 0.85;

    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(top: marginTop, bottom: 20, left: 10, right: 10),
      transform: Matrix4.identity()..scale(scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.purple.shade200, Colors.deepPurple.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: Offset(0, 12),
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
