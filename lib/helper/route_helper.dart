import 'package:flutter/material.dart';
import 'package:zen_colposcope/ui/home_page.dart';
import 'package:zen_colposcope/ui/data_pemeriksaan.dart';
import 'package:zen_colposcope/ui/login_page.dart';
import 'package:zen_colposcope/ui/signup_page.dart';
import 'package:zen_colposcope/ui/profile_page.dart';
import 'package:zen_colposcope/ui/riwayat_data.dart';
import 'package:zen_colposcope/ui/janji_temu.dart';
import 'package:zen_colposcope/ui/diagnose_page.dart';
import 'package:zen_colposcope/ui/change_password.dart';
import 'package:zen_colposcope/ui/camera/camera_page.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/signupPage':
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case '/loginPage':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/dataPemeriksaan':
        return MaterialPageRoute(builder: (_) => const DataPemeriksaanPage());
      case '/profilePage':
        return MaterialPageRoute(builder: (_) => const ProfilPage());
      case '/riwayatData':
        return MaterialPageRoute(builder: (_) => const RiwayatDataPage());
      case '/janjiTemu':
        return MaterialPageRoute(builder: (_) => const JanjiTemu());
      case '/diagnosePage':
        return MaterialPageRoute(builder: (_) => const DiagnosePage());
      case '/changePassword':
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case '/cameraPage':
        return MaterialPageRoute(builder: (_) => const CameraPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}
