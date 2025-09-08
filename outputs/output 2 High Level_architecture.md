# EntryTestGuru - High-Level Technical Architecture

## Features (MVP)

### Authentication & User Management
Comprehensive authentication system supporting anonymous users, social logins, and seamless tier transitions with Firebase Auth integration. Handles user onboarding, exam category selection, tier-based access control, and multi-device management with 3-device limit enforcement across the entire platform.

#### Tech Involved
* Firebase Auth (Google/Facebook/Phone/Email) with Anonymous Authentication for guest users
* Flutter device_info_plus package for device fingerprinting (registered users only)
* Flutter Riverpod for state management
* FastAPI user management service with device tracking (registered users) and Firebase Anonymous UID tracking
* Cloud Firestore for user profiles, preferences, and device registry
* JWT token management for API authentication with device validation
* Real-time notifications via Firebase Cloud Messaging for device management

#### Main Requirements
* Anonymous user session tracking via Firebase Anonymous Authentication with browser-specific usage limits (no cross-device sync)
* Seamless upgrade path from anonymous → free → paid tiers with Firebase Auth UID migration
* Real-time sync of user tier limitations and usage statistics for registered users only (free/paid)
* Secure token refresh and validation across all API endpoints
* Support for multiple authentication providers with unified user experience
* 3-device limit enforcement with device fingerprinting and management for registered users only
* Interactive device management interface showing registered devices with removal capabilities (free/paid users only)
* 4th device login flow: block access, notify existing devices, require device removal before allowing new device (registered users only)
* Real-time device status updates across all active sessions for registered users
* Device metadata display with user-customizable device names, automatic device type detection, browser session tracking, last active timestamps, and registration dates (registered users only)
* Anonymous users: Firebase Anonymous UID-based usage limits with browser-session persistence, no cross-device synchronization or session management

### Question Bank & Content Management System
Centralized question repository serving 10,000+ MCQs with advanced filtering, ARDE probability tagging, and comprehensive content versioning. Supports batch content updates with approval workflows and real-time question delivery optimized for mobile consumption.

#### Tech Involved
* Cloud Firestore for structured question storage with real-time updates
* Firebase Storage for question images, diagrams, and video explanations
* FastAPI content management service with version control and approval workflows
* Background Cloud Functions for automated content processing and distribution
* Redis caching for frequently accessed questions and ARDE probability data

#### Main Requirements
* 10,000+ MCQs with comprehensive subject coverage across all supported exam categories
* Advanced question tagging system including ARDE probability, difficulty, topic hierarchy, and appearance frequency
* Real-time content delivery with intelligent caching and prefetching strategies
* Version control system for question updates with rollback capabilities
* Content approval workflow for admin review and quality assurance
* Automated question variation generation to prevent memorization patterns
* Performance tracking per question to optimize content difficulty and effectiveness

### Practice Mode & Learning Engine
Intelligent practice system with adaptive question selection, immediate feedback, and comprehensive performance tracking. Implements tier-based usage limits with seamless progression and conversion incentives for enhanced user engagement.

#### Tech Involved
* FastAPI practice orchestration service with intelligent question selection algorithms
* Cloud Firestore for real-time session state management and performance tracking
* Background Cloud Functions for analytics computation and pattern recognition
* Redis for session caching and performance metric aggregation

#### Main Requirements
* Adaptive question selection based on user performance, weak areas, and ARDE probability
* Real-time feedback system with immediate answer validation and explanation access
* Comprehensive session analytics with timing precision and performance metrics
* Tier-based practice limits (20/50/unlimited daily MCQs for anonymous/free/paid users)
* Intelligent caching system for offline practice capabilities
* Question bookmarking and review system for focused study sessions

### Sprint Exams & Simulated Real Exams (SRE)
Comprehensive exam simulation platform offering both custom sprint configurations and exact replicas of real exam conditions. Provides detailed performance analytics and supports both custom sprint configurations and standardized real exam replicas.

#### Tech Involved
* FastAPI exam orchestration service with precise timing controls
* Cloud Firestore for exam configuration and results storage
* WebSocket connections for real-time exam state synchronization
* Background Cloud Functions for automated grading and analytics
* Redis for exam session state management

#### Main Requirements
* Precise timer implementation with pause/resume capabilities for break intervals
* Configurable question selection algorithms based on difficulty and ARDE probability
* Real-time exam state persistence to handle connectivity interruptions
* Comprehensive scorecard generation with detailed performance breakdowns
* Integration with analytics engine for historical trend analysis
* Tier-based exam access controls (1/4/unlimited for anonymous/free/paid)

### AI-Powered Tutoring & Explanation System
Intelligent tutoring system providing contextual explanations and follow-up discussions using external LLM APIs. Implements fair usage policies with tier-based access controls and conversation context management for enhanced learning experiences.

