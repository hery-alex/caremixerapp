import 'package:caremixer_test/config/route_config/route_config.dart';
import 'package:caremixer_test/config/theme_config/caremixer_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  runApp(CaremixerApp());
}

class CaremixerApp extends StatelessWidget {
  const CaremixerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaremixerApp',
      theme: CaremixerTheme.primaryThemeData,
      initialRoute: '/timeline',
      onGenerateRoute: (settings) => RoutesConfiguration.onGenerateRoute(settings),
    );
  }
}