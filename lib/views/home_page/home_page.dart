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
  final HomeController controller = Get.put(HomeController());

  final List<BottomNavigationBarItem> navbarItems = [
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

  final List<Widget> navBody = [
    Home(),
    CategoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: Obx(() => navBody[controller.currentNavIndex.value]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildCategoryCard(
                        context,
                        "Infectious",
                        "assets/images/infectious.png",
                      ),
                      buildCategoryCard(
                        context,
                        "Gastrointestinal",
                        "assets/images/gastro.png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildCategoryCard(
                        context,
                        "Skeletal",
                        "assets/images/skeletal.png",
                      ),
                      buildCategoryCard(
                        context,
                        "Cardio",
                        "assets/images/cardio.png",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      buildCategoryCard(
                        context,
                        "Respiratory",
                        "assets/images/lungs.jpg",
                      ),
                      buildCategoryCard(
                        context,
                        "Neurological",
                        "assets/images/neuro.png",
                      ),
                    ],
                  ),
                ],
              ),
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

  Widget buildCategoryCard(BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
// Handle category card click, navigate to products page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductsPage(category: title),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: 120.0,
              height: 120.0,
            ),
            const SizedBox(height: 10.0),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Category Page'),
      ),
    );
  }
}

class ProductsPage extends StatelessWidget {
  final String category;

  const ProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('Products belonging to $category category'),
      ),
    );
  }
}



