import 'package:ai_chat_flutter/src/constants/ai_chat_text_style.dart';
import 'package:ai_chat_flutter/src/constants/app_sizes.dart';
import 'package:ai_chat_flutter/src/constants/color.dart';
import 'package:flutter/material.dart';

class AiChatUserQuestion extends StatelessWidget {
  final String question;
  const AiChatUserQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: Sizes.p8), // Add some spacing between items
        decoration: BoxDecoration(
          color: AppColors.userSendingMessageColor,
          borderRadius: BorderRadius.circular(Sizes.p20),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Sizes.p18,
            Sizes.p10,
            Sizes.p18,
            Sizes.p10,
          ),
          child: FractionallySizedBox(
            child: SelectableText(
              question,
              style: AiChatTextStyle.aiChatUserQuestionTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
