import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
        icon: Icon(Icons.home_max),
        label: ('Home')
        ),
         BottomNavigationBarItem(
        icon: Icon(Icons.label_outline),
        label: ('Categorias')
        ),
         BottomNavigationBarItem(
        icon: Icon(Icons.favorite, color: Colors.red,),
        label: ('Favoritos')
        ),
        ],
    );
  }
}
