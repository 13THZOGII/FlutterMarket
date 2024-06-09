import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../core/localizations.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ClientCubit clientCubit;
  late CartCubit cartCubit;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    cartCubit = context.read<CartCubit>();
  }

  Future<void> _submitForm() async {
    final String enteredEmail = _emailController.text.trim();
    final String enteredPassword = _passwordController.text.trim();
    final String enteredConfirmPassword =
        _confirmPasswordController.text.trim();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (enteredEmail.isEmpty ||
        enteredPassword.isEmpty ||
        enteredConfirmPassword.isEmpty) {
      _showMessage(
          AppLocalizations.of(context).getTranslate("please_fill_fields"));
    } else if (enteredPassword != enteredConfirmPassword) {
      _showMessage(
          AppLocalizations.of(context).getTranslate("passwords_do_not_match"));
    } else if (!enteredEmail.contains('@')) {
      _showMessage(AppLocalizations.of(context).getTranslate("invalid_email"));
    } else if (prefs.containsKey(enteredEmail)) {
      _showMessage(AppLocalizations.of(context).getTranslate("email_taken"));
    } else {
      prefs.setString(enteredEmail, enteredPassword);
      _showMessage(
          AppLocalizations.of(context).getTranslate("succesfulregister"));
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
    }
  }

  void _showMessage(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context).getTranslate("message")),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(AppLocalizations.of(context).getTranslate("ok")),
          ),
        ],
      ),
    );
  }

  void _navigateToLoginScreen() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("register")),
        actions: [
          IconButton(
            onPressed: () {
              if (clientCubit.state.language == "tr") {
                clientCubit.changeLanguage(language: "en");
              } else {
                clientCubit.changeLanguage(language: "tr");
              }
            },
            icon: Icon(Icons.language),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                clientCubit.changeDarkMode(
                    DarkMode: !clientCubit.state.DarkMode);
              });
            },
            icon: clientCubit.state.DarkMode
                ? Icon(Icons.sunny)
                : Icon(Icons.dark_mode),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).getTranslate("email"),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(context).getTranslate("password"),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)
                      .getTranslate("confirm_password"),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(AppLocalizations.of(context)
                    .getTranslate("register_button")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
