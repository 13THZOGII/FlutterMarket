import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/client/client_cubit.dart';
import '../../core/localizations.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  late ClientCubit clientCubit;
  late CartCubit cartCubit;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscureText = true;
  bool _isLoginSelected = true;
  bool _isPasswordError = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    cartCubit = context.read<CartCubit>();
  }

  Future<void> _submitForm() async {
    final String enteredEmail = _emailController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    if (_isLoginSelected) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: enteredEmail,
          password: enteredPassword,
        );
        User? user = userCredential.user;
        print('Firebase kullanıcı giriş yapıldı: ${user!.uid}');
        _showMessage(AppLocalizations.of(context).getTranslate("succesful_login"));
        // Eposta bilgisi ile home ekranına geçiş
        GoRouter.of(context).go('/home', extra: {'email': enteredEmail});
      } catch (e) {
        print('Firebase kullanıcı giriş yapılamadı: $e');
        _showMessage(AppLocalizations.of(context).getTranslate("login_failed"));
      }
    } else {
      final String enteredConfirmPassword = _confirmPasswordController.text.trim();

      if (enteredEmail.isEmpty || enteredPassword.isEmpty || enteredConfirmPassword.isEmpty) {
        _showMessage(AppLocalizations.of(context).getTranslate("please_fill_fields"));
      } else if (enteredPassword.length < 6 || enteredConfirmPassword.length < 6) {
        setState(() {
          _isPasswordError = true;
        });
      } else if (enteredPassword != enteredConfirmPassword) {
        _showMessage(AppLocalizations.of(context).getTranslate("passwords_do_not_match"));
      } else if (!enteredEmail.contains('@')) {
        _showMessage(AppLocalizations.of(context).getTranslate("invalid_email"));
      } else {
        try {
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: enteredEmail,
            password: enteredPassword,
          );
          User? user = userCredential.user;
          print('Firebase kullanıcı oluşturuldu: ${user!.uid}');
          _showMessage(AppLocalizations.of(context).getTranslate("successfulregister"));
          if (await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(AppLocalizations.of(context).getTranslate("message")),
              content: Text(AppLocalizations.of(context).getTranslate("successfulregister")),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(AppLocalizations.of(context).getTranslate("ok")),
                ),
              ],
            ),
          ) ??
          false) {
            _emailController.clear();
            _passwordController.clear();
            _confirmPasswordController.clear();
            setState(() {
              _isLoginSelected = true;
            });
          }
        } catch (e) {
          print('Firebase kullanıcı oluşturulamadı: $e');
          _showMessage(AppLocalizations.of(context).getTranslate("registration_failed"));
        }
      }
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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _navigateToLoginScreen() {
    setState(() {
      _isLoginSelected = true;
    });
  }

  void _navigateToRegisterScreen() {
    setState(() {
      _isLoginSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          _isLoginSelected
              ? AppLocalizations.of(context).getTranslate("login")
              : AppLocalizations.of(context).getTranslate("register"),
        ),
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
                clientCubit.changeDarkMode(DarkMode: !clientCubit.state.DarkMode);
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButton(
                      onPressed: _navigateToLoginScreen,
                      child: Text(
                        AppLocalizations.of(context).getTranslate("login"),
                        style: TextStyle(
                          color:
                          _isLoginSelected ? Colors.orange : Colors.purple,
                          fontWeight: _isLoginSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButton(
                      onPressed: _navigateToRegisterScreen,
                      child: Text(
                        AppLocalizations.of(context).getTranslate("register"),
                        style: TextStyle(
                          color:
                          !_isLoginSelected ? Colors.orange : Colors.purple,
                          fontWeight: !_isLoginSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
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
                  suffixIcon: IconButton(
                    onPressed: _togglePasswordVisibility,
                    icon: _obscureText
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
                obscureText: _obscureText,
              ),
              if (!_isLoginSelected) ...[
                SizedBox(height: 20),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)
                        .getTranslate("confirm_password"),
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: _obscureText
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                    ),
                  ),
                  obscureText: _obscureText,
                ),
                SizedBox(height: 8),
                if (_isPasswordError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .getTranslate("password_length_warning"),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  _isLoginSelected
                      ? AppLocalizations.of(context).getTranslate("login")
                      : AppLocalizations.of(context).getTranslate("register"),
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppLocalizations.of(context)
                        .getTranslate("forgot_password"),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