#### Tech Involved
* FastAPI AI orchestration service with multiple LLM provider integrations
* OpenAI API, Anthropic Claude, Google Gemini API adapters
* Cloud Firestore for conversation history and context storage
* Rate limiting and quota management via Redis
* Background jobs for explanation generation and caching

#### Main Requirements
* Integration with multiple LLM providers (OpenAI, Anthropic, Gemini, Mistral)
* Tier-based explanation access control (2/4/unlimited daily explanations)
* Context-aware conversation management for follow-up questions
* Fair usage policy implementation with intelligent throttling
* Explanation caching strategy to optimize API costs and response times
* Quality filtering and content moderation for generated responses

### Analytics & Performance Tracking Engine
Comprehensive analytics platform capturing millisecond-precision user interactions, learning patterns, and performance metrics. Provides both real-time insights and historical trend analysis with specialized ARDE probability performance tracking.

#### Tech Involved
* Separate Cloud Firestore database for analytics data isolation
* BigQuery for complex analytical queries and data warehousing
* Google Analytics integration for app usage insights
* FastAPI analytics service with real-time data processing
* Background Cloud Functions for metric aggregation and computation

#### Main Requirements
* Millisecond-precision timing data capture for all user interactions
* Separate database architecture isolating learning analytics from operational data
* Real-time performance metric computation and caching
* Historical trend analysis with data retention policies
* Export functionality for external analysis tools
* ARDE probability performance correlation and strategic recommendations
* Business intelligence metrics for conversion funnel optimization

### Subscription Management & Monetization
Complete subscription lifecycle management integrated with Paddle.com for payment processing and Google AdSense for free tier monetization. Handles tier transitions, usage enforcement, and billing automation with comprehensive admin controls.

#### Tech Involved
* Paddle.com API integration for subscription management
* Google AdSense integration with Flutter ad widgets
* FastAPI subscription service with webhook handling
* Cloud Functions for automated billing and tier management
* Cloud Firestore for subscription state and usage tracking

#### Main Requirements
* Seamless integration with Paddle.com for global payment processing
* Real-time subscription status synchronization via webhooks
* Tier-based feature access enforcement across all system components
* Advertisement serving with timing exclusion from performance analytics
* Automated billing cycle management with failure handling
* Admin dashboard for subscription analytics and customer support

### Social Features & Community Platform
Community-driven learning platform with leaderboards, study groups, and competitive challenges. Supports real-time progress sharing, comparative analytics, and social accountability features to enhance user engagement and retention.

#### Tech Involved
* Cloud Firestore with real-time listeners for social data
* FastAPI social service with notification orchestration
* Firebase Cloud Messaging for push notifications
* Redis for leaderboard computation and caching
* Background jobs for challenge processing and reward distribution

#### Main Requirements
* Real-time leaderboard updates with efficient ranking algorithms
* Study group management with privacy controls and member permissions
* Comparative analytics showing individual vs. group performance metrics
* Push notification system for social engagement and milestone celebrations
* Challenge creation and participation tracking with ARDE probability themes
* Social sharing integration with external platforms

### Device Management & Account Settings
Comprehensive device management system for registered users (free/paid) allowing them to view, monitor, and control their registered devices with real-time status updates and intelligent browser consolidation. Anonymous users operate with Firebase Anonymous UID-based usage limits without cross-device synchronization. Provides intuitive interface for device removal when registered users attempt to login on additional devices beyond the 3-device limit.

#### Tech Involved
* Flutter device management UI components with real-time updates and browser session displays
* Flutter web platform channels and dart:html for web machine-level identification (registered users only)
* Cloud Firestore device registry with real-time synchronization for cross-device management visibility
* Cloud Firestore real-time listeners for device status synchronization across browser sessions
* FastAPI device management service with CRUD operations and browser session tracking
* Firebase Cloud Messaging for cross-device notifications and consolidation alerts
* Device metadata collection and display with browser session details (Chrome, Firefox, Safari active sessions)

#### Main Requirements
* Device management interface for registered users only (free/paid) showing all registered devices with browser session breakdowns
* Anonymous users: Firebase Anonymous UID-based usage tracking with browser session persistence only (no cross-device features)
* Automated server-side device consolidation using weighted fingerprint similarity algorithm (85% threshold) for registered users
* Interactive device removal functionality with immediate effect across all browser sessions (registered users only)
* 4th device login workflow for registered users: block access, display removal interface with browser session details, require action before proceeding
* Push notifications to existing devices when new device attempts login (registered users only)
* Device status monitoring (online/offline, last active timestamp) with per-browser session granularity for registered users
* Device nickname editing functionality for registered users allowing personalized device names (e.g., "My Work Laptop", "Home Desktop")
* Browser session tracking showing active browsers per desktop device for registered users (Chrome, Firefox, Safari, etc.)
* Anonymous users: simplified tier limit enforcement tied to Firebase Anonymous UID with no device management features
* Immediate session termination on device removal with graceful user experience across all browser sessions (registered users only)
* Device management accessible from account settings on all platforms with consolidated desktop view (registered users only)

