import 'package:ai_chat_flutter/src/constants/ai_chat_text_style.dart';
import 'package:ai_chat_flutter/src/constants/app_sizes.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_ai_icon.dart';
import 'package:flutter/material.dart';

class AiChatAiAnswer extends StatelessWidget {
  final String answer;
  const AiChatAiAnswer({super.key, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AiChatAiIcon(),
          gapW16,
          SizedBox(
            width: MediaQuery.sizeOf(context).width * (2 / 3),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SelectableText(
                answer,
                style: AiChatTextStyle.aiChatAiAnswerTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
