import 'package:ai_chat_flutter/src/common_widgets/error_message_widget.dart';
import 'package:ai_chat_flutter/src/constants/app_sizes.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/controller/ai_chat_controller.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_body.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_flutter_logo.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_histroy.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/widgets/ai_chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  TextEditingController userUpdateQuestionController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    userUpdateQuestionController.dispose();
  }

  List<Map<String, dynamic>> combinedList = [];
  @override
  Widget build(BuildContext context) {
    final answerValue = ref.watch(aiChatControllerProvider);
    combinedList = ref.watch(aiChatControllerProvider.notifier).getCombinedList;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: ChatHistoryPadding.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (userQuestionsList.isEmpty)
              const AiChatFlutterLogo()
            else
              Expanded(
                child: AiChatHistory(
                  child: answerValue.when(
                    data: (question) => AiChatBody(combinedList: combinedList),
                    error: (e, st) => Center(child: ErrorMessageWidget(e.toString())),
                    loading: () => combinedList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : AiChatBody(combinedList: combinedList),
                  ),
                ),
              ),
            AiChatInputField(
              userUpdateQuestionController: userUpdateQuestionController,
            ),
          ],
        ),
      ),
    );
  }
}
