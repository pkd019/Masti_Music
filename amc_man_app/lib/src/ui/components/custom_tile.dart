import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  const CustomTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.trailing,
    required this.subTitle,
    required this.onTap,
  });

  final Widget trailing;
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: Text(subTitle),
      trailing: trailing,
    );
  }
}
