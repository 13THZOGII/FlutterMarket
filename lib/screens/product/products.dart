import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localizations.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var products = [
    {
      "id": 1,
      "name": "MacBook Pro 2024 M2 Pro",
      "in-stock": true,
      "price": 65000.00,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 2,
      "name": "iPhone 15 Pro Max",
      "in-stock": false,
      "price": 0,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 3,
      "name": "Asus VivoBook",
      "in-stock": true,
      "price": 35000.00,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 4,
      "name": "Xiami X",
      "in-stock": true,
      "price": 15999.00,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 5,
      "name": "Samsung S23",
      "in-stock": false,
      "price": 0,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },
    {
      "id": 6,
      "name": "Lenovo X1",
      "in-stock": true,
      "price": 43000.00,
      "photo":
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
    },{
      "id": 78,
      "name": "RGB Gaming Ped",
      "in-stock": false,
      "price": 11000.00,
      "photo": "assets/images/gamepad1.jpg",
    },
    {
      "id": 77,
      "name": "Gaming Ped",
      "in-stock": false,
      "price": 12499,
      "photo": "assets/images/gamepad2.jpg",
    },
    {
      "id": 76,
      "name": "Gaming Ped RGB 2",
      "in-stock": true,
      "price": 8750,
      "photo": "assets/images/gamepad3.jpg",
    },{
      "id": 69,
      "name": "Canon EOS 2000D",
      "in-stock": true,
      "price": 15000.00,
      "photo": "assets/images/foto11.jpg",
    },
    {
      "id": 68,
      "name": "Canon EOS 250D",
      "in-stock": true,
      "price": 22499,
      "photo": "assets/images/foto1.jpg",
    },{
      "id": 66,
      "name": "Gaming Leptop 4090",
      "in-stock": true,
      "price": 40000,
      "photo": "assets/images/leptop1.jpg",
    },{
      "id": 61,
      "name": "Canon EOS 2000D",
      "in-stock": true,
      "price": 15000.00,
      "photo": "assets/images/kasa1.jpg",
    },
    {
      "id": 63,
      "name": "Canon EOS 250D",
      "in-stock": true,
      "price": 22499,
      "photo": "assets/images/kasa2.jpg",
    },
    {
      "id": 62,
      "name": "Egonex Mini",
      "in-stock": false,
      "price": 0,
      "photo": "assets/images/kasa33.jpg",
    },
    {
      "id": 65,
      "name": "Gaming Leptop 3070 ",
      "in-stock": false,
      "price": 25123,
      "photo": "assets/images/leptop2.jpg",
    },
    {
      "id": 64,
      "name": "Gaming Leptop 3090",
      "in-stock": false,
      "price": 23250,
      "photo": "assets/images/leptop3.jpg",
    },
    {
      "id": 67,
      "name": "Egonex Mini",
      "in-stock": false,
      "price": 0,
      "photo": "assets/images/foto3.jpg",
    },{
      "id": 75,
      "name": "KOORUI 165HX",
      "in-stock": false,
      "price": 11000.00,
      "photo": "assets/images/monitor1.jpg",
    },
    {
      "id": 74,
      "name": "Canon 144HZ",
      "in-stock": true,
      "price": 12499,
      "photo": "assets/images/monitor2.png",
    },
    {
      "id": 73,
      "name": "ASUS VYG",
      "in-stock": true,
      "price": 8750,
      "photo": "assets/images/monitor3.jpg",
    },{
      "id": 70,
      "name": "RGB 7.1",
      "in-stock": false,
      "price": 1000,
      "photo": "assets/images/kulaklık1.jpg",
    },
    {
      "id": 71,
      "name": "Colorful ",
      "in-stock": true,
      "price": 2499,
      "photo": "assets/images/kulaklık2.jpg",
    },
    {
      "id": 72,
      "name": "Widely Compatible",
      "in-stock": true,
      "price": 1250,
      "photo": "assets/images/kulaklık3.jpg",
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
