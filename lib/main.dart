import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychoice/res/constants/theme.dart';
import 'package:mychoice/utils/routes/route_name.dart';
import 'package:mychoice/utils/routes/routes.dart';
import 'package:mychoice/viewmodel/addingmenspackages/Cartprovider.dart';
import 'package:mychoice/viewmodel/bookingscreenmodels/bookingscreen_provider.dart';
import 'package:mychoice/viewmodel/bottomview_model/bottomview_provider.dart';
import 'package:mychoice/viewmodel/control_pest_control_view/contro_pest_provider.dart';
import 'package:mychoice/viewmodel/homescreenview_model/homescreenview_provider.dart';
import 'package:mychoice/viewmodel/location_view/location_provider.dart';
import 'package:mychoice/viewmodel/theme_view/theme_view_model.dart';
import 'package:mychoice/viewmodel/timesehedules/timesehdule_view_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final TextTheme textTheme = GoogleFonts.poppinsTextTheme();
  final materiltheme = MaterialTheme(TextTheme());
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
        ChangeNotifierProvider(create: (_) => BottomnavViewModel()),
        ChangeNotifierProvider(create: (_) => HomescreenviewProvider()),
        ChangeNotifierProvider(create: (_) => TimeScheduleViewProvider()),
        ChangeNotifierProvider(create: (_) => ControPestProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(411.42857142857144, 867.4285714285714),
        minTextAdapt: true,
        splitScreenMode: true,
        child: Consumer<ThemeViewModel>(
          builder: (context, themeModel, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              debugShowMaterialGrid: false,
              color: Colors.white,
              title: 'Urban Experts',
              theme: materiltheme.light().copyWith(textTheme: textTheme),
              darkTheme: materiltheme.dark().copyWith(textTheme: textTheme),
              themeMode:
                  themeModel.issystemprefs
                      ? ThemeMode.system
                      : themeModel.isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
              initialRoute: RouteName.onboardingscreen,
              onGenerateRoute: Routes.generateRoute,
            );
          },
        ),
      ),
    );
  }
}
