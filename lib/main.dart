import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:how_can_i_make/core/theme.dart';
import 'core/firebase_options.dart';
import 'features/auth/ui/home_page.dart';
import 'features/auth/ui/my_profile_page.dart';
import 'core/util.dart';

  void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/Profile',
      builder: (context, state) => const MyProfilePage(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {




    TextTheme textTheme = createTextTheme(context, "Aboreto", "Aboreto");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}

