import 'package:pharma_glow/consts/consts.dart';
import 'package:get/get.dart';
import 'package:pharma_glow/views/splash-screen/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent),
          fontFamily: regular,
        ),
      home: SplashScreen(),
      );
  }
}

