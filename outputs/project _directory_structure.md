# EntryTestGuru - Flutter Repository Structure

```
entrytestguru/
├── README.md
├── .gitignore
├── .env.example
├── pubspec.yaml
├── analysis_options.yaml
├── android/
├── ios/
├── web/
├── windows/
├── macos/
├── linux/
│
├── lib/
│   ├── main.dart
│   ├── app.dart
│   │
│   ├── core/
│   │   ├── constants/
│   │   │   ├── app_constants.dart
│   │   │   ├── api_endpoints.dart
│   │   │   ├── exam_types.dart
│   │   │   └── tier_limits.dart
│   │   ├── config/
│   │   │   ├── app_config.dart
│   │   │   ├── firebase_config.dart
│   │   │   └── paddle_config.dart
│   │   ├── network/
│   │   │   ├── api_client.dart
│   │   │   ├── dio_interceptors.dart
│   │   │   ├── network_info.dart
│   │   │   └── api_exceptions.dart
│   │   ├── storage/
│   │   │   ├── hive_service.dart
│   │   │   ├── secure_storage.dart
│   │   │   └── cache_manager.dart
│   │   ├── utils/
│   │   │   ├── device_utils.dart
│   │   │   ├── time_utils.dart
│   │   │   ├── validation_utils.dart
│   │   │   ├── format_utils.dart
│   │   │   └── analytics_utils.dart
│   │   ├── extensions/
│   │   │   ├── string_extensions.dart
│   │   │   ├── datetime_extensions.dart
│   │   │   └── widget_extensions.dart
│   │   └── error/
│   │       ├── failures.dart
│   │       ├── error_handler.dart
│   │       └── app_exceptions.dart
│   │
│   ├── features/
│   │   ├── authentication/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   │   └── auth_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── user_model.dart
│   │   │   │   │   ├── device_model.dart
│   │   │   │   │   └── auth_response_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── user.dart
│   │   │   │   │   └── device.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── login_usecase.dart
│   │   │   │       ├── register_usecase.dart
│   │   │   │       ├── logout_usecase.dart
│   │   │   │       └── manage_devices_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── auth_provider.dart
│   │   │       │   └── device_management_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── welcome_page.dart
│   │   │       │   ├── login_page.dart
│   │   │       │   ├── register_page.dart
│   │   │       │   ├── onboarding_page.dart
│   │   │       │   └── device_management_page.dart
│   │   │       └── widgets/
│   │   │           ├── auth_form.dart
│   │   │           ├── social_login_buttons.dart
│   │   │           ├── device_card.dart
│   │   │           └── upgrade_prompt.dart
│   │   │
│   │   ├── question_bank/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── question_remote_datasource.dart
│   │   │   │   │   └── question_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── question_model.dart
│   │   │   │   │   ├── explanation_model.dart
│   │   │   │   │   └── arde_data_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── question_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── question.dart
│   │   │   │   │   ├── explanation.dart
│   │   │   │   │   └── arde_data.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── question_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_questions_usecase.dart
│   │   │   │       ├── filter_questions_usecase.dart
│   │   │   │       └── get_explanation_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── question_provider.dart
│   │   │       │   └── filter_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── question_browser_page.dart
│   │   │       │   └── question_detail_page.dart
│   │   │       └── widgets/
│   │   │           ├── question_card.dart
│   │   │           ├── filter_panel.dart
│   │   │           ├── arde_indicator.dart
│   │   │           └── explanation_viewer.dart
│   │   │
│   │   ├── practice_mode/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── practice_remote_datasource.dart
│   │   │   │   │   └── practice_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── practice_session_model.dart
│   │   │   │   │   └── question_attempt_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── practice_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── practice_session.dart
│   │   │   │   │   └── question_attempt.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── practice_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── start_practice_session_usecase.dart
│   │   │   │       ├── submit_answer_usecase.dart
│   │   │   │       └── track_timing_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── practice_session_provider.dart
│   │   │       │   └── timer_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── practice_setup_page.dart
│   │   │       │   ├── practice_session_page.dart
│   │   │       │   └── practice_results_page.dart
│   │   │       └── widgets/
│   │   │           ├── question_display.dart
│   │   │           ├── answer_options.dart
│   │   │           ├── practice_timer.dart
│   │   │           ├── attempt_indicator.dart
│   │   │           └── immediate_feedback.dart
│   │   │
│   │   ├── sprint_exams/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── exam_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── sprint_exam_model.dart
│   │   │   │   │   └── exam_config_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── exam_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── sprint_exam.dart
│   │   │   │   │   └── exam_config.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── exam_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── create_sprint_exam_usecase.dart
│   │   │   │       ├── start_exam_usecase.dart
│   │   │   │       └── submit_exam_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── sprint_exam_provider.dart
│   │   │       │   └── exam_timer_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── exam_configuration_page.dart
│   │   │       │   ├── exam_session_page.dart
│   │   │       │   └── exam_results_page.dart
│   │   │       └── widgets/
│   │   │           ├── exam_timer.dart
│   │   │           ├── question_navigator.dart
│   │   │           ├── exam_controls.dart
│   │   │           └── results_dashboard.dart
│   │   │
│   │   ├── analytics/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── analytics_remote_datasource.dart
│   │   │   │   │   └── analytics_local_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── performance_model.dart
│   │   │   │   │   └── analytics_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── analytics_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── performance_data.dart
│   │   │   │   │   └── analytics_insight.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── analytics_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_performance_data_usecase.dart
│   │   │   │       ├── track_interaction_usecase.dart
│   │   │   │       └── generate_insights_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── analytics_provider.dart
│   │   │       │   └── performance_tracking_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── analytics_dashboard_page.dart
│   │   │       │   └── performance_details_page.dart
│   │   │       └── widgets/
│   │   │           ├── performance_charts.dart
│   │   │           ├── insight_cards.dart
│   │   │           ├── trend_graphs.dart
│   │   │           └── export_options.dart
│   │   │
│   │   ├── ai_tutoring/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── ai_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── ai_conversation_model.dart
│   │   │   │   │   └── explanation_request_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── ai_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── ai_conversation.dart
│   │   │   │   │   └── ai_message.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── ai_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── start_ai_chat_usecase.dart
│   │   │   │       ├── send_message_usecase.dart
│   │   │   │       └── get_explanation_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── ai_chat_provider.dart
│   │   │       │   └── explanation_limits_provider.dart
│   │   │       ├── pages/
│   │   │       │   └── ai_chat_page.dart
│   │   │       └── widgets/
│   │   │           ├── chat_interface.dart
│   │   │           ├── message_bubble.dart
│   │   │           ├── typing_indicator.dart
│   │   │           └── usage_meter.dart
│   │   │
│   │   ├── social/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   └── social_remote_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── leaderboard_model.dart
│   │   │   │   │   ├── study_group_model.dart
│   │   │   │   │   └── challenge_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── social_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── leaderboard.dart
│   │   │   │   │   ├── study_group.dart
│   │   │   │   │   └── challenge.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── social_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── get_leaderboard_usecase.dart
│   │   │   │       ├── create_study_group_usecase.dart
│   │   │   │       └── join_challenge_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── leaderboard_provider.dart
│   │   │       │   ├── study_group_provider.dart
│   │   │       │   └── challenge_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── leaderboard_page.dart
│   │   │       │   ├── study_groups_page.dart
│   │   │       │   └── challenges_page.dart
│   │   │       └── widgets/
│   │   │           ├── leaderboard_list.dart
│   │   │           ├── group_card.dart
│   │   │           ├── challenge_card.dart
│   │   │           └── achievement_badge.dart
│   │   │
│   │   ├── subscription/
│   │   │   ├── data/
│   │   │   │   ├── datasources/
│   │   │   │   │   ├── subscription_remote_datasource.dart
│   │   │   │   │   └── paddle_datasource.dart
│   │   │   │   ├── models/
│   │   │   │   │   ├── subscription_model.dart
│   │   │   │   │   └── payment_model.dart
│   │   │   │   └── repositories/
│   │   │   │       └── subscription_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   ├── subscription.dart
│   │   │   │   │   └── payment.dart
│   │   │   │   ├── repositories/
│   │   │   │   │   └── subscription_repository.dart
│   │   │   │   └── usecases/
│   │   │   │       ├── upgrade_subscription_usecase.dart
│   │   │   │       ├── cancel_subscription_usecase.dart
│   │   │   │       └── check_subscription_status_usecase.dart
│   │   │   └── presentation/
│   │   │       ├── providers/
│   │   │       │   ├── subscription_provider.dart
│   │   │       │   └── payment_provider.dart
│   │   │       ├── pages/
│   │   │       │   ├── subscription_plans_page.dart
│   │   │       │   ├── payment_page.dart
│   │   │       │   └── billing_dashboard_page.dart
│   │   │       └── widgets/
│   │   │           ├── plan_card.dart
│   │   │           ├── payment_form.dart
│   │   │           ├── billing_history.dart
│   │   │           └── usage_indicators.dart
│   │   │
│   │   └── settings/
│   │       ├── data/
│   │       │   ├── datasources/
│   │       │   │   └── settings_local_datasource.dart
│   │       │   ├── models/
│   │       │   │   └── user_preferences_model.dart
│   │       │   └── repositories/
│   │       │       └── settings_repository_impl.dart
│   │       ├── domain/
│   │       │   ├── entities/
│   │       │   │   └── user_preferences.dart
│   │       │   ├── repositories/
│   │       │   │   └── settings_repository.dart
│   │       │   └── usecases/
│   │       │       ├── update_preferences_usecase.dart
│   │       │       └── get_preferences_usecase.dart
│   │       └── presentation/
│   │           ├── providers/
│   │           │   └── settings_provider.dart
│   │           ├── pages/
│   │           │   ├── settings_page.dart
│   │           │   ├── profile_page.dart
│   │           │   └── privacy_settings_page.dart
│   │           └── widgets/
│   │               ├── settings_tile.dart
│   │               ├── profile_editor.dart
│   │               └── privacy_controls.dart
│   │
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── common/
│   │   │   │   ├── custom_app_bar.dart
│   │   │   │   ├── custom_button.dart
│   │   │   │   ├── custom_text_field.dart
│   │   │   │   ├── loading_widget.dart
│   │   │   │   ├── error_widget.dart
│   │   │   │   └── empty_state_widget.dart
│   │   │   ├── cards/
│   │   │   │   ├── question_card.dart
│   │   │   │   ├── performance_card.dart
│   │   │   │   └── feature_card.dart
│   │   │   ├── charts/
│   │   │   │   ├── line_chart_widget.dart
│   │   │   │   ├── bar_chart_widget.dart
│   │   │   │   └── pie_chart_widget.dart
│   │   │   ├── dialogs/
│   │   │   │   ├── confirmation_dialog.dart
│   │   │   │   ├── upgrade_dialog.dart
│   │   │   │   └── info_dialog.dart
│   │   │   └── animations/
│   │   │       ├── slide_transition.dart
│   │   │       ├── fade_transition.dart
│   │   │       └── scale_transition.dart
│   │   ├── providers/
│   │   │   ├── app_state_provider.dart
│   │   │   ├── theme_provider.dart
│   │   │   ├── connectivity_provider.dart
│   │   │   └── navigation_provider.dart
│   │   └── models/
│   │       ├── base_model.dart
│   │       ├── api_response.dart
│   │       └── pagination_model.dart
│   │
│   └── routing/
│       ├── app_router.dart
│       ├── route_names.dart
│       ├── route_guards.dart
│       └── navigation_service.dart
│
├── test/
│   ├── unit/
│   │   ├── core/
│   │   ├── features/
│   │   │   ├── authentication/
│   │   │   ├── question_bank/
│   │   │   ├── practice_mode/
│   │   │   ├── sprint_exams/
│   │   │   ├── analytics/
│   │   │   ├── ai_tutoring/
│   │   │   ├── social/
│   │   │   ├── subscription/
│   │   │   └── settings/
│   │   └── shared/
│   ├── widget/
│   │   ├── authentication/
│   │   ├── practice_mode/
│   │   ├── sprint_exams/
│   │   └── shared/
│   ├── integration/
│   │   ├── authentication_flow_test.dart
│   │   ├── practice_session_test.dart
│   │   ├── exam_flow_test.dart
│   │   └── subscription_flow_test.dart
│   └── mocks/
│       ├── mock_repositories.dart
│       ├── mock_datasources.dart
│       └── test_data.dart
│
├── assets/
│   ├── images/
│   │   ├── icons/
│   │   ├── illustrations/
│   │   ├── backgrounds/
│   │   └── logos/
│   ├── fonts/
│   ├── animations/
│   │   ├── lottie/
│   │   └── rive/
│   └── data/
│       ├── sample_questions.json
│       └── exam_configs.json
│
├── backend/
│   ├── README.md
│   ├── requirements.txt
│   ├── .env.example
│   ├── main.py
│   ├── app/
│   │   ├── __init__.py
│   │   ├── config.py
│   │   ├── database.py
│   │   ├── dependencies.py
│   │   ├── middleware.py
│   │   │
│   │   ├── api/
│   │   │   ├── __init__.py
│   │   │   ├── router.py
│   │   │   └── endpoints/
│   │   │       ├── __init__.py
│   │   │       ├── authentication.py
│   │   │       ├── users.py
│   │   │       ├── questions.py
│   │   │       ├── practice.py
│   │   │       ├── exams.py
│   │   │       ├── analytics.py
│   │   │       ├── ai_tutoring.py
│   │   │       ├── social.py
│   │   │       ├── subscriptions.py
│   │   │       └── admin.py
│   │   │
│   │   ├── services/
│   │   │   ├── __init__.py
│   │   │   ├── auth_service.py
│   │   │   ├── user_service.py
│   │   │   ├── device_service.py
│   │   │   ├── question_service.py
│   │   │   ├── practice_service.py
│   │   │   ├── exam_service.py
│   │   │   ├── analytics_service.py
│   │   │   ├── ai_service.py
│   │   │   ├── social_service.py
│   │   │   ├── subscription_service.py
│   │   │   ├── notification_service.py
│   │   │   └── content_service.py
│   │   │
│   │   ├── models/
│   │   │   ├── __init__.py
│   │   │   ├── user.py
│   │   │   ├── device.py
│   │   │   ├── question.py
│   │   │   ├── practice_session.py
│   │   │   ├── exam.py
│   │   │   ├── analytics.py
│   │   │   ├── ai_conversation.py
│   │   │   ├── social.py
│   │   │   └── subscription.py
│   │   │
│   │   ├── schemas/
│   │   │   ├── __init__.py
│   │   │   ├── auth_schemas.py
│   │   │   ├── user_schemas.py
│   │   │   ├── question_schemas.py
│   │   │   ├── practice_schemas.py
│   │   │   ├── exam_schemas.py
│   │   │   ├── analytics_schemas.py
│   │   │   ├── ai_schemas.py
│   │   │   ├── social_schemas.py
│   │   │   └── subscription_schemas.py
│   │   │
│   │   ├── core/
│   │   │   ├── __init__.py
│   │   │   ├── exceptions.py
│   │   │   ├── security.py
│   │   │   ├── utils.py
│   │   │   ├── validators.py
│   │   │   └── constants.py
│   │   │
│   │   ├── integrations/
│   │   │   ├── __init__.py
│   │   │   ├── firebase/
│   │   │   │   ├── __init__.py
│   │   │   │   ├── auth.py
│   │   │   │   ├── firestore.py
│   │   │   │   ├── storage.py
│   │   │   │   └── messaging.py
│   │   │   ├── paddle/
│   │   │   │   ├── __init__.py
│   │   │   │   └── payment_service.py
│   │   │   ├── ai_providers/
│   │   │   │   ├── __init__.py
│   │   │   │   ├── openai_client.py
│   │   │   │   ├── anthropic_client.py
│   │   │   │   └── gemini_client.py
│   │   │   └── google/
│   │   │       ├── __init__.py
│   │   │       ├── analytics.py
│   │   │       └── adsense.py
│   │   │
│   │   ├── tasks/
│   │   │   ├── __init__.py
│   │   │   ├── analytics_tasks.py
│   │   │   ├── notification_tasks.py
│   │   │   ├── subscription_tasks.py
│   │   │   └── content_tasks.py
│   │   │
│   │   └── admin/
│   │       ├── __init__.py
│   │       ├── content_management.py
│   │       ├── user_management.py
│   │       ├── analytics_dashboard.py
│   │       └── system_monitoring.py
│   │
│   ├── tests/
│   │   ├── __init__.py
│   │   ├── conftest.py
│   │   ├── test_auth.py
│   │   ├── test_questions.py
│   │   ├── test_practice.py
│   │   ├── test_exams.py
│   │   ├── test_analytics.py
│   │   ├── test_ai.py
│   │   ├── test_social.py
│   │   └── test_subscriptions.py
│   │
│   ├── scripts/
│   │   ├── migrate_data.py
│   │   ├── seed_questions.py
│   │   ├── setup_firebase.py
│   │   └── deploy.py
│   │
│   ├── docs/
│   │   ├── api_documentation.md
│   │   ├── deployment_guide.md
│   │   ├── database_schema.md
│   │   └── integration_guides/
│   │       ├── firebase_setup.md
│   │       ├── paddle_integration.md
│   │       └── ai_providers.md
│   │
│   └── docker/
│       ├── Dockerfile
│       ├── docker-compose.yml
│       ├── docker-compose.dev.yml
│       └── .dockerignore
│
├── firebase/
│   ├── functions/
│   │   ├── main.py
│   │   ├── requirements.txt
│   │   ├── triggers/
│   │   │   ├── __init__.py
│   │   │   ├── auth_triggers.py
│   │   │   ├── subscription_triggers.py
│   │   │   ├── analytics_triggers.py
│   │   │   └── notification_triggers.py
│   │   ├── background_jobs/
│   │   │   ├── __init__.py
│   │   │   ├── analytics_aggregation.py
│   │   │   ├── device_cleanup.py
│   │   │   └── subscription_management.py
│   │   └── utils/
│   │       ├── __init__.py
│   │       ├── firestore_utils.py
│   │       ├── auth_utils.py
│   │       └── notification_utils.py
│   │
│   ├── firestore.rules
│   ├── firestore.indexes.json
│   ├── storage.rules
│   ├── firebase.json
│   └── .firebaserc
│
├── admin_panel/
│   ├── README.md
│   ├── pubspec.yaml
│   ├── analysis_options.yaml
│   ├── web/
│   ├── lib/
│   │   ├── main.dart
│   │   ├── admin_app.dart
│   │   │
│   │   ├── core/
│   │   │   ├── constants/
│   │   │   │   ├── admin_constants.dart
│   │   │   │   └── admin_routes.dart
│   │   │   ├── config/
│   │   │   │   └── admin_config.dart
│   │   │   ├── network/
│   │   │   │   ├── admin_api_client.dart
│   │   │   │   └── admin_interceptors.dart
│   │   │   └── utils/
│   │   │       ├── admin_utils.dart
│   │   │       ├── export_utils.dart
│   │   │       └── validation_utils.dart
│   │   │
│   │   ├── features/
│   │   │   ├── dashboard/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── overview_stats_model.dart
│   │   │   │   │   │   └── system_health_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── dashboard_repository.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   └── dashboard_provider.dart
│   │   │   │       ├── pages/
│   │   │   │       │   └── admin_dashboard_page.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── overview_cards.dart
│   │   │   │           ├── analytics_charts.dart
│   │   │   │           ├── recent_activity_list.dart
│   │   │   │           └── system_health_indicators.dart
│   │   │   │
│   │   │   ├── content_management/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── content_review_model.dart
│   │   │   │   │   │   └── bulk_upload_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── content_management_repository.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── question_editor_provider.dart
│   │   │   │       │   ├── content_review_provider.dart
│   │   │   │       │   └── bulk_upload_provider.dart
│   │   │   │       ├── pages/
│   │   │   │       │   ├── content_management_page.dart
│   │   │   │       │   ├── question_editor_page.dart
│   │   │   │       │   └── bulk_upload_page.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── question_editor_form.dart
│   │   │   │           ├── question_list_table.dart
│   │   │   │           ├── arde_probability_editor.dart
│   │   │   │           ├── bulk_upload_interface.dart
│   │   │   │           ├── content_review_queue.dart
│   │   │   │           └── question_preview.dart
│   │   │   │
│   │   │   ├── user_management/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── admin_user_model.dart
│   │   │   │   │   │   └── user_analytics_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── user_management_repository.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── user_list_provider.dart
│   │   │   │       │   ├── device_management_provider.dart
│   │   │   │       │   └── subscription_management_provider.dart
│   │   │   │       ├── pages/
│   │   │   │       │   ├── user_management_page.dart
│   │   │   │       │   ├── user_details_page.dart
│   │   │   │       │   └── device_management_page.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── user_list_table.dart
│   │   │   │           ├── user_details_card.dart
│   │   │   │           ├── device_management_panel.dart
│   │   │   │           ├── subscription_status_card.dart
│   │   │   │           └── user_activity_timeline.dart
│   │   │   │
│   │   │   ├── analytics/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── business_metrics_model.dart
│   │   │   │   │   │   └── performance_analytics_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── analytics_repository.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── analytics_dashboard_provider.dart
│   │   │   │       │   ├── performance_metrics_provider.dart
│   │   │   │       │   └── export_provider.dart
│   │   │   │       ├── pages/
│   │   │   │       │   ├── analytics_dashboard_page.dart
│   │   │   │       │   ├── performance_metrics_page.dart
│   │   │   │       │   └── business_intelligence_page.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── performance_dashboard.dart
│   │   │   │           ├── usage_metrics_charts.dart
│   │   │   │           ├── conversion_funnel_chart.dart
│   │   │   │           ├── arde_performance_analytics.dart
│   │   │   │           └── export_tools.dart
│   │   │   │
│   │   │   ├── system_settings/
│   │   │   │   ├── data/
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── system_config_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── settings_repository.dart
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── system_settings_provider.dart
│   │   │   │       │   └── integration_settings_provider.dart
│   │   │   │       ├── pages/
│   │   │   │       │   ├── system_settings_page.dart
│   │   │   │       │   ├── content_settings_page.dart
│   │   │   │       │   └── integration_settings_page.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── system_config_form.dart
│   │   │   │           ├── content_policy_editor.dart
│   │   │   │           ├── api_integration_panel.dart
│   │   │   │           └── tier_limits_editor.dart
│   │   │   │
│   │   │   └── auth/
│   │   │       ├── data/
│   │   │       │   ├── models/
│   │   │       │   │   └── admin_auth_model.dart
│   │   │       │   └── repositories/
│   │   │       │       └── admin_auth_repository.dart
│   │   │       └── presentation/
│   │   │           ├── providers/
│   │   │           │   └── admin_auth_provider.dart
│   │   │           ├── pages/
│   │   │           │   └── admin_login_page.dart
│   │   │           └── widgets/
│   │   │               ├── admin_login_form.dart
│   │   │               └── role_selector.dart
│   │   │
│   │   ├── shared/
│   │   │   ├── widgets/
│   │   │   │   ├── layout/
│   │   │   │   │   ├── admin_app_bar.dart
│   │   │   │   │   ├── admin_sidebar.dart
│   │   │   │   │   ├── admin_layout.dart
│   │   │   │   │   └── responsive_layout.dart
│   │   │   │   ├── tables/
│   │   │   │   │   ├── data_table_widget.dart
│   │   │   │   │   ├── sortable_table.dart
│   │   │   │   │   ├── filterable_table.dart
│   │   │   │   │   └── pagination_controls.dart
│   │   │   │   ├── charts/
│   │   │   │   │   ├── admin_line_chart.dart
│   │   │   │   │   ├── admin_bar_chart.dart
│   │   │   │   │   ├── admin_pie_chart.dart
│   │   │   │   │   └── real_time_chart.dart
│   │   │   │   ├── forms/
│   │   │   │   │   ├── admin_form_field.dart
│   │   │   │   │   ├── rich_text_editor.dart
│   │   │   │   │   ├── file_upload_widget.dart
│   │   │   │   │   └── multi_select_dropdown.dart
│   │   │   │   └── common/
│   │   │   │       ├── admin_card.dart
│   │   │   │       ├── stat_card.dart
│   │   │   │       ├── action_button.dart
│   │   │   │       ├── status_indicator.dart
│   │   │   │       └── confirmation_dialog.dart
│   │   │   ├── providers/
│   │   │   │   ├── admin_navigation_provider.dart
│   │   │   │   ├── admin_theme_provider.dart
│   │   │   │   └── admin_connectivity_provider.dart
│   │   │   └── models/
│   │   │       ├── admin_base_model.dart
│   │   │       └── admin_api_response.dart
│   │   │
│   │   └── routing/
│   │       ├── admin_router.dart
│   │       ├── admin_route_names.dart
│   │       └── admin_route_guards.dart
│   │
│   ├── test/
│   │   ├── unit/
│   │   ├── widget/
│   │   └── integration/
│   │
│   └── assets/
│       ├── images/
│       │   ├── admin_icons/
│       │   └── admin_illustrations/
│       └── fonts/
│
├── docs/
│   ├── README.md
│   ├── CONTRIBUTING.md
│   ├── DEPLOYMENT.md
│   ├── API_REFERENCE.md
│   ├── architecture/
│   │   ├── system_overview.md
│   │   ├── database_design.md
│   │   ├── security_architecture.md
│   │   └── scaling_strategy.md
│   ├── development/
│   │   ├── setup_guide.md
│   │   ├── coding_standards.md
│   │   ├── testing_guidelines.md
│   │   └── debugging_tips.md
│   ├── integration/
│   │   ├── firebase_setup.md
│   │   ├── paddle_integration.md
│   │   ├── ai_providers_setup.md
│   │   └── analytics_setup.md
│   ├── user_guides/
│   │   ├── admin_panel_guide.md
│   │   ├── content_creation_guide.md
│   │   └── analytics_guide.md
│   └── troubleshooting/
│       ├── common_issues.md
│       ├── performance_optimization.md
│       └── error_handling.md
│
├── scripts/
│   ├── setup/
│   │   ├── install_dependencies.sh
│   │   ├── setup_environment.sh
│   │   ├── configure_firebase.sh
│   │   └── setup_development.sh
│   ├── build/
│   │   ├── build_flutter.sh
│   │   ├── build_backend.sh
│   │   ├── build_admin.sh
│   │   └── build_all.sh
│   ├── deployment/
│   │   ├── deploy_staging.sh
│   │   ├── deploy_production.sh
│   │   ├── rollback.sh
│   │   └── health_check.sh
│   ├── maintenance/
│   │   ├── backup_database.sh
│   │   ├── cleanup_old_data.sh
│   │   ├── update_dependencies.sh
│   │   └── performance_monitoring.sh
│   └── development/
│       ├── generate_test_data.sh
│       ├── run_tests.sh
│       ├── code_quality_check.sh
│       └── start_development.sh
│
├── ci_cd/
│   ├── .github/
│   │   └── workflows/
│   │       ├── flutter_ci.yml
│   │       ├── backend_ci.yml
│   │       ├── admin_panel_ci.yml
│   │       ├── integration_tests.yml
│   │       ├── deploy_staging.yml
│   │       └── deploy_production.yml
│   ├── gitlab-ci/
│   │   └── .gitlab-ci.yml
│   ├── docker/
│   │   ├── flutter/
│   │   │   └── Dockerfile
│   │   ├── backend/
│   │   │   └── Dockerfile
│   │   └── admin/
│   │       └── Dockerfile
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── modules/
│           ├── firebase/
│           ├── gcp/
│           └── monitoring/
│
├── monitoring/
│   ├── grafana/
│   │   ├── dashboards/
│   │   │   ├── application_metrics.json
│   │   │   ├── user_analytics.json
│   │   │   ├── performance_monitoring.json
│   │   │   └── business_metrics.json
│   │   └── provisioning/
│   │       ├── datasources/
│   │       └── dashboards/
│   ├── prometheus/
│   │   ├── prometheus.yml
│   │   ├── alerts/
│   │   │   ├── application_alerts.yml
│   │   │   ├── infrastructure_alerts.yml
│   │   │   └── business_alerts.yml
│   │   └── rules/
│   │       ├── application_rules.yml
│   │       └── business_rules.yml
│   └── logging/
│       ├── fluentd/
│       │   └── fluent.conf
│       └── elasticsearch/
│           ├── index_templates/
│           └── queries/
│
├── data/
│   ├── migrations/
│   │   ├── firestore/
│   │   │   ├── 001_initial_collections.js
│   │   │   ├── 002_add_arde_probability.js
│   │   │   ├── 003_device_management.js
│   │   │   └── 004_analytics_separation.js
│   │   └── bigquery/
│   │       ├── 001_analytics_tables.sql
│   │       ├── 002_performance_views.sql
│   │       └── 003_business_intelligence.sql
│   ├── seeds/
│   │   ├── sample_questions/
│   │   │   ├── ecat_physics.json
│   │   │   ├── ecat_chemistry.json
│   │   │   ├── ecat_mathematics.json
│   │   │   ├── mcat_biology.json
│   │   │   ├── mcat_chemistry.json
│   │   │   └── mcat_physics.json
│   │   ├── exam_configurations/
│   │   │   ├── ecat_config.json
│   │   │   ├── mcat_config.json
│   │   │   ├── ccat_config.json
│   │   │   └── international_exams.json
│   │   └── user_tiers/
│   │       ├── anonymous_limits.json
│   │       ├── free_tier_limits.json
│   │       └── paid_tier_features.json
│   └── exports/
│       ├── question_bank_backup/
│       ├── user_analytics_export/
│       └── performance_reports/
│
├── config/
│   ├── environments/
│   │   ├── development.env
│   │   ├── staging.env
│   │   ├── production.env
│   │   └── local.env
│   ├── firebase/
│   │   ├── development-config.json
│   │   ├── staging-config.json
│   │   └── production-config.json
│   ├── app_configs/
│   │   ├── flutter_config.dart
│   │   ├── api_endpoints.dart
│   │   ├── feature_flags.dart
│   │   └── tier_configurations.dart
│   └── third_party/
│       ├── paddle_config.json
│       ├── ai_providers_config.json
│       ├── analytics_config.json
│       └── notification_config.json
│
├── security/
│   ├── certificates/
│   │   ├── development/
│   │   ├── staging/
│   │   └── production/
│   ├── api_keys/
│   │   ├── .env.vault
│   │   ├── key_rotation_guide.md
│   │   └── access_policies.json
│   ├── firestore_rules/
│   │   ├── development.rules
│   │   ├── staging.rules
│   │   ├── production.rules
│   │   └── rules_testing.js
│   └── security_policies/
│       ├── data_privacy_policy.md
│       ├── access_control_policy.md
│       ├── incident_response_plan.md
│       └── security_checklist.md
│
├── performance/
│   ├── benchmarks/
│   │   ├── api_performance_tests.py
│   │   ├── database_query_tests.py
│   │   ├── flutter_performance_tests.dart
│   │   └── load_testing_scenarios.js
│   ├── optimization/
│   │   ├── image_compression_scripts/
│   │   ├── database_indexing_strategy.md
│   │   ├── api_caching_configuration.md
│   │   └── cdn_optimization_guide.md
│   └── monitoring_scripts/
│       ├── performance_metrics_collector.py
│       ├── user_experience_tracker.js
│       └── system_health_checker.sh
│
└── tools/
    ├── code_generators/
    │   ├── feature_generator.py
    │   ├── model_generator.py
    │   ├── api_endpoint_generator.py
    │   └── test_generator.py
    ├── quality_assurance/
    │   ├── code_analyzer.py
    │   ├── dependency_checker.py
    │   ├── security_scanner.py
    │   └── performance_profiler.py
    ├── content_management/
    │   ├── question_validator.py
    │   ├── arde_probability_updater.py
    │   ├── bulk_content_processor.py
    │   └── content_quality_checker.py
    └── development_helpers/
        ├── mock_data_generator.py
        ├── api_documentation_generator.py
        ├── database_schema_visualizer.py
        └── development_server.py
```

