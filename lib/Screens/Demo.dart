import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.access_alarm_outlined),
        title: const Text('Demo'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.abc_outlined))
        ],
        flexibleSpace: SafeArea(
          top: true,
          bottom: true,
          left: true,
          minimum: const EdgeInsets.all(10),
          child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              child: const Text('flutter')),
        ),
      ),
     
    );
  }
}
