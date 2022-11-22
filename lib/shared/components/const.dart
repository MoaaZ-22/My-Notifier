import 'package:flutter/material.dart';

DateTime? startTime = DateTime.now();

String? category = 'Development';

void pushReplacementNavigate(context, dynamic widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
