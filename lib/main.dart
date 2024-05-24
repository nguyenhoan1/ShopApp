import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopp/Locator/locator.dart';
import 'package:shopp/Service/Auth_service.dart';
import 'package:shopp/config/colour.dart';
import 'package:shopp/config/router.dart';
import 'package:shopp/screen/Login/login_screen.dart';
import 'package:shopp/screen/Signup/signup_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() async  {
 WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  locator.registerSingleton<AuthService>(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Palette.logo),
        useMaterial3: true,
      ),
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imglist = [
    'assets/images/Moi.jpg', 
    'assets/images/Son.jpg',
    'assets/images/Cream.jpg', 
    'assets/images/SleepingMask.jpg',
    'assets/images/SunCream.jpg',
  ];
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Palette.logo,
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset('assets/images/Logo.png', height: 180),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background.jpg', fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 90),
                CarouselSlider(
                  items: imglist.map((item) => Container(
                    key: ValueKey(item),  // Thêm khóa duy nhất cho mỗi item
                    margin: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      child: Image.asset(item, fit: BoxFit.cover, width: 800),
                    ),
                  )).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: 300.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      // Sử dụng addPostFrameCallback để cập nhật trạng thái sau khi build hoàn tất
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }
                      });
                    },
                  ),
                ),
                AnimatedSmoothIndicator(
                  key: ValueKey(_currentIndex), // Thêm khóa duy nhất cho AnimatedSmoothIndicator
                  activeIndex: _currentIndex,
                  count: imglist.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.pinkAccent,
                    dotColor: Colors.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                    expansionFactor: 3,
                    spacing: 8,
                  ),
                  onDotClicked: (index) => _controller.animateToPage(index),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          }
                        });
                      },
                      child: const Text("Sign Up"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          }
                        });
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
