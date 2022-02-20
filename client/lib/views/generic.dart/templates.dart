import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kahootlike_game/utils/themes.dart';
import 'package:kahootlike_game/views/generic.dart/base.dart';

class ResultPopup extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? message;
  final String okText;
  final String? cancelText;
  final Function? okPressed;
  final Function? cancelPressed;
  final double? top;

  const ResultPopup(
      {Key? key,
      required this.icon,
      required this.title,
      required this.okText,
      this.message,
      this.cancelText,
      this.okPressed,
      this.cancelPressed,
      this.top})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Material(
          color: Colors.transparent,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, this.top ?? 0, 20, 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                  title.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: AppTheme.bodyFontsize15,
                              color: AppTheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  message == null || message!.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            message ?? "",
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        cancelText == null || cancelText!.isEmpty
                            ? SizedBox(height: 0)
                            : Expanded(
                                child: ActivesecondaryTextButton(
                                    cancelText ?? "", () {
                                Get.back();
                                if (cancelPressed != null) {
                                  cancelPressed!.call();
                                }
                              })),
                        SizedBox(
                            width: cancelText == null || cancelText!.isEmpty
                                ? 0
                                : 16),
                        Expanded(
                            child: ActiveTextButton(okText, () {
                          Get.back();
                          if (okPressed != null) {
                            okPressed!.call();
                          }
                        }))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class ActiveTextButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final double fontSize;
  final double height;

  const ActiveTextButton(this.text, this.onPressed,
      {Key? key, this.fontSize = AppTheme.bodyFontsize15, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextButton(
        onPressed: () => onPressed!.call(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => AppTheme.primary),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivesecondaryTextButton extends StatelessWidget {
  final String text;
  final Function? onPressed;
  final double fontSize;
  final double height;

  const ActivesecondaryTextButton(this.text, this.onPressed,
      {Key? key, this.fontSize = AppTheme.bodyFontsize15, this.height = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [CustomBoxShadow()]),
      child: TextButton(
        onPressed: () => onPressed!.call(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => AppTheme.white),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: AppTheme.secondary,
          ),
        ),
      ),
    );
  }
}

class BusyPageIndicator extends StatelessWidget {
  const BusyPageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.primary.withOpacity(.5),
      child: Center(
          child: Container(
              width: 150,
              height: 150,
              child: Image.asset('assets/images/dualBall.gif'))),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  @override
  Color get color => AppTheme.surface3.withOpacity(.5);
  @override
  double get blurRadius => 10;
  @override
  double get spreadRadius => 1;
  @override
  Offset get offset => Offset(-5, 5);
}

class CustomEntry extends StatelessWidget {
  final String placeHolder;
  final TextEditingController controller;
  final FocusNode focusNode;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final Function? onEditingComplete;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final int? maxLength;
  final bool hasShadow;
  final bool isRequired;
  const CustomEntry(this.placeHolder, this.controller, this.focusNode,
      {Key? key,
      this.fontSize = AppTheme.bodyFontsize15,
      this.fontWeight = FontWeight.w600,
      this.textColor = AppTheme.primary,
      this.onEditingComplete,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.done,
      this.autoFocus = false,
      this.maxLength,
      this.hasShadow = true,
      this.isRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomEntryController entryController =
        Get.put(CustomEntryController(context));
    focusNode.addListener(() => entryController.isPlaceHolderState.value =
        !focusNode.hasFocus && controller.text.isEmpty);
    return Container(
        height: 58,
        decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.surface3, width: 2),
            boxShadow: hasShadow ? [CustomBoxShadow()] : []),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          entryController.isPlaceHolderState.value
              ? Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        placeHolder,
                        style: const TextStyle(
                            fontSize: AppTheme.body2Fontsize18,
                            color: AppTheme.surface3,
                            fontWeight: FontWeight.w700),
                      ),
                      Visibility(
                          visible: isRequired,
                          child: const Text(
                            "*",
                            style: TextStyle(
                                fontSize: AppTheme.captionFontsize11,
                                color: AppTheme.blue,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                )
              : SizedBox.shrink(),
          Center(
            child: TextField(
              autofocus: autoFocus,
              focusNode: focusNode,
              controller: controller,
              autocorrect: false,
              maxLength: maxLength,
              onEditingComplete: () => onEditingComplete,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(horizontal: 15)),
              style: TextStyle(
                  fontSize: fontSize, fontWeight: fontWeight, color: textColor),
            ),
          )
        ]));
  }
}

class CustomEntryController extends BaseGetxController {
  final isPlaceHolderState = true.obs;

  CustomEntryController(BuildContext context) : super(context);
}
