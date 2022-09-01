import 'package:flutter/material.dart';

class RightKeyTool {
  static Future showRightKeyMeun(
      BuildContext context, double dx, double dy, List<String> list,
      {double itemW = 130, double itemH = 30, double padding = 8}) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;

    double menuH = itemH * list.length + padding * 2;

    Size size = Size(itemW, menuH);

    double endL = sw - dx >= itemW ? dx : dx - size.width;
    double endT = sh - dy >= menuH ? dy : dy - size.height;

    return showGeneralDialog(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(120, 130, 161, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 0))
                  ]),
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Column(
                      children: list
                          .map((e) => Container(
                              alignment: Alignment.centerLeft,
                              height: 30,
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    e,
                                    style: const TextStyle(fontSize: 12),
                                  ))))
                          .toList())),
            ),
          );
        },
        transitionBuilder: (context, anmi1, anmi2, child) {
          RelativeRect beginRelativeRect = RelativeRect.fromSize(
              Rect.fromLTWH(dx, dy, 1, 1), MediaQuery.of(context).size);

          RelativeRect endRelativeRect = RelativeRect.fromSize(
              Rect.fromLTWH(endL, endT, itemW, menuH),
              MediaQuery.of(context).size);
          RelativeRectTween relativeRectTween =
              RelativeRectTween(begin: beginRelativeRect, end: endRelativeRect);

          CurvedAnimation curvedAnimation =
              CurvedAnimation(parent: anmi1, curve: Curves.ease);

          return Stack(
            children: [
              PositionedTransition(
                  rect: relativeRectTween.animate(curvedAnimation),
                  child: child)
            ],
          );
        });
  }
}
