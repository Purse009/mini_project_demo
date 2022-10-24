import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samawat_health/before_dashbord/login_page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      builder: ((context, child) => MaterialApp(
            title: 'SamawatHealth Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const LoginPage(),
          )),
    );
  }
}
