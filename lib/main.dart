import 'package:alyosr_order/services/local_storage/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'globals/global_providers.dart';
import 'globals/screens.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String userId = LocalStorageHelper.getValue('id');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elyosr Order',
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "EG"),
      ],
      locale: const Locale("ar", "EG"),
      theme: ThemeData(
        fontFamily: 'Cairo',
        // primarySwatch: Colors.blue,
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(const Color(0xff360E54)),
        ),
      ),
      home: userId.isEmpty
          ? const FirstScreen()
          : Consumer(builder: (_, watch, __) {
              return watch(fetchDataProvider(userId)).when(
                data: (data) => OrderForm(
                  signedUserData: data,
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (_, __) => const FirstScreen(),
              );
            }),
    );
  }
}
