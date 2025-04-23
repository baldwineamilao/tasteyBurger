import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

void main() => runApp(BurgerApp());

class BurgerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return CupertinoApp(
          debugShowCheckedModeBanner: false,
          theme: CupertinoThemeData(
            brightness: isDarkMode ? Brightness.dark : Brightness.light,
          ),
          home: LoginPage(),
        );
      },
    );
  }
}

// ----------------------------
// LOGIN PAGE
// ----------------------------
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (_) => PaymentSelectionPage()),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: Text("Login Failed"),
          content: Text("Please enter both username and password."),
          actions: [
            CupertinoDialogAction(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_burger.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "TastyBurger Login",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                CupertinoTextField(
                  controller: usernameController,
                  placeholder: "Username",
                ),
                SizedBox(height: 12),
                CupertinoTextField(
                  controller: passwordController,
                  placeholder: "Password",
                  obscureText: true,
                ),
                SizedBox(height: 20),
                CupertinoButton.filled(
                  child: Text("Login"),
                  onPressed: _login,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------
// PAYMENT SELECTION PAGE
// ----------------------------
class PaymentSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login_burger.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Choose Payment Method",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.white,
                  ),
                ),
                SizedBox(height: 32),
                CupertinoButton.filled(
                  child: Text("Online Payment"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (_) => HomePage()),
                    );
                  },
                ),
                SizedBox(height: 16),
                CupertinoButton(
                  color: CupertinoColors.systemGrey4,
                  child: Text("Cash on Delivery"),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(builder: (_) => HomePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ----------------------------
// HOME PAGE (unchanged)
// ----------------------------
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    "All", "Cheese", "Chicken", "Fish", "Vegetarian", "Drinks"
  ];
  String selectedCategory = "All";
  String searchQuery = "";

  final List<Map<String, String>> burgers = [
    {
      "title": "King Size Burger",
      "desc": "Egg, Mustard, Sauce, Onion, Garlic, Medium Beef",
      "price": "\$4.15",
      "weight": "525g",
      "img": "assets/images/burger1.jpg",
      "category": "Cheese",
    },
    {
      "title": "Cheese Burger",
      "desc": "Cheddar, Onion, Tomato, Lettuce",
      "price": "\$3.15",
      "weight": "425g",
      "img": "assets/images/burger2.jpg",
      "category": "Cheese",
    },
    {
      "title": "BBQ Burger",
      "desc": "BBQ Sauce, Beef, Onion Rings",
      "price": "\$3.27",
      "weight": "450g",
      "img": "assets/images/burger3.jpg",
      "category": "Chicken",
    },
    {
      "title": "Homemade Vegan Burger",
      "desc": "Vegetarian Burger",
      "price": "\$7.00",
      "weight": "300mg",
      "img": "assets/images/burger1.jpg",
      "category": "Vegetarian",
    },
    {
      "title": "Homemade Fish Burger",
      "desc": "Fish Burger",
      "price": "\$10.00",
      "weight": "150mg",
      "img": "assets/images/burger3.jpg",
      "category": "Fish",
    },
    {
      "title": "Coke",
      "desc": "Chilled Coca-Cola classic",
      "price": "\$1.50",
      "weight": "330ml",
      "img": "assets/images/drinks1.jpg",
      "category": "Drinks",
    },
    {
      "title": "Orange Juice",
      "desc": "Freshly squeezed orange juice",
      "price": "\$2.00",
      "weight": "300g",
      "img": "assets/images/drink2.jpg",
      "category": "Drinks",
    },
  ];

  List<Map<String, String>> get filteredBurgers {
    final filtered = selectedCategory == "All"
        ? burgers
        : burgers.where((burger) => burger["category"] == selectedCategory).toList();

    if (searchQuery.isEmpty) return filtered;

    return filtered.where((burger) =>
        burger["title"]!.toLowerCase().contains(searchQuery.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('TASTYBURGER'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.settings),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (_) => SettingsPage()),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      color: isSelected
                          ? CupertinoColors.systemYellow
                          : CupertinoColors.systemGrey4,
                      child: Text(category),
                      onPressed: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CupertinoSearchTextField(
                placeholder: 'Search burgers or drinks',
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredBurgers.length,
                itemBuilder: (context, index) {
                  final burger = filteredBurgers[index];
                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => BurgerDetailPage(burger: burger),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                burger["img"]!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    burger["title"]!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    burger["desc"]!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        burger["price"]!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: CupertinoColors.activeGreen,
                                        ),
                                      ),
                                      Text(
                                        burger["weight"]!,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: CupertinoColors.systemGrey2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ----------------------------
// DETAIL PAGE (unchanged)
// ----------------------------
class BurgerDetailPage extends StatelessWidget {
  final Map<String, String> burger;

  BurgerDetailPage({required this.burger});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(burger["title"]!),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  burger["img"]!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                burger["desc"]!,
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    burger["price"]!,
                    style: TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.activeGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    burger["weight"]!,
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton.filled(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: Text('Added to Cart'),
                        content:
                        Text('${burger["title"]} has been added to your cart.'),
                        actions: [
                          CupertinoDialogAction(
                            child: Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------
// SETTINGS PAGE (UPDATED)
// ----------------------------
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = isDarkModeNotifier.value;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            CupertinoListTile(
              title: Text("Dark Mode"),
              trailing: CupertinoSwitch(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                    isDarkModeNotifier.value = value;
                  });
                },
              ),
            ),
            CupertinoListTile(
              title: Text("Developer Information"),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text("Developers"),
                    content: Column(
                      children: [
                        SizedBox(height: 8),
                        for (var dev in [
                          {"name": "Nucum Jhon Paul", "img": "assets/images/developer.png.png"},
                          {"name": "Mariel Mallari", "img": "assets/images/mariel.jpg"},
                          {"name": "Bryon Ruzzel Hernandez", "img": "assets/images/bryon.jpg"},
                          {"name": "Nicolas James Bellen", "img": "assets/images/nicolas.jpg"},
                          {"name": "Baldwin Eamilao", "img": "assets/images/baldwin.jpg"},
                          {"name": "Aldrin Bartolome", "img": "assets/images/aldrin.jpg"},
                        ])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    dev["img"]!,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(dev["name"]!),
                              ],
                            ),
                          )
                      ],
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
            CupertinoListTile(
              title: Text("About"),
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text("About TastyBurger App"),
                    content: Text("Welcome to TastyBurger. Enjoy your burger!"),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('OK'),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
