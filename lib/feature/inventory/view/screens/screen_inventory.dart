import 'package:flutter/material.dart';

class ScreenInventory extends StatelessWidget {
  const ScreenInventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("📦 Inventory Screen", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
