import 'package:ai_chat_flutter/src/constants/color.dart';
import 'package:flutter/material.dart';

class AiChatTextStyle {
  const AiChatTextStyle._();
  static const aiChatInputBoxFieldStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: AiChatTextSyleColors.hintTextColor,
  );

  static const aiChatUserQuestionTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: AiChatTextSyleColors.userQuestionTextColor,
  );

  static const flutterLogoTextSyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 15,
    color: AppColors.flutterLogoTextColor,
  );

  static const flutterLogoSubTextSyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    color: AppColors.flutterLogoSubTextColor,
  );

  static const aiChatAiAnswerTextStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    color: AiChatTextSyleColors.inPutTextColor,
  );
}
