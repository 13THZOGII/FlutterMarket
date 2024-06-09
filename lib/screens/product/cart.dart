import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/cart/cart_cubit.dart';
import 'package:flutter_application_2/bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/localizations.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late ProductsCubit productsCubit;
  late CartCubit cartCubit;
  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("cart")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () => GoRouter.of(context).push("/favorites"),
              icon: Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        return SizedBox.expand(
          child: ListView.builder(
            itemCount: state.sepet.length,
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(14),
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.network(
                        state.sepet[index]["photo"].toString(),
                        height: 90,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    state.sepet[index]["name"].toString(),
                                    textAlign: TextAlign.end,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    state.sepet[index]["count"].toString() +
                                        "x",
                                    textAlign: TextAlign.end,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (productsCubit.isFavorite(
                                    state.sepet[index]["id"] as int)) {
                                  productsCubit.removeFromFavorites(
                                      state.sepet[index]["id"] as int);
                                } else {
                                  productsCubit
                                      .addToFavorites(state.sepet[index]);
                                }
                                setState(() {}); 
                              },
                              icon: Icon(
                                productsCubit.isFavorite(
                                        state.sepet[index]["id"] as int)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: productsCubit.isFavorite(
                                        state.sepet[index]["id"] as int)
                                    ? Colors.red
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (state.sepet[index]["in-stock"] as bool)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_box),
                            Text(AppLocalizations.of(context)
                                .getTranslate("in-stock")),
                          ],
                        ),
                        Text(state.sepet[index]["price"].toString() + " TL"),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Icon(Icons.error),
                        Text(
                          AppLocalizations.of(context)
                              .getTranslate("not-avaliable"),
                        ),
                      ],
                    ),
                  const Divider(),
                ],
              ),
            ),
          ),
        );
      }),
      floatingActionButton: Padding(
        padding:
            const EdgeInsets.only(right: 20, bottom: 70), 
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange, 
          onPressed: () {
            GoRouter.of(context).push("/payment");
          },
          icon: Icon(Icons.payment),
          label: Text("Ödeme"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
