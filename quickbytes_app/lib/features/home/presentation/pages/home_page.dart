import 'package:flutter/material.dart';
import 'package:quickbytes_app/core/navigation/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('Go to relevancy page'),
              onPressed: () => RelevancyPageRoute().go(context),
            )
          ],
        ),
      ),
    );
  }
}
