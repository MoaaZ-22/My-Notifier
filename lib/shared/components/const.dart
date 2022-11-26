import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

DateTime? startTime = DateTime.now();

String? category = 'Development';

String? lang = 'en';

double? defaultSize = 4.h;

void pushReplacementNavigate(context, dynamic widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
