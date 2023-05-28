import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/views/home_page/home.dart';
import 'package:pharma_glow/controllers/home_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:pharma_glow/lib/firebase_options.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(PharmaGlowApp());
}

class PharmaGlowApp extends StatelessWidget {
  const PharmaGlowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pharma Glow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

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
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(icCategories, width: 24),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(icCart, width: 24),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Image.asset(icProfile, width: 24),
      label: 'Account',
    ),
  ];

  final List<Widget> navBody = [
    Home(),
    const CategoryPage(),
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
                      'Prescription Drugs',
                      'assets/images/prescription.jpg',
                    ),
                    buildCategoryCard(
                      context,
                      'Cold Relief',
                      'assets/images/cold.webp',
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategoryCard(
                      context,
                      'Everyday Essentials',
                      'assets/images/everyday.webp',
                    ),
                    buildCategoryCard(
                      context,
                      'Facial Care',
                      'assets/images/facial-care.webp',
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    buildCategoryCard(
                      context,
                      'Multivitamins',
                      'assets/images/vitamins.webp',
                    ),
                    buildCategoryCard(
                      context,
                      'Baby Care',
                      'assets/images/baby.webp',
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

  Widget buildCategoryCard(
      BuildContext context, String title, String imageUrl) {
    return GestureDetector(
      onTap: () {
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
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF001D66),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF001D66),
        title: Text(category),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .where('category', isEqualTo: category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No products available for this category.');
          }

          final products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Two cards in each row
              childAspectRatio: 0.75, // Adjust the aspect ratio as needed
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = products[index];
              // Access the product data from the document
              String productName = document['name'];
              String productImage = document['image'];
              int productPrice = document['price'];

              return GestureDetector(
                onTap: () {
                  // Navigate to product details page
                },
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                        productImage,
                        width: 120.0,
                        height: 120.0,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        productName,
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        ' \$${productPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: Color(0xFF001D66),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          // Add to cart functionality
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(
                              0xFF001D66), // Set the desired background color
                        ),
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final String productName;
  final String productImage;
  final int productPrice;

  const ProductDetailsPage({
    required this.productName,
    required this.productImage,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              productImage,
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 10.0),
            Text(
              productName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Price: \$${productPrice.toString()}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
