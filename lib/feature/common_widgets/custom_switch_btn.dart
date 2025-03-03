import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';

class ToggleSwitchBtn extends StatefulWidget {
  final bool isToggled;
  final void Function(bool toggle) onToggled;

  const ToggleSwitchBtn(
      {super.key, required this.isToggled, required this.onToggled});

  @override
  State<ToggleSwitchBtn> createState() => _ToggleSwitchBtnState();
}

class _ToggleSwitchBtnState extends State<ToggleSwitchBtn> {
  double size = 20;
  double innerPadding = 0;

  @override
  void initState() {
    innerPadding = size / 10;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onToggled(!widget.isToggled),
      onPanEnd: (b) => widget.onToggled(!widget.isToggled),
      child: AnimatedContainer(
        height: size,
        width: size * 2,
        padding: EdgeInsets.all(innerPadding),
        alignment:
            widget.isToggled ? Alignment.centerRight : Alignment.centerLeft,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.isToggled ? AppColor.btnColor : AppColor.greyD4D4D4,
        ),
        child: Container(
          width: size - innerPadding * 2,
          height: size - innerPadding * 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColor.whiteFFFFFF,
          ),
        ),
      ),
    );
  }
}
