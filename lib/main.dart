import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'login.dart';
import 'splashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  splashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;
  final int _totalPages = 5; // Number of cards
  int _selectedIndex = 0;

  // List of widgets to display for each tab
  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Updated data with individual heights
  final List<Map<String, dynamic>> _cardData = [
    {
      "title": "Upto 30% Offer!",
      "subtitle": "Enjoy Combo Offer",
      "image": "assets/images/img1.png",
      "imageHeight": 150.0,
      "imageWidth": 100.0

    },
    {
      "title": "Free Delivery!",
      "subtitle": "On orders over 5000",
      "image": "assets/images/img2.png",
      "imageHeight": 150.0,
      "imageWidth": 100.0

    },
    {
      "title": "Buy 1 Get 1 Free!",
      "subtitle": "Limited Time Offer",
      "image": "assets/images/img3.png",
      "imageHeight": 120.0,
      "imageWidth": 100.0

    },
    {
      "title": "New Menu Items!",
      "subtitle": "Try our latest dishes",
      "image": "assets/images/img4.png",
      "imageHeight": 130.0,
      "imageWidth": 100.0

    },
    {
      "title": "Happy Hour Deals!",
      "subtitle": "Discounts after 4PM",
      "image": "assets/images/img5.png",
      "imageHeight": 130.0,
      "imageWidth": 75.0

    },
  ];
  final List<Map<String, dynamic>> menuItems = [
    {
      'title': 'Breakfast',
      'description': 'Bread, Peanut butter, Apple',
      'image': 'assets/images/breakfast.png',
      "imageHeight": 80.0,

    },
    {
      'title': 'Lunch',
      'description': 'Chicken, Rice, Vegetables',
      'image': 'assets/images/img5.png',
      "imageHeight": 70.0,

    },
    {
      'title': 'Dinner',
      'description': 'Steak, Potatoes, Salad',
      'image': 'assets/images/dinner.png',
      "imageHeight": 80.0,

    },
    // Add more items as needed
  ];

  @override
  void initState() {
    super.initState();
    // Set a timer to automatically slide to the next page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % _totalPages;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoSlide(); // Continue the loop
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Restauranto",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w900,              fontFamily: "Schyler",
          ),),
        ),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.barsStaggered),
          onPressed: () {
            // Implement drawer logic here if needed
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              iconSize: 50.0, // Adjust the size as needed
              icon: Image.asset('assets/images/pizza.png'),
              onPressed: () {
                // Implement any action here if needed
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(

            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 280,
                      child: TextField(
                      decoration:  InputDecoration(

                        // labelText: 'Enter some text',
                          hintText:"Search",
                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(20),
                         ),
                          // prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    FloatingActionButton(onPressed: (){}
                    ,child: Icon(Icons.search,color: Colors.white,),backgroundColor:  Color(0XFFC63C51), // #ff0084
                      // #33001b
                        )

                  ],


                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Delicious Food For You!',
                      textStyle: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        fontFamily: "Schyler",

                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 100,
                  pause: const Duration(milliseconds: 500),
                ),
              ),
              Container(
                height: 180,
                width: double.infinity, // Ensure full width
                child: PageView.builder(
                  itemCount: _totalPages,
                  controller: _pageController,
                  itemBuilder: (context, index) {
                    return AnimatedCard(
                      data: _cardData[index],
                    );
                  },
                ),
              ),
              Column(

                children: [
                  SizedBox(height: 15,),
                  Text("Categories",style: TextStyle( fontSize: 32.0,
                    fontWeight: FontWeight.w900,              fontFamily: "Schyler",
                  ),),
        // SizedBox(height: 30,),
                  SingleChildScrollView(
                    scrollDirection : Axis.horizontal,
          child: SizedBox(
            height: 300,
            child: Row(


              children: menuItems.map((item) {
                return MenuItemCard(
                  title: item['title']!,
                  description: item['description']!,
                  imagePath: item['image']!,
                  height1:item["imageHeight"]!,
                );
              }).toList(),
            ),


          ),


        ),

                ],
              ),

              Column(
                children: [
                  Text("Popular",style: TextStyle(fontSize: 32,fontWeight: FontWeight.w900,              fontFamily: "Schyler",
                  ),),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // First Card
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFff4e50),
                                  Color(0xFFf9d423),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Circular image with border
                                    Center(
                                      child: Container(
                                        width: 100, // Make sure width and height are equal
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: ClipOval(

                                          child: Image.asset(
                                            'assets/images/burger.jpg', // Replace with your image asset path
                                            fit: BoxFit.cover,
                                            
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Burger name
                                    const Text(
                                      'Beef Burger',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Star rating
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star_half, color: Colors.amber, size: 16.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '4.5',
                                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Add to cart button
                                    Row(
                                      children: const [
                                        Text(
                                          '899 Pkr', // Example price
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.favorite_border),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Second Card
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFff4e50),
                                  Color(0xFFf9d423),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Circular image with border
                                    Center(
                                      child: Container(
                                        width: 100, // Make sure width and height are equal
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/pizza1.webp', // Replace with your image asset path
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Pizza name
                                    const Text(
                                      'Pizza',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Star rating
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star_half, color: Colors.amber, size: 16.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '4.5',
                                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Add to cart button
                                    Row(
                                      children: const [
                                        Text(
                                          '899 Pkr', // Example price
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.favorite_border),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Third Card
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFff4e50),
                                  Color(0xFFf9d423),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Circular image with border
                                    Center(
                                      child: Container(
                                        width: 100, // Make sure width and height are equal
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/steak.jpg', // Replace with your image asset path
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Steak name
                                    const Text(
                                      'Beef Steak',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Star rating
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star_half, color: Colors.amber, size: 16.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '4.5',
                                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Add to cart button
                                    Row(
                                      children: const [
                                        Text(
                                          '899 Pkr', // Example price
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.favorite_border),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Fourth Card
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFff4e50),
                                  Color(0xFFf9d423),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 4.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Container(
                                width: 200,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Circular image with border
                                    Center(
                                      child: Container(
                                        width: 100, // Make sure width and height are equal
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 4.0,
                                          ),
                                        ),
                                        child: ClipOval(
                                          child: Image.asset(
                                            'assets/images/shake.jpg', // Replace with your image asset path
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Shake name
                                    const Text(
                                      'Oreo Shake',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    // Star rating
                                    Row(
                                      children: const [
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star, color: Colors.amber, size: 16.0),
                                        Icon(Icons.star_half, color: Colors.amber, size: 16.0),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '4.5',
                                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12.0),
                                    // Add to cart button
                                    Row(
                                      children: const [
                                        Text(
                                          '899 Pkr', // Example price
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(Icons.favorite_border),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),

        bottomNavigationBar: Container(

          height: 60.0, // Set the height of the container

          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), // Optional: to add margin around the container
          decoration: BoxDecoration(

              gradient: LinearGradient(
                colors: [
                  Color(0XFF556270), // #ff0084
                  Color(0xFFff6b6b), // #33001b
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),


            // color: Colors.red, // Background color of the container
            borderRadius: BorderRadius.circular(30.0), // Circular border radius
            // boxShadow: [
            //   BoxShadow(
            //     // color: Colors.red,
            //     blurRadius: 4.0,
            //     offset: Offset(0, 2),
            //   ),
            // ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent, // Remove background color

            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Carts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0XFFff6b6b),
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,

            // elevation: 8, // Set elevation to 0 to avoid extra shadow
          ),
        )

    );
  }
}

class AnimatedCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const AnimatedCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: double.infinity, // Ensure full width
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(30.0),
          ),
          child: Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
    Color(0XFFff4e50), // #ff0084
    Color(0xFFf9d423), // #33001b
    ],),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data["title"],
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            data["subtitle"],
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                // Implement action here
                              },
                              child: Text(
                                "Order Now",
                                style: TextStyle(color: Color(0XFFEF5350)),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      6.0), // Set the border radius
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: data["imageHeight"], // Use individual height
                      width: data["imageWidth"], // Use individual height

                      child: Image.asset(data["image"]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// Widget to render each menu item card
class MenuItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final double height1;


  MenuItemCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.height1,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160, // Width of each card
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(100.0),
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
            child: Card(
              child: Container(
                height: 220,
                width: 180,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFD38312), // #ff0084
                      Color(0xFFA83279), // #33001b
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 30),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text("Order",style: TextStyle(color: Color(0XFFEF5350)),),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: -30,
            child: Image.asset(
              imagePath,
              height :height1, // Use individual height
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy screen for Home
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Dummy screen for Favorites
class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorites Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Dummy screen for Profile
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}



//
//
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Bottom Navigation Example',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _selectedIndex = 0;
//
//   // List of widgets to display for each tab
//   final List<Widget> _pages = [
//     HomeScreen(),
//     FavoritesScreen(),
//     ProfileScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bottom Navigation Example'),
//       ),
//       body: Center(
//         child: _pages[_selectedIndex], // Display the selected page
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
//
// // Dummy screen for Home
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Home Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
//
// // Dummy screen for Favorites
// class FavoritesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Favorites Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
//
// // Dummy screen for Profile
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Profile Screen',
//         style: TextStyle(fontSize: 24),
//       ),
//     );
//   }
// }
//
