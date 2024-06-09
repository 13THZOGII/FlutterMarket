import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/cart/cart_cubit.dart';
import 'package:flutter_application_2/bloc/client/client_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ClientCubit clientCubit;
  late CartCubit cartCubit;
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Uint8List? _profileImageBytes;
  String _name = '';
  String _email = '';

  final List<String> images = [
    'assets/images/amd.png',
    'assets/images/amd.png',
    'assets/images/amd.png',
  ];

  final List<Map<String, dynamic>> categories = [
    {
      "icon": Icons.phone,
      "label": "Telefon",
      "route": "/telephone",
    },
    {
      "icon": Icons.camera_alt,
      "label": "Fotoğraf M",
      "route": "/camera",
    },
    {
      "icon": Icons.computer,
      "label": "Bilgisayar",
      "route": "/computer",
    },
    {
      "icon": Icons.monitor_sharp,
      "label": "Monitör",
      "route": "/monitor",
    },
  ];

  final List<Map<String, dynamic>> populer = [
    {
      "id": 18,
      "name": "iPhone 15 Pro Max",
      "in-stock": false,
      "price": 0,
      "photo": "assets/images/iphone15.jpg",
      "route": "/product/17"
    },
    {
      "id": 19,
      "name": "Galaxy S25 Ultra",
      "in-stock": true,
      "price": 65000.00,
      "photo": "assets/images/s23.jpg",
      "route": "/product/17"
    },
    {
      "id": 219,
      "name": "Galaxy S25 Ultra",
      "in-stock": true,
      "price": 65000.00,
      "photo": "assets/images/s23.jpg",
      "route": "/product/17"
    },
    {
      "id": 20,
      "name": "Galaxy S25 Ultra Phone",
      "in-stock": true,
      "price": 65000.00,
      "photo": "assets/images/s23.jpg",
      "route": "/product/17"
    },
  ];

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    cartCubit = context.read<CartCubit>();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? 'İsim Soyisim';
      _email = prefs.getString('email') ?? 'eposta@example.com';
      String? imagePath = prefs.getString('profileImage');
      if (imagePath != null) {
        print("Profil resmi yüklendi: $imagePath");
        _profileImageBytes = base64Decode(imagePath);
      } else {
        print("Profil resmi bulunamadı");
        _profileImageBytes = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/profile').then((_) {
                        _loadProfile();
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(150),
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
  backgroundImage: _profileImageBytes != null
    ? Image.memory(_profileImageBytes!).image
    : Image.network(
        "https://www.rollingstone.com/wp-content/uploads/2023/02/elon-twitter-new-ceo.jpg?w=1581&h=1054&crop=1",
      ).image,
  maxRadius: 42,
  child: _profileImageBytes != null
    ? null
    : Icon(
        Icons.account_circle,
        size: 84,
        color: Colors.grey[300],
      ),
),

                        ),
                        const SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              _email,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(0.75),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.orange,
                  ),
                  title:
                      Text(AppLocalizations.of(context).getTranslate("home")),
                  selected: true,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.orange,
                  ),
                  title:
                      Text(AppLocalizations.of(context).getTranslate("about")),
                  onTap: () {
                    GoRouter.of(context).push("/about");
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.orange,
                  ),
                  title: Text(
                      AppLocalizations.of(context).getTranslate("products")),
                  onTap: () {
                    GoRouter.of(context).push("/products");
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.orange,
                  ),
                  title: Text(
                      AppLocalizations.of(context).getTranslate("settings")),
                  onTap: () {
                    GoRouter.of(context).push("/settings");
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.call,
                    color: Colors.orange,
                  ),
                  title: Text(
                      AppLocalizations.of(context).getTranslate("contact")),
                  onTap: () {
                    GoRouter.of(context).push("/contact");
                  },
                ),
                SwitchListTile(
                  value: clientCubit.state.DarkMode,
                  onChanged: (value) {
                    clientCubit.changeDarkMode(DarkMode: value);
                  },
                  secondary: clientCubit.state.DarkMode
                      ? const Icon(
                          Icons.sunny,
                          color: Colors.orange,
                        )
                      : const Icon(
                          Icons.nightlight,
                          color: Colors.orange,
                        ),
                  title: Text(
                      AppLocalizations.of(context).getTranslate("dark_mode")),
                ),
                ListTile(
                  leading: Icon(
                    Icons.language,
                    color: Colors.orange,
                  ),
                  title: Text(clientCubit.state.language == 'tr'
                      ? AppLocalizations.of(context).getTranslate("english")
                      : AppLocalizations.of(context).getTranslate("turkish")),
                  onTap: () {
                    if (clientCubit.state.language == 'tr') {
                      clientCubit.changeLanguage(language: 'en');
                    } else {
                      clientCubit.changeLanguage(language: 'tr');
                    }
                  },
                ),
                Gap(300),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.orange,
                  ),
                  title: Text(
                    AppLocalizations.of(context).getTranslate("exit"),
                  ),
                  onTap: () {
                    GoRouter.of(context).go('/login');
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title:
                Text(AppLocalizations.of(context).getTranslate("home_title")),
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      _selectLocation();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.orange,
                            ),
                            Text(AppLocalizations.of(context)
                                .getTranslate("location")),
                          ],
                        ),
                        IconButton(
                          onPressed: () => GoRouter.of(context).push("/cart"),
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    hintText: AppLocalizations.of(context)
                                        .getTranslate("search_hint"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).push("/settings");
                        },
                        icon: Icon(
                          Icons.settings,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _controller,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            );
                          },
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              images.length,
                              (index) => buildDot(index: index),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(11),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .getTranslate("categories"),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  GoRouter.of(context).push("/categories");
                                },
                                child: Text(
                                  AppLocalizations.of(context)
                                      .getTranslate("see-all"),
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: SizedBox(
                          height: 116,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 11),
                                child: GestureDetector(
                                  onTap: () {
                                    GoRouter.of(context)
                                        .push(categories[index]['route']);
                                  },
                                  child: Container(
                                    width: 81,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(categories[index]['icon'],
                                            size: 26),
                                        SizedBox(height: 15),
                                        Text(
                                          getTranslatedLabel(context,
                                              categories[index]['label']),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(11),
                              child: Text(
                                "Popular",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "See all",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: populer.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .push('/product/${populer[index]["id"]}');
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: SizedBox(
                                    width: 120,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          populer[index]["photo"],
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          populer[index]["name"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              populer[index]["in-stock"]
                                                  ? Icons.check_circle
                                                  : Icons.cancel,
                                              color: populer[index]["in-stock"]
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              populer[index]["in-stock"]
                                                  ? "In Stock"
                                                  : "Out of Stock",
                                              style: TextStyle(
                                                color: populer[index]
                                                        ["in-stock"]
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          "${populer[index]["price"]} TL",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentIndex == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentIndex == index ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _selectLocation() {
    print("Lokasyona tıklandı!");
  }

  String getTranslatedLabel(BuildContext context, String label) {
    return AppLocalizations.of(context).getTranslate(label);
  }
}
