// import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
// import 'package:e_commerce_app/features/admin/screens/admin_screen.dart';
import 'package:e_commerce_app/router.dart';
// import 'package:e_commerce_app/screens/auth_screen.dart';
import 'package:e_commerce_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/features/admin/screens/add_product_screen.dart';

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
      // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
      //     ? const BottomBar()
      //     : const AuthScreen(),
      home: const AddProductScreen(),
    );
  }
}