### Content Quality Assurance & Support System
Quality management system for user-generated feedback, content corrections, and customer support workflows. Implements automated issue tracking with admin review processes and maintains content integrity across the platform.

#### Tech Involved
* Cloud Firestore for issue tracking and content flagging systems
* FastAPI quality assurance service with automated workflow management
* Admin dashboard for content review and issue resolution
* Integration with content management system for immediate corrections
* Email and push notification systems for issue updates

#### Main Requirements
* User-driven content feedback and correction submission system
* Automated content quality monitoring with flagging mechanisms
* Admin workflow for content review and approval processes
* Real-time issue tracking with priority classification systems
* Integration with user support ticket system for comprehensive issue resolution

## System Architecture Diagram

```mermaid
graph TB
    %% Client Applications
    FlutterApp[Flutter Mobile App<br/>iOS & Android]
    FlutterWeb[Flutter Web App<br/>Progressive Web App]
    AdminPanel[Admin Panel<br/>Flutter Web]
    
    %% API Gateway
    APIGateway[API Gateway<br/>FastAPI]
    
    %% Microservices
    AuthService[Authentication Service<br/>FastAPI]
    UserService[User Management Service<br/>FastAPI]
    ContentService[Content Management Service<br/>FastAPI]
    PracticeService[Practice Engine Service<br/>FastAPI]
    ExamService[Exam Orchestration Service<br/>FastAPI]
    AnalyticsService[Analytics Service<br/>FastAPI]
    AIService[AI Tutoring Service<br/>FastAPI]
    SocialService[Social Features Service<br/>FastAPI]
    SubscriptionService[Subscription Service<br/>FastAPI]
    NotificationService[Push Notification Service<br/>FastAPI]
    DeviceService[Device Management Service<br/>FastAPI]
    
    %% External Services
    FirebaseAuth[Firebase Auth<br/>Authentication Provider]
    PaddleAPI[Paddle.com<br/>Payment Processing]
    OpenAI[OpenAI API<br/>GPT Models]
    Anthropic[Anthropic API<br/>Claude Models]
    Gemini[Google Gemini API<br/>LLM Provider]
    GoogleAnalytics[Google Analytics<br/>Usage Tracking]
    AdSense[Google AdSense<br/>Advertisement]
    FCM[Firebase Cloud Messaging<br/>Push Notifications]
    
    %% Databases
    Firestore[Cloud Firestore<br/>Primary Database]
    AnalyticsDB[Analytics Firestore<br/>Isolated Analytics DB]
    BigQuery[BigQuery<br/>Data Warehouse]
    FirebaseStorage[Firebase Storage<br/>Media Content]
    
    %% Caching & Performance
    Redis[Redis<br/>Session & Cache Management]
    
    %% Background Processing
    CloudFunctions[Cloud Functions<br/>Background Jobs]
    
    %% Client to API Gateway
    FlutterApp --> APIGateway
    FlutterWeb --> APIGateway
    AdminPanel --> APIGateway
    
    %% API Gateway to Services
    APIGateway --> AuthService
    APIGateway --> UserService
    APIGateway --> ContentService
    APIGateway --> PracticeService
    APIGateway --> ExamService
    APIGateway --> AnalyticsService
    APIGateway --> AIService
    APIGateway --> SocialService
    APIGateway --> SubscriptionService
    APIGateway --> NotificationService
    APIGateway --> DeviceService
    
    %% Service Dependencies
    AuthService --> FirebaseAuth
    AuthService --> Firestore
    AuthService --> Redis
    UserService --> Firestore
    UserService --> Redis
    ContentService --> Firestore
    ContentService --> FirebaseStorage
    ContentService --> Redis
    PracticeService --> Firestore
    PracticeService --> AnalyticsDB
    PracticeService --> Redis
    ExamService --> Firestore
    ExamService --> AnalyticsDB
    ExamService --> Redis
    AnalyticsService --> AnalyticsDB
    AnalyticsService --> BigQuery
    AnalyticsService --> Firestore
    AIService --> OpenAI
    AIService --> Anthropic
    AIService --> Gemini
    AIService --> Firestore
    AIService --> Redis
    SocialService --> Firestore
    SocialService --> Redis
    SocialService --> FCM
    SubscriptionService --> PaddleAPI
    SubscriptionService --> Firestore
    NotificationService --> FCM
    NotificationService --> Firestore
    DeviceService --> Firestore
    DeviceService --> FCM
    DeviceService --> Redis
    
    %% Background Processing
    CloudFunctions --> Firestore
    CloudFunctions --> AnalyticsDB
    CloudFunctions --> BigQuery
    CloudFunctions --> PaddleAPI
    
    %% Advertisement Integration
    FlutterApp --> AdSense
    FlutterWeb --> AdSense
    
    %% Analytics Flow
    FlutterApp -.-> GoogleAnalytics
    FlutterWeb -.-> GoogleAnalytics
    
    %% Styling
    classDef client fill:#e1f5fe
    classDef service fill:#f3e5f5
    classDef database fill:#e8f5e8
    classDef external fill:#fff3e0
    classDef cache fill:#fce4ec
    
    class FlutterApp,FlutterWeb,AdminPanel client
    class AuthService,UserService,ContentService,PracticeService,ExamService,AnalyticsService,AIService,SocialService,SubscriptionService,NotificationService,DeviceService service
    class Firestore,AnalyticsDB,BigQuery,FirebaseStorage database
    class FirebaseAuth,PaddleAPI,OpenAI,Anthropic,Gemini,GoogleAnalytics,AdSense,FCM external
    class Redis cache
```

