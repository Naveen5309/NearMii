import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';

class ToggleSwitchBtn extends StatefulWidget {
  final void Function(bool isToggled) onToggled;

  const ToggleSwitchBtn({super.key, required this.onToggled});

  @override
  State<ToggleSwitchBtn> createState() => _ToggleSwitchBtnState();
}

class _ToggleSwitchBtnState extends State<ToggleSwitchBtn> {
  bool isToggled = false;
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
      onTap: () {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      onPanEnd: (b) {
        setState(() => isToggled = !isToggled);
        widget.onToggled(isToggled);
      },
      child: AnimatedContainer(
        height: size,
        width: size * 2,
        padding: EdgeInsets.all(innerPadding),
        alignment: isToggled ? Alignment.centerLeft : Alignment.centerRight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isToggled ? AppColor.greyD4D4D4 : AppColor.btnColor,
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
