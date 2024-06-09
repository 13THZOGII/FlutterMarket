import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String camResult = "";
  String locationResult = "";
  String locationAlwaysResult = ""; // Değişiklik burada
  String locationInfo = "";
  bool loading = false;

  controlPermission() async {
    var cameraStatus = await Permission.camera.status;

    switch (cameraStatus) {
      case PermissionStatus.granted:
        setState(() {
          camResult = "Yetki Alınmış.";
        });
        break;
      case PermissionStatus.denied:
        setState(() {
          camResult = "Yetki Reddedilmiş.";
        });
        break;
      case PermissionStatus.restricted:
        setState(() {
          camResult = "Kısıtlanmış Yetki, hiç türlü alamayız.";
        });
        break;
      case PermissionStatus.limited:
        setState(() {
          camResult = "Kısıtlanmış Yetki, kullanıcı kısıtlı yetki seçmiş.";
        });
        break;
      case PermissionStatus.permanentlyDenied:
        setState(() {
          camResult = "Yetki vermesin diye istemiş kullanıcı";
        });
        break;
      case PermissionStatus.provisional:
        setState(() {
          camResult = "Provisional";
        });
        break;
    }

    var locationAlwaysStatus = await Permission.locationAlways.status;

    switch (locationAlwaysStatus) {
      case PermissionStatus.denied:
        setState(() {
          locationResult = "Yetki vermeyi reddetti";
        });
        break;
      case PermissionStatus.granted:
        setState(() {
          locationResult = "Yetki Verildi";
        });
        var cameraPermissionStatus = await Permission.camera.request();

        switch (cameraPermissionStatus) {
          case PermissionStatus.denied:
            setState(() {
              locationAlwaysResult = "Herzaman Konum Erişimi Reddedildi";
            });
            break;
          case PermissionStatus.granted:
            setState(() {
              locationAlwaysResult = "HERZAMAN KONUM ERİŞİMİ " + cameraPermissionStatus.toString();
            });
            break;
          case PermissionStatus.permanentlyDenied:
            setState(() {
              locationAlwaysResult = "HERZAMAN KONUM ERİŞİMİ" + cameraPermissionStatus.toString();
            });
            break;
          case PermissionStatus.restricted:
            setState(() {
              locationAlwaysResult = "HERZAMAN KONUM ERİŞİMİ" + cameraPermissionStatus.toString();
            });
            break;
          case PermissionStatus.limited:
            setState(() {
              locationAlwaysResult = "HERZAMAN KONUM ERİŞİMİ " + cameraPermissionStatus.toString();
            });
            break;
          case PermissionStatus.provisional:
            setState(() {
              locationAlwaysResult = "HERZAMAN KONUM ERİŞİMİ" + cameraPermissionStatus.toString();
            });
            break;
        }
        break;
      case PermissionStatus.permanentlyDenied:
        setState(() {
          locationResult = "Herzaman Engellendi.";
        });
        break;
      case PermissionStatus.restricted:
        setState(() {
          locationResult = "Kısıtlanmış ve alınamaz.";
        });
        break;
      case PermissionStatus.limited:
        setState(() {
          locationResult = "Kullanıcı kısıtlanmış yetki.";
        });
        break;
      case PermissionStatus.provisional:
        setState(() {
          locationResult = "Provisional";
        });
        break;
    }
  }

  getLocation() async {
    setState(() {
      loading = true;
    });

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationInfo = "Konum Hizmetleri Ayarlardan Kapalı";
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          locationInfo = "Yetki Verilmiyor";
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        locationInfo = "Yetkiler tamamen kapatıldı.";
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final pos = await Geolocator.getCurrentPosition();

    setState(() {
      locationInfo = '''
        accuracy: ${pos.accuracy}
        longitude: ${pos.longitude}
        latitude: ${pos.latitude}
        speed: ${pos.speed}
        speed Dikkati: ${pos.speedAccuracy}
        veri zamani: ${pos.timestamp}
        ''';
    });

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    controlPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("settings")),
      ),
      body: SizedBox.expand(
        child: ListView(
          children: [
            ExpansionTile(
              title: Text(
                  AppLocalizations.of(context).getTranslate("camera_perm")),
              children: [
                Text(camResult),
                Gap(20),
                ElevatedButton(
                  onPressed: () async {
                    await Permission.camera.request();
                  },
                  child: Text(AppLocalizations.of(context).getTranslate("req")),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                  AppLocalizations.of(context).getTranslate("location_perm")),
              children: [
                Text(locationResult),
                Divider(),
                Text(AppLocalizations.of(context).getTranslate("stat")),
                Text(locationAlwaysResult),
              ],
            ),
            ExpansionTile(
              title: Text(
                  AppLocalizations.of(context).getTranslate("location_info")),
              children: [
                IconButton(
                  onPressed: getLocation,
                  icon: const Icon(Icons.location_on),
                ),
                const Divider(),
                Text(locationInfo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
