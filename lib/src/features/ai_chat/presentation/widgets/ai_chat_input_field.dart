import 'package:ai_chat_flutter/src/constants/ai_chat_text_style.dart';
import 'package:ai_chat_flutter/src/constants/app_sizes.dart';
import 'package:ai_chat_flutter/src/constants/color.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/domain/ai_chat_user_question_model.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/controller/ai_chat_controller.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_sending_button.dart';
import 'package:ai_chat_flutter/src/localization/app_localization_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiChatInputField extends ConsumerStatefulWidget {
  final TextEditingController userUpdateQuestionController;

  const AiChatInputField({super.key, required this.userUpdateQuestionController});

  @override
  AiChatInputFieldState createState() => AiChatInputFieldState();
}

class AiChatInputFieldState extends ConsumerState<AiChatInputField> {
  bool isTextPresent = false;

  @override
  void initState() {
    super.initState();
    widget.userUpdateQuestionController.addListener(_handleTextChange);
  }

  void _handleTextChange() {
    setState(() {
      isTextPresent = widget.userUpdateQuestionController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.userUpdateQuestionController.removeListener(_handleTextChange);
    super.dispose();
  }

  List<AiChatUserQuestionModel> userQuestionList = [];

  @override
  Widget build(BuildContext context) {
    userQuestionList = ref.watch(aiChatControllerProvider.notifier).userQuestionList;
    return Padding(
      padding: const EdgeInsets.only(right: inPutBoxWidth, left: inPutBoxWidth),
      child: TextFormField(
        style: const TextStyle(color: AiChatTextSyleColors.inPutTextColor),
        textInputAction: TextInputAction.go,
        controller: widget.userUpdateQuestionController,
        onFieldSubmitted: (question) {
          fetchQuestion(question);
        },
        decoration: InputDecoration(
          hintText: context.loc.message_chat_gpt,
          hintStyle: AiChatTextStyle.aiChatInputBoxFieldStyle,
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  fetchQuestion(widget.userUpdateQuestionController.text);
                },
                child: AiChatSendingButton(
                    iconBackgroundColor: isTextPresent
                        ? AppColors.iconBackgroundColorAfterText
                        : AppColors.iconBackgroundColor,
                    arrowUpColor:
                        isTextPresent ? AppColors.arrowUpColorAfterText : AppColors.arrowUpColor),
              )
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.p30),
            borderSide: const BorderSide(
              color: AppColors.inPutBoxColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.p30),
            borderSide: const BorderSide(
              color: AppColors.inPutBoxColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.p30),
            borderSide: const BorderSide(
              color: AppColors.inPutBoxColor,
            ),
          ),
        ),
      ),
    );
  }

  void fetchQuestion(String question) {
    if (isTextPresent) {
      ref
          .read(aiChatControllerProvider.notifier)
          .addUserQuestion(AiChatUserQuestionModel(role: 'user', content: question));
      ref.read(aiChatControllerProvider.notifier).fetchAnswer(userQuestionList);
      widget.userUpdateQuestionController.clear();
    }
  }
}
