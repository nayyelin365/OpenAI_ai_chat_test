import 'dart:convert';

import 'package:ai_chat_flutter/src/constants/constants.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/domain/ai_chat_ai_answer_model.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/domain/ai_chat_user_question_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'open_api_service.g.dart';

final _log = Logger();

class OpenAIService {
  final String apiKey;

  OpenAIService({required this.apiKey});

  Future<AiChatAiAnswerModel> generateResponse(
    List<AiChatUserQuestionModel> messages,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': apiKey,
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
        }),
      );

      _log.i(
        jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': messages,
        }),
      );
      _log.i(response.statusCode.toString());

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        _log.i(jsonEncode(responseBody));

        return AiChatAiAnswerModel.fromJson(
          responseBody as Map<String, dynamic>,
        );
      } else {
        throw Exception('Failed to load response');
      }
    } catch (e) {
      // Handle the exception, e.g., logging or rethrowing a custom exception
      _log.i('Error generating response: $e');
      throw Exception('Failed to generate response');
    }
  }
}

@Riverpod(keepAlive: true)
OpenAIService openApiService(OpenApiServiceRef ref) {
  return OpenAIService(apiKey: apiKey);
}
