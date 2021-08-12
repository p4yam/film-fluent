import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source.dart';
import 'package:film_fluent/feature/movie_list/data/data_sources/movie_list_remote_data_source_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'core/di/service_locator.dart' as di;
import 'core/utils/app_themes.dart';
import 'feature/home_page_route.dart';


void main() async{
  await di.init();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  await Hive.initFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      title: 'FilmFluent',
      theme: AppThemes.lightTheme,
      home: const HomePageRoute(),
    );
  }
}

