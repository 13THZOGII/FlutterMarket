import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String email;

  const ProfileScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _profileImageBytes;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _isEnglish = true;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
    _emailController.text = widget.email;
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      final String? imagePath = prefs.getString('profileImage');
      if (imagePath != null) {
        _profileImageBytes = base64Decode(imagePath);
      }
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      FilePickerResult? pickedFile =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (pickedFile != null) {
        setState(() {
          _profileImageBytes = pickedFile.files.first.bytes;
          _cacheImage(_profileImageBytes!);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.isEmpty) {
      _showValidationErrorDialog();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _nameController.text);
    prefs.setString('email', _emailController.text);
    if (_profileImageBytes != null) {
      prefs.setString('profileImage', base64Encode(_profileImageBytes!));
    }
    prefs.setBool('isDarkMode', _isDarkMode);

    Navigator.pop(context, true);
  }

  Future<void> _cacheImage(Uint8List imageBytes) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('profileImage', base64Encode(imageBytes));
  }

  void _showValidationErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_isEnglish ? 'Validation Error' : 'Doğrulama Hatası'),
          content: Text(_isEnglish
              ? 'Please enter your name before saving.'
              : 'Kaydetmeden önce lütfen adınızı girin.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _toggleLanguage() {
    setState(() {
      _isEnglish = !_isEnglish;
    });
  }

  void _toggleThemeMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Hide the debug banner
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_isEnglish ? 'Profile Page' : 'Profil Sayfası'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.language),
              onPressed: _toggleLanguage,
            ),
            IconButton(
              icon: Icon(_isDarkMode ? Icons.brightness_7 : Icons.brightness_2),
              onPressed: _toggleThemeMode,
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _profileImageBytes != null
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: MemoryImage(_profileImageBytes!),
                        )
                      : CircleAvatar(
                          radius: 50,
                        ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text(
                        _isEnglish ? 'Change Picture' : 'Resmi Değiştir'),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: _isEnglish ? 'Full Name' : 'Tam Adı',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: Text(_isEnglish ? 'Save' : 'Kaydet'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
