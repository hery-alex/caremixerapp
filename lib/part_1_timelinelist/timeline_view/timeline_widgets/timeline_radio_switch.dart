import 'package:flutter/material.dart';

class TimelineRadioSwitch extends StatelessWidget {
  const TimelineRadioSwitch({
    super.key,
    required this.value,
    this.onTap,
    this.semanticsOverride,
  });

  final bool value;
  final void Function()? onTap;
  final String? semanticsOverride;

  final double size = 34;
  final double outerDiameter = 30;
  final double outerBorderWidth = 1.67;
  final outerCircleBorderRadius = 18.0;

  @override
  Widget build(BuildContext context,) {
    return GestureDetector(
      onTap: onTap,
      child: Semantics(
        label: semanticsOverride ?? (value ? 'On' : 'Off'),
        child: SizedBox(
          width: size,
          height: size,
          child: Container(
            width: outerDiameter,
            height: outerDiameter,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: outerBorderWidth,
                    color: value
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface),
                borderRadius: BorderRadius.circular(outerCircleBorderRadius),
              ),
            ),
            child: value
                ? Center(
                  child: Icon(
                    Icons.check,
                    color:Theme.of(context).colorScheme.onSurface,
                    size:26 ,
                  ),
                ) 
              : Center(
                  child: Icon(
                    Icons.close_rounded,
                    color:Theme.of(context).colorScheme.onSurface,
                    size:26 ,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
