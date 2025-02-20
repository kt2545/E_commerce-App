import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/features/account/widgets/below_app_bar.dart';
import 'package:e_commerce_app/features/account/widgets/top_buttons.dart';
import 'package:e_commerce_app/features/account/widgets/orders.dart'; // Ensure this import is correct
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.notifications_outlined),
              ),
              Icon(
                Icons.search,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
