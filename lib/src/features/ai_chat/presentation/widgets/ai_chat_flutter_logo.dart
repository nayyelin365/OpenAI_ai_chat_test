import 'package:ai_chat_flutter/gen/assets.gen.dart';
import 'package:ai_chat_flutter/src/constants/ai_chat_text_style.dart';
import 'package:ai_chat_flutter/src/constants/app_sizes.dart';
import 'package:ai_chat_flutter/src/localization/app_localization_context.dart';
import 'package:flutter/material.dart';

class AiChatFlutterLogo extends StatelessWidget {
  const AiChatFlutterLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.p100),
              child: Image.asset(
                Assets.images.fluttera.path,
                width: Sizes.p100,
                height: Sizes.p100,
                fit: BoxFit.cover,
              ),
            ),
            gapH12,
            Text(context.loc.flutterSeniorDeveloper,
                style: AiChatTextStyle.flutterLogoTextSyle),
            gapH6,
            Text(
              context.loc.byDialogplus,
              style: AiChatTextStyle.flutterLogoSubTextSyle,
            ),
          ],
        ),
      ),
    );
  }
}
