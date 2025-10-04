import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/practice_session_api_service.dart';
import '../../data/models/practice_session.dart';

/// Provider for practice session API service
final practiceSessionApiServiceProvider = Provider<PracticeSessionApiService>((
  ref,
) {
  return ref.watch(PracticeSessionApiService.provider);
});

/// State for current active practice session
final currentPracticeSessionProvider =
    StateNotifierProvider<
      CurrentPracticeSessionNotifier,
      AsyncValue<PracticeSessionResponse?>
    >((ref) {
      final apiService = ref.watch(practiceSessionApiServiceProvider);
      return CurrentPracticeSessionNotifier(apiService);
    });

class CurrentPracticeSessionNotifier
    extends StateNotifier<AsyncValue<PracticeSessionResponse?>> {
  final PracticeSessionApiService _apiService;

  CurrentPracticeSessionNotifier(this._apiService)
    : super(const AsyncValue.data(null));

  /// Create a new practice session
  Future<void> createSession({
    required PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  }) async {
    state = const AsyncValue.loading();

    try {
      final sessionId = await _apiService.createSession(
        filterCriteria: filterCriteria,
        settings: settings,
      );

      // Fetch the created session
      final session = await _apiService.getSession(sessionId);
      state = AsyncValue.data(session);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Load an existing practice session
  Future<void> loadSession(String sessionId) async {
    state = const AsyncValue.loading();

    try {
      final session = await _apiService.getSession(sessionId);
      state = AsyncValue.data(session);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Update session progress
  Future<void> updateProgress({
    required int questionIndex,
    required int timeSpent,
  }) async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      await _apiService.updateSessionProgress(
        sessionId: currentSession.id,
        questionIndex: questionIndex,
        timeSpent: timeSpent,
      );

      // Reload session to get updated data
      await loadSession(currentSession.id);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Record an answer attempt
  Future<void> recordAttempt({
    required String questionId,
    required List<String> selectedAnswers,
    required int timeSpent,
    int attemptNumber = 1,
    bool explanationShown = false,
    bool hintUsed = false,
    String? notes,
  }) async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      await _apiService.recordAttempt(
        sessionId: currentSession.id,
        questionId: questionId,
        selectedAnswers: selectedAnswers,
        timeSpent: timeSpent,
        attemptNumber: attemptNumber,
        explanationShown: explanationShown,
        hintUsed: hintUsed,
        notes: notes,
      );

      // Reload session to get updated statistics
      await loadSession(currentSession.id);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Complete the current session
  Future<void> completeSession() async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      await _apiService.completeSession(currentSession.id);
      await loadSession(currentSession.id);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Pause the current session
  Future<void> pauseSession() async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      await _apiService.pauseSession(currentSession.id);
      await loadSession(currentSession.id);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Resume the current session
  Future<void> resumeSession() async {
    final currentSession = state.value;
    if (currentSession == null) return;

    try {
      await _apiService.resumeSession(currentSession.id);
      await loadSession(currentSession.id);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Clear current session
  void clearSession() {
    state = const AsyncValue.data(null);
  }
}

/// Provider for user's practice sessions list
final userPracticeSessionsProvider =
    StateNotifierProvider<
      UserPracticeSessionsNotifier,
      AsyncValue<List<PracticeSessionSummary>>
    >((ref) {
      final apiService = ref.watch(practiceSessionApiServiceProvider);
      return UserPracticeSessionsNotifier(apiService);
    });

class UserPracticeSessionsNotifier
    extends StateNotifier<AsyncValue<List<PracticeSessionSummary>>> {
  final PracticeSessionApiService _apiService;

  UserPracticeSessionsNotifier(this._apiService)
    : super(const AsyncValue.data([]));

  /// Load user's practice sessions
  Future<void> loadSessions({String? status, int limit = 20}) async {
    state = const AsyncValue.loading();

    try {
      final sessions = await _apiService.getUserSessions(
        status: status,
        limit: limit,
      );
      state = AsyncValue.data(sessions);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Refresh sessions list
  Future<void> refresh() async {
    await loadSessions();
  }
}

/// Provider for practice session statistics
final practiceSessionStatisticsProvider =
    FutureProvider.family<PracticeSessionStatistics?, String>((
      ref,
      sessionId,
    ) async {
      final apiService = ref.watch(practiceSessionApiServiceProvider);
      return await apiService.getSessionStatistics(sessionId);
    });

/// Provider for practice session attempts
final practiceSessionAttemptsProvider =
    FutureProvider.family<List<PracticeSessionAttempt>, String>((
      ref,
      sessionId,
    ) async {
      final apiService = ref.watch(practiceSessionApiServiceProvider);
      return await apiService.getSessionAttempts(sessionId);
    });

/// Provider for practice session creation state
final practiceSessionCreationProvider =
    StateNotifierProvider<PracticeSessionCreationNotifier, AsyncValue<String?>>(
      (ref) {
        final apiService = ref.watch(practiceSessionApiServiceProvider);
        return PracticeSessionCreationNotifier(apiService);
      },
    );

class PracticeSessionCreationNotifier
    extends StateNotifier<AsyncValue<String?>> {
  final PracticeSessionApiService _apiService;

  PracticeSessionCreationNotifier(this._apiService)
    : super(const AsyncValue.data(null));

  /// Create a new practice session and return session ID
  Future<void> createSession({
    required PracticeSessionFilter filterCriteria,
    PracticeSessionSettings? settings,
  }) async {
    state = const AsyncValue.loading();

    try {
      final sessionId = await _apiService.createSession(
        filterCriteria: filterCriteria,
        settings: settings,
      );
      state = AsyncValue.data(sessionId);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Reset creation state
  void reset() {
    state = const AsyncValue.data(null);
  }
}
