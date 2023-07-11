import 'package:flutter/material.dart';
import 'package:zen_colposcope/ui/profile_page.dart';
import 'package:zen_colposcope/ui/signup_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color color = Color.fromARGB(121, 118, 23, 250);

  Future<void> _aboutDialog(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          title: const Text('Tentang Aplikasi',
              style: TextStyle(color: Color.fromARGB(255, 101, 73, 225))),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Mata Elang A1 by ZENMED+',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Text(
                  'Aplikasi ini didesain khusus untuk menampilkan data pemeriksaan serviks, dari Handheld Colposcope yang diproduksi oleh ZENMED+ .',
                ),
                SizedBox(height: 10),
                Text(
                  'Alat ini memungkinkan pengguna untuk melakukan eksiminasi serviks, vulva, dan vagina dengan bantuan kamera digital, sehingga pengguna dapat mengambil, menyimpan, dan mengolah gambar ataupun video dari proses eksiminasi.',
                ),
                SizedBox(height: 20),
                Text('Versi aplikasi 1.0.1'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Oke'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showBottomSettings(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: new Icon(Icons.menu_book_rounded),
              title: new Text('Petunjuk Penggunaan'),
              onTap: () {},
            ),
            ListTile(
              leading: new Icon(Icons.info_outline),
              title: new Text('Tentang'),
              onTap: () {
                _aboutDialog(context);
              },
            ),
            ListTile(
              leading: new Icon(Icons.logout),
              title: new Text('Log out'),
              onTap: () {
                showLogoutConfirmation(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showLogoutConfirmation(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel log out
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                ); // Confirm log out
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(Icons.home_outlined),
            color: color,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_pin),
            color: color,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
          ),
          IconButton(
            color: color,
            icon: Icon(Icons.settings),
            onPressed: () {
              showBottomSettings(context);
            },
          ),
        ],
      ),
    );
  }
}
