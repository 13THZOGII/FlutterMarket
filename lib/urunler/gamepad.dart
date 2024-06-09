import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import '../../core/localizations.dart';

class GamepadScreen extends StatefulWidget {
  const GamepadScreen({super.key});

  @override
  State<GamepadScreen> createState() => _GamepadScreenState();
}

class _GamepadScreenState extends State<GamepadScreen> {
  var products = [
    {
      "id": 94,
      "name": "RGB Gaming Ped",
      "in-stock": false,
      "price": 11000.00,
      "photo": "assets/images/gamepad1.jpg",
    },
    {
      "id": 93,
      "name": "Gaming Ped",
      "in-stock": false,
      "price": 12499,
      "photo": "assets/images/gamepad2.jpg",
    },
    {
      "id": 92,
      "name": "Gaming Ped RGB 2",
      "in-stock": true,
      "price": 8750,
      "photo": "assets/images/gamepad3.jpg",
    },
  ];

  late ProductsCubit productsCubit;
  late CartCubit cartCubit;
  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("products")),
        actions: [
          if (clientCubit.state.DarkMode)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    clientCubit.changeDarkMode(DarkMode: false);
                  },
                  icon: Icon(Icons.sunny)),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  onPressed: () {
                    clientCubit.changeDarkMode(DarkMode: true);
                  },
                  icon: Icon(Icons.nightlight)),
            ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () {
                if (clientCubit.state.language == "tr") {
                  clientCubit.changeLanguage(language: "en");
                } else {
                  clientCubit.changeLanguage(language: "tr");
                }
              },
              icon: Icon(Icons.language),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/favorites"),
              icon: Icon(Icons.favorite),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/cart"),
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body:
          BlocBuilder<ProductsCubit, ProductsState>(builder: (context, state) {
        return SizedBox.expand(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.secondary.withAlpha(50),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: const EdgeInsets.all(14.0),
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Image.network(products[index]["photo"].toString()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(products[index]["name"].toString()),
                        if (productsCubit
                            .isFavorite(products[index]["id"] as int))
                          IconButton(
                              onPressed: () {
                                productsCubit.removeFromFavorites(
                                    products[index]["id"] as int);
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ))
                        else
                          IconButton(
                              onPressed: () {
                                productsCubit.addToFavorites(products[index]);
                              },
                              icon: const Icon(Icons.favorite_border))
                      ],
                    ),
                    if (products[index]["in-stock"] as bool)
                      ElevatedButton(
                        onPressed: () {
                          cartCubit.sepeteEkle(
                            id: products[index]["id"] as int,
                            photo: products[index]["photo"].toString(),
                            ad: products[index]["name"].toString(),
                            sayi: 1,
                            fiyat: products[index]["price"] as double,
                          );

                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(AppLocalizations.of(context)
                                  .getTranslate("cart")),
                              content: Text(AppLocalizations.of(context)
                                  .getTranslate("added-to-cart")),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          GoRouter.of(context).push("/cart"),
                                      child: Text(AppLocalizations.of(context)
                                          .getTranslate("go_to_cart")),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          GoRouter.of(context).pop(),
                                      child: Text("X"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)
                            .getTranslate("add_to_basket")),
                      ),
                    if (products[index]["in-stock"] as bool)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.check_box),
                              Text(AppLocalizations.of(context)
                                  .getTranslate("in-stock")),
                            ],
                          ),
                          Text(products[index]["price"].toString() + " ₺"),
                        ],
                      )
                    else
                      Row(
                        children: [
                          const Icon(Icons.error),
                          Text(AppLocalizations.of(context)
                              .getTranslate("not-available")),
                        ],
                      ),
                    const Divider(),
                  ],
                )),
          ),
        );
      }),
    );
  }
}