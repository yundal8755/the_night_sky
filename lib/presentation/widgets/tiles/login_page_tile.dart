import 'package:everyones_tone/app/config/app_color.dart';
import 'package:everyones_tone/app/config/app_text_style.dart';
import 'package:flutter/material.dart';

class LoginPageTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  const LoginPageTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColor.primaryBlue,
                ),
                Text(title, style: AppTextStyle.bodyLarge()),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColor.neutrals40),
          ],
        ),
      ),
    );
  }
}
