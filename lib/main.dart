import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/bloc/client/client_cubit.dart';
import 'package:flutter_application_2/core/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/cart/cart_cubit.dart';
import 'bloc/products/products_cubit.dart';
import 'core/localizations.dart';
import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBpbfb95x_Hy6r2L1jCi3Thi_FAFDRlaBY",
            authDomain: "eticaret-cf088.firebaseapp.com",
            projectId: "eticaret-cf088",
            storageBucket: "eticaret-cf088.appspot.com",
            messagingSenderId: "337854515379",
            appId: "1:337854515379:web:75fd79952e0cfd653f48c6"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ClientCubit(
            ClientState(DarkMode: false, language: "en"),
          ),
        ),
        BlocProvider(
          create: (context) => CartCubit(
            CartState(sepet: []),
          ),
        ),
        BlocProvider(
          create: (context) => ProductsCubit(
            ProductsState(favorites: []),
          ),
        )
      ],
      child: BlocBuilder<ClientCubit, ClientState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
          themeMode: state.DarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('tr', 'TR'),
          ],
          locale: Locale(state.language),
        );
      }),
    );
  }
}
