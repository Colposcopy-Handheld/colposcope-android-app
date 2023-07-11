import 'package:flutter/material.dart';
import 'package:zen_colposcope/helper/sizes_helper.dart';

class DiagnosePage extends StatefulWidget {
  const DiagnosePage({super.key});

  @override
  State<DiagnosePage> createState() => _DiagnosePageState();
}

class _DiagnosePageState extends State<DiagnosePage> {
  int vivia = 0;
  bool hidepass = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/serviks.jpg"),
                fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: displayHeight(context) * 1 / 3,
                ),
                Center(
                  child: Container(
                    width: 450,
                    height: 370,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 170,
                          height: 80,
                          child: Image.asset("assets/images/logo.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            'Masukan Diagnosis Dokter :',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          child: TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Tulis disini",
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () => print('terdiagnosis'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Terdiagnosis',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            SizedBox(
                              width: 140,
                              child: ElevatedButton(
                                onPressed: () => print('terdiagnosis'),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Bersih',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 280,
                          child: ElevatedButton(
                            onPressed: () => print('terdiagnosis'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Terdiagnosis',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 85),
              ],
            ),
          ),
        ),
        // Stack(
        //   children: [
        //     Align(
        //       alignment: AlignmentDirectional.topEnd,
        //       child: Container(
        //         width: 1000,
        //         height: 1000,
        //         color: Colors.white,
        //       ),
        //     ),
        //     Positioned(
        //       right: -450,
        //       left: -360,
        //       top: 0,
        //       child: Image.asset("assets/images/bg.jpg"),
        //     ),
        //
        //   ],
        // ),
      ),
    );
  }
}
