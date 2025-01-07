import 'package:e_commerce_app/features/admin/screens/admin_screen.dart'; // Ensure this import is correct
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/global_variables.dart';
import 'features/admin/screens/add_product_screen.dart';
// import 'features/admin/screens/admin_screen.dart';
// import 'features/home/screens/home_screen.dart'; // Add this line
import 'providers/user_provider.dart';
import 'services/auth_service.dart';
import 'router.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AdminScreen(),
      // home: const HomeScreen(),
      routes: {
        AddProductScreen.routeName: (context) => const AddProductScreen(),
      },
    );
  }
}
