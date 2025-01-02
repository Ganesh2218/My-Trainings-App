import 'package:flutter/material.dart';

import '../models/training.dart';
import '../providers/training_provider.dart';

class TrainingDetailScreen extends StatelessWidget {
  final Training training;

  TrainingDetailScreen({required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(training.title, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(training.summary), //Display Summary
      ),
    );
  }
}
