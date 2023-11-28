import 'package:cakeshopapp/config/theme/custom_styles.dart';
import 'package:cakeshopapp/presentation/providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.hint,
    required this.leftMargin,
    required this.rightMargin,
    required this.width,
    required this.controller,
    required this.title,
    this.onTap,
    this.maxLines = 1,
    this.enabled = true,
    this.textInput = TextInputType.number,
    super.key,
  });
  final String title;
  final String hint;
  final double leftMargin;
  final double rightMargin;
  final double width;
  final TextEditingController controller;
  final Function()? onTap;
  final TextInputType? textInput;
  final bool enabled;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 4),
                  width: width,
                  child: Text(
                    title,
                    style: CustomStyles.text14W800(context
                        .select((ColorProvider value) => value.textColor)),
                  )),
            Container(
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: TextFormField(
                enabled: enabled,
                controller: controller,
                keyboardType: textInput,
                textAlign: TextAlign.justify,
                maxLines: maxLines,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 10,
                        top: ((maxLines ?? 0) > 1) ? 10 : 0,
                        right: 10),
                    hintText: hint,
                    hintMaxLines: maxLines,
                    hintStyle: const TextStyle(fontSize: 14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
