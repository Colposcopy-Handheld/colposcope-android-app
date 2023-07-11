import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_colposcope/ui/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';

const List<TabItem> navItems = [
  TabItem(
    icon: Icons.home_outlined,
  ),
  TabItem(
    icon: Icons.person_pin,
  ),
  TabItem(
    icon: Icons.settings,
  ),
];

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  int visit = 1;

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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade300,
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
      bottomNavigationBar: BottomBarFloating(
        iconSize: 22.sp,
        items: navItems,
        color: Colors.blue,
        backgroundColor: Colors.white,
        colorSelected: Colors.blue,
        // backgroundSelected: Colors.blue,
        borderRadius: BorderRadius.circular(0),
        indexSelected: visit,
        onTap: (index) => setState(() {
          visit = index;
          print(visit);
          if (visit == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        }),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text(
                      "Ubah Password",
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                getTextField(hint: "Password Lama"),
                SizedBox(
                  height: 16.h,
                ),
                getTextField(hint: "Password Baru"),
                SizedBox(
                  height: 16.h,
                ),
                getTextField(hint: "konfirmasi Password Baru"),
                SizedBox(
                  height: 16.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
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
                    child: Text("Simpan"),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
