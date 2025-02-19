import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/admin/screens/admin_screen.dart';
import 'package:e_commerce_app/features/auth/screens/auth_screen.dart';
import 'package:e_commerce_app/features/auth/services/auth_service.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  bool _isLoading = true; // Track whether user data is being loaded

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    authService.getUserData(context);
    setState(() {
      _isLoading = false; // Mark data as loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: _isLoading
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                if (userProvider.user.token.isEmpty) {
                  return const AuthScreen(); // Show login if no token
                } else if (userProvider.user.type == 'admin') {
                  return const AdminScreen(); // Redirect admin to admin screen
                } else {
                  return const BottomBar(); // Redirect user to user page
                }
              },
            ),
    );
  }
}
