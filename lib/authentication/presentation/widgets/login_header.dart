import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turbo/app/utils/global/global_vars.dart';

import '../../../app/utils/theme/style.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          turboIconLogIn,
          height: 60,
          width: 60,
          colorFilter: const ColorFilter.mode(Styles.turboRed, BlendMode.srcIn),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(loginHeaderText, style: Styles.textLabelLarge),
        ),
      ],
    );
  }
}
