import 'package:ai_chat_flutter/src/features/ai_chat/application/ai_chat_service.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/domain/ai_chat_ai_answer_model.dart';
import 'package:ai_chat_flutter/src/features/ai_chat/presentation/controller/ai_chat_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';

// Mock service class
class MockAiChatService extends Mock implements AiChatService {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer makeProviderContainer(MockAiChatService mockService) {
    return ProviderContainer(
      overrides: [
        aiChatServiceProvider.overrideWithValue(mockService),
      ],
    );
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<AiChatAiAnswerModel>());
  });

  group('AiChatController', () {
    test('''
      GIVEN AiChatController,
      WHEN initialized,
      THEN its state is AiMessageModel with empty choices list
      ''', () async {
      final mockService = MockAiChatService();
      final container = makeProviderContainer(mockService);
      final controller = container.read(aiChatControllerProvider.notifier);
      final listener = Listener<AsyncValue<AiChatAiAnswerModel>>();

      container.listen(
        aiChatControllerProvider,
        listener.call,
        fireImmediately: true,
      );

      verifyNever(
        () => listener(null, any(that: isA<AsyncLoading<AiChatAiAnswerModel>>())),
      );
      final initialState = await controller.build();
      expect(
        initialState,
        AiChatAiAnswerModel(choices: []),
      );
    });
  });
}
