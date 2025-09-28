import 'package:flutter/material.dart';

import '../core/utils/size_utils.dart';

class CustomIconButton extends StatefulWidget {
  Widget child;
  Function onTap;
  Color? backgroundColor;
  final padding;

  CustomIconButton({
    Key? key,
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return  ClipOval(
      child: Material(
        color: widget.backgroundColor ?? Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            padding: widget.padding ?? getPadding(all: 8),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
