import 'package:dicoding_flutter_fudamental/style/colors.dart';
import 'package:dicoding_flutter_fudamental/style/font.dart';
import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  const MenuListTile({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final String menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: mainColor,
      ),
      child: Text(menu, style: text14GreySemiBold.copyWith(color: whiteColor)),
    );
  }
}
