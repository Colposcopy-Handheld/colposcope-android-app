import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_colposcope/ui/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_preview/device_preview.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final purpleColor = Color(0xff6688FF);
  final darkTextColor = Color(0xff1F1A3D);
  final lightTextColor = Color(0xff999999);
  final textFieldColor = Color(0xffF5F6FA);
  final borderColor = Color(0xffD9D9D9);

  final List<Map> pilihanBahasa = [
    {'id': 0, 'bahasa': 'Bahasa Indonesia', 'isSelected': true},
    {'id': 1, 'bahasa': 'English', 'isSelected': false},
  ];

  Widget getTextField({required String hint}) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.transparent, width: 0),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        filled: true,
        fillColor: textFieldColor,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Future<void> _dialogUbahBahasa(BuildContext context) {
    print('dialog');
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Ganti Bahasa',
            style: TextStyle(color: Colors.blue),
          ),
          content: SizedBox(
            width: 250,
            height: 150,
            child: ListView.builder(
              itemCount: pilihanBahasa.length,
              itemBuilder: (BuildContext ctx, index) {
                return Card(
                  key: ValueKey(pilihanBahasa[index]['bahasa']),
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: pilihanBahasa[index]['isSelected'] == true
                      ? Colors.blue
                      : Colors.white,
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        pilihanBahasa[index]['isSelected'] =
                            !pilihanBahasa[index]['isSelected'];
                      });
                    },
                    title: Text(
                      pilihanBahasa[index]['bahasa'],
                      style: TextStyle(
                        color: pilihanBahasa[index]['isSelected'] == true
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 55.r,
        title: SizedBox(
          height: 25.r,
          child: Image.asset(
            'assets/images/logo-bordered.png',
          ),
        ),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Ubah bahasa"),
                  onTap: () => Future.delayed(
                    const Duration(seconds: 0),
                    () => _dialogUbahBahasa(context),
                  ),
                ),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                print("Ubah bahasa");
              } else if (value == 1) {
                print("Riwayat data pemeriksaan");
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Center(
                child: SizedBox(
                  width: 100.w,
                  child: Image.asset(
                    'assets/images/serviks.png',
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text(
                    "Masuk ke Akun",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: darkTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              getTextField(hint: "Email"),
              SizedBox(
                height: 16.h,
              ),
              getTextField(hint: "Email Password"),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(purpleColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 14.h)),
                    textStyle: MaterialStateProperty.all(
                      TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  child: Text("Masuk"),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Belum punya Akun?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push;
                    },
                    child: Text(
                      "Silahkan Mendaftar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
