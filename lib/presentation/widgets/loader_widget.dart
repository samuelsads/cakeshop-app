import 'package:flutter/material.dart';

waitingToFinish(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Opacity(
            opacity: 0.85,
            child: AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              content: Align(
                child: Container(
                  width: 80,
                  height: 58,
                  decoration: BoxDecoration(
                      color: const Color(0xff313133).withOpacity(0.85),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Align(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Color(0xffFFF9F5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
}
