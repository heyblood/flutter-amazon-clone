import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/admin/admin_page.dart';
import 'package:amazon_clone/common/auth/screens/auth_screen.dart';
import 'package:amazon_clone/common/auth/services/auth_service.dart';
import 'package:amazon_clone/common/home_page.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVarialbles.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVarialbles.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: user.token.isNotEmpty
          ? user.type == 'user'
              ? const HomePage()
              : const AdminPage()
          : const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    super.initState();
    _authService.getUserData(context: context);
  }
}
