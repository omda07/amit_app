import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
IconData suffix = IconBroken.Show;
bool isPassword = true;
