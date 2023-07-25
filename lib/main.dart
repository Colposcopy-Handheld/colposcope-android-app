import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zen_colposcope/helper/route_helper.dart' as router;
import 'package:camera/camera.dart';
import 'package:riverpod/riverpod.dart';

late List<CameraDescription> _cameras;

Future<void> camInit() async {
  _cameras = await availableCameras();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  camInit();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('masuk main dart');
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(412, 892),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        onGenerateRoute: router.Router.generateRoute,
        initialRoute: '/signupPage',
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // textTheme: GoogleFonts.nunitoTextTheme(
          //   Theme.of(context).textTheme,
          // ),
        ),
        // home: SignUpPage(),i try to let u go so  many time before,
      ),
    );
  }
}