## Architecture Decisions & Rationale

### Flutter-First Architecture
- **Cross-Platform Consistency**: Single codebase for iOS, Android, and Web using Flutter's unified development approach
- **Performance Optimization**: Native compilation for mobile with efficient web rendering for browser-based access
- **State Management**: Riverpod for reactive state management with provider-based architecture across all platforms
- **UI Consistency**: Material Design 3 implementation with adaptive widgets for platform-specific behaviors

### Device Management Strategy
- **Mobile Devices**: Hardware-based fingerprinting using device_info_plus package for unique, persistent device identification (registered users only)
- **Web Browsers**: Machine fingerprinting payload stored in Cloud Firestore with automated server-side consolidation logic to treat multiple browsers on same desktop as single device (registered users only)
- **Anonymous Users**: Firebase Anonymous UID-based usage limits with browser session persistence, no cross-device features or device registry
- **Real-time Synchronization**: All device management operations visible across all user devices via Firestore real-time listeners (registered users only)
- **Cross-Platform Consistency**: Unified device management experience across mobile apps and web browsers with instant cross-device updates for registered users
- **Security-First Approach**: Automated fingerprint matching with weighted similarity algorithm (85% threshold) prevents user manipulation of device limits for registered users
- **Simplified Anonymous Experience**: Basic tier enforcement tied to Firebase Anonymous UID with no device management complexity

### Database Architecture
- **Primary Database**: Cloud Firestore for real-time capabilities, horizontal scaling, and Firebase ecosystem integration
- **Analytics Isolation**: Separate Firestore instance for analytics data to prevent performance impact on core application features
- **Data Warehousing**: BigQuery integration for complex analytical queries and long-term trend analysis
- **Caching Strategy**: Redis for session management, leaderboards, and frequently accessed data to support 100K concurrent users

### Caching & Performance Strategy
- **Multi-Layer Caching**: CDN for static content, Redis for dynamic data, and application-level caching for question banks
- **Question Bank Optimization**: Intelligent pre-loading of questions based on user patterns and ARDE probability preferences
- **Real-time Sync**: WebSocket connections for exam sessions and live leaderboards with fallback to polling

### Scalability Considerations
- **Auto-scaling**: Firebase Functions automatically scale during peak exam seasons
- **Load Distribution**: API Gateway with intelligent routing and rate limiting
- **Database Sharding**: Composite indexes in Firestore optimized for complex filtering requirements
- **Regional Optimization**: Single region deployment initially with expansion capability

### Security & Privacy
- **Authentication**: Firebase Auth with multi-provider support, JWT token validation, and Anonymous Authentication for guest users
- **Device Management**: 3-device limit enforcement for registered users only with Flutter device fingerprinting for mobile and automated server-side similarity matching for web browsers
- **Anonymous User Limits**: Firebase Anonymous UID-based usage tracking with browser session persistence, no cross-device synchronization or device management features
- **Cross-Browser Consolidation**: Multiple browsers on same desktop count as single device for registered users using weighted fingerprint similarity algorithm (85% threshold)
- **Anti-Gaming Measures**: Multiple fingerprint factors (screen, platform, timezone, hardware) with weighted scoring for registered users to prevent device limit circumvention
- **API Security**: Rate limiting, request validation, and secure API key management
- **Data Privacy**: Anonymous user tracking via Firebase Anonymous UIDs without personal data collection, browser-specific limits only
- **Payment Security**: PCI-compliant processing through Paddle.com integration

### Monitoring & Observability
- **Application Monitoring**: Firebase Crashlytics for error tracking and performance monitoring
- **Business Analytics**: Google Analytics integration for user behavior insights
- **Custom Metrics**: Real-time performance dashboards for system health and user engagement
- **Alert Systems**: Automated monitoring for API response times, error rates, and concurrent user limits