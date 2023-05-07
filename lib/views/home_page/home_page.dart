import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/views/home_page/home.dart';
import 'package:pharma_glow/views/category/category.dart';
import 'package:pharma_glow/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbarItems = [
      BottomNavigationBarItem(
        icon: Image.asset(icHome, width: 24),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 24),
        label: "Categories",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icCart, width: 24),
        label: "Cart",
      ),
      BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 24),
        label: "Account",
      ),
    ];

    var navBody = [
      Home(),
      Category()
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        leading: SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            'assets/images/logohome.png',
            width: 150,
            height: 150,
          ),
        ),
        centerTitle: false,
        // Customize the app bar as needed
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: navBody.elementAt(controller.currentNavIndex.value),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          selectedItemColor: Colors.white,
          selectedLabelStyle: const TextStyle(fontFamily: 'semibold'),
          unselectedItemColor: Colors.white,
          backgroundColor: const Color(0xFF001D66),
          type: BottomNavigationBarType.fixed,
          items: navbarItems,
          onTap: (value) {
            setState(() {
              controller.currentNavIndex.value = value;
            });
          },
        ),
      ),
    );
  }
}