## Key Directory Structure Notes

### 🎯 **Core Flutter Architecture**
- **Clean Architecture**: Each feature follows Domain-Data-Presentation layers
- **Riverpod Integration**: Centralized state management with providers
- **Feature-Based Organization**: Self-contained modules for each major feature
- **Shared Components**: Reusable widgets, providers, and utilities

### 🔧 **Backend Organization**
- **FastAPI Structure**: Modular API with clear separation of concerns
- **Service Layer**: Business logic isolated from API endpoints
- **Integration Layer**: Third-party service integrations (Firebase, Paddle, AI providers)
- **Background Tasks**: Async processing for analytics and notifications

### 🔥 **Firebase Integration**
- **Cloud Functions**: TypeScript-based serverless functions
- **Security Rules**: Environment-specific Firestore and Storage rules
- **Triggers**: Event-driven background processing
- **Configuration**: Multi-environment Firebase project setup

### 👨‍💼 **Admin Panel**
- **Flutter Web-based**: Separate Flutter web application for content management
- **Shared Architecture**: Same clean architecture pattern as main app
- **Admin-Specific Features**: Content management, user administration, analytics dashboard
- **Role-Based Access**: Admin authentication and authorization system

### 🔒 **Security & Configuration**
- **Environment Management**: Multi-stage environment configurations
- **API Key Management**: Secure key storage and rotation policies
- **Security Rules**: Comprehensive Firestore security implementation
- **Compliance**: Data privacy and security policy documentation

### 📊 **Monitoring & Analytics**
- **Performance Monitoring**: Grafana dashboards and Prometheus metrics
- **Business Intelligence**: BigQuery analytics and reporting
- **Error Tracking**: Comprehensive logging and error monitoring
- **Load Testing**: Performance benchmarking and optimization tools

### 🚀 **DevOps & Deployment**
- **CI/CD Pipelines**: GitHub Actions for automated testing and deployment
- **Containerization**: Docker configurations for all services
- **Infrastructure as Code**: Terraform for cloud resource management
- **Monitoring Stack**: Complete observability setup

### 📱 **Platform-Specific Considerations**
- **Multi-Platform Flutter**: iOS, Android, Web support
- **Responsive Design**: Adaptive UI for different screen sizes
- **Offline Capability**: Local caching and sync strategies
- **Performance Optimization**: Platform-specific optimizations

This structure supports your EntryTestGuru project's requirements including device management, ARDE probability features, tiered user access, AI tutoring, social features, and comprehensive analytics while maintaining scalability and maintainability.