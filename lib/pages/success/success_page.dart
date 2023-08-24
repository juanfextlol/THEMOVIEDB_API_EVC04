import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../models/OnboardingItem .dart';
import '../../presentation/screens/movies/home_screen.dart';

// Importa el nuevo Page vacío aquí

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  int _currentPage = 0;
  List<String> _imageUrls = [];

  final List<Color> colors = [
    Color.fromARGB(255, 204, 194, 200),
    Color.fromARGB(255, 193, 194, 172),
    Color(0xFFAB9AAC),
  ];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    for (int i = 0; i < onboardingItems.length; i++) {
      final item = onboardingItems[i];
      final imageUrl = await _getImageUrl(item.imageFilename);
      _imageUrls.add(imageUrl);
    }
    setState(() {}); // Actualizar el estado para mostrar el onboarding
  }

  @override
  Widget build(BuildContext context) {
    if (_imageUrls.isEmpty) {
      // Las imágenes aún se están cargando, mostrar una pantalla de carga
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      // Las imágenes se han cargado, mostrar el onboarding
      return Scaffold(
        backgroundColor: colors[_currentPage % colors.length],
        body: Stack(
          children: [
            LiquidSwipe(
              pages: List<Container>.generate(
                onboardingItems.length,
                (index) => Container(
                  height: MediaQuery.of(context).size.height,
                  color: colors[index % colors.length],
                  child: buildOnboardingItem(
                      onboardingItems[index], _imageUrls[index]),
                ),
              ),
              enableLoop: false,
              waveType: WaveType.liquidReveal,
              onPageChangeCallback: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            Positioned(
              bottom: 40.0,
              left: 0,
              right: 0,
              child: _buildDotsIndicator(),
            ),
            Positioned(
              top: 40.0,
              right: 20.0,
              child: Visibility(
                visible: _currentPage == onboardingItems.length - 1,
                child: IconButton(
                  icon: Icon(Icons.cabin),
                  color: const Color.fromARGB(255, 12, 12, 12),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 40.0,
              left: 20.0,
              child: Visibility(
                visible: _currentPage == 0,
                child: IconButton(
                  icon: Icon(Icons.skip_next),
                  color: const Color.fromARGB(255, 10, 10, 10),
                  onPressed: () {
                    setState(() {
                      _currentPage = onboardingItems.length - 1;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingItems.length,
        (index) => Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage
                ? const Color.fromARGB(255, 7, 7, 7)
                : const Color.fromARGB(137, 12, 12, 12),
          ),
        ),
      ),
    );
  }

  Container buildOnboardingItem(OnboardingItem item, String imageUrl) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 80.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 200.0,
          ),
          SizedBox(height: 32.0),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 15, 15, 15),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            item.description,
            style: TextStyle(
              fontSize: 16.0,
              color: const Color.fromARGB(255, 19, 18, 18),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.0),
        ],
      ),
    );
  }

  Future<String> _getImageUrl(String imageFilename) async {
    final Reference ref = _storage.ref().child(imageFilename);
    return await ref.getDownloadURL();
  }
}
