import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user.dart';
import '../../../../core/services/firebase_auth_service.dart';
import '../widgets/question_bank_list_widget.dart';

class QuestionBankScreen extends ConsumerWidget {
  const QuestionBankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const Scaffold(body: Center(child: Text('User not found')));
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Question Bank')),
          body: const QuestionBankListWidget(),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              const Text('Error loading user data'),
              const SizedBox(height: 8),
              Text(error.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(authStateProvider);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
