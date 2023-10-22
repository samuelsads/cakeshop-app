import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxdecorationCustom {
  static BoxDecoration customBoxdecoration(BuildContext context) {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: context
                .select((ColorProvider value) => value.backgroundColor)));
  }
}
