import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/blocs/cubit/home_cubit.dart';

import 'package:weather_app/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 109,
            fontWeight: FontWeight.w300,
          ),
          titleMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      title: "Application",
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => HomeCubit()..getLocation(),
        child: const HomePage(),
      ),
    );
  }
}
