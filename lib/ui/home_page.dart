// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_colposcope/ui/bottom_nav_bar.dart';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double height = 30;
  Color color = const Color(0XFF7AC0FF);
  Color color2 = const Color(0XFF96B1FD);
  Color bgColor = const Color(0XFF1752FE);

  Widget buttonFunc(
    context,
    String title,
    IconData ikon,
    String route,
  ) {
    return SizedBox(
      height: 140.r,
      width: 140.r,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, route),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF7165D6)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0.r),
            ),
          ),
        ),
        child: Container(
          width: 180.r,
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/bg-container-atas.png'),
              fit: BoxFit.cover,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromARGB(100, 88, 97, 226),
                blurRadius: 20.0,
                spreadRadius: 5,
                offset: Offset(15, 15),
              ),
            ],
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Icon(
                  ikon,
                  size: 65.sp,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('masuk home page');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade300,
        elevation: 0,
        toolbarHeight: 85.r,
        title: SizedBox(
          height: 30.r,
          child: Image.asset(
            'assets/images/logo-bordered.png',
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Image.asset(
              'assets/images/serviks.png',
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Container(
                width: 340.r,
                height: 200.r,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bg-container-atas.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromARGB(100, 88, 97, 226),
                      blurRadius: 20.0,
                      spreadRadius: 5,
                      offset: Offset(15, 15),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Container(
                        height: 200.r,
                        width: (200 * 3 / 4).r,
                        // height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(20.r), // radius of 10
                            color: Colors.grey[100] // green as background color
                            ),
                        child: Image.asset('assets/images/Dokter1.png'),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0.r),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Dr. Cha Young Sp.Og",
                                style: GoogleFonts.notoSerif(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.r),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 5.r),
                                Expanded(
                                  child: Text(
                                    'ZENMED Medical',
                                    style: GoogleFonts.notoSerif(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Expanded(flex: 8, child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonFunc(
                  context,
                  'Pasien',
                  Icons.person,
                  '/dataPemeriksaan',
                ),
                SizedBox(width: 15.r),
                buttonFunc(
                  context,
                  'Riwayat Data',
                  Icons.list_alt,
                  '/riwayatData',
                ),
              ],
            ),
            SizedBox(height: 15.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonFunc(
                  context,
                  'Janji Temu',
                  Icons.calendar_month_sharp,
                  '/janjiTemu',
                ),
                SizedBox(width: 15.r),
                buttonFunc(
                  context,
                  'Camera',
                  Icons.camera_alt_rounded,
                  '/',
                ),
              ],
            ),
            const Expanded(flex: 10, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
//sign in log in spalshscreen!!!!
//malam ini insyaALLAH!!!!
//HEHHEHE!!!!

