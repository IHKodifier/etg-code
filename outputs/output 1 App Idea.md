# EntryTestGuru - Project Specification

## Elevator Pitch
EntryTestGuru is a comprehensive exam preparation platform that helps students master critical admission tests (ECAT, MCAT, CCAT, GMAT, GRE, SAT) through intelligent practice, precise analytics, and adaptive learning. With over 10,000+ MCQs, real-time performance tracking, ARDE probability insights, and personalized study plans, we transform high-stakes exam preparation from stressful cramming into confident, data-driven success.

## Problem Statement
Students preparing for once-yearly admission exams face three critical challenges:
1. **High Stakes, No Second Chances**: Most exams (ECAT, MCAT, CCAT) offer only one attempt per year with no retakes
2. **Lack of Targeted Practice**: Generic study materials don't identify individual weaknesses or optimize time allocation based on actual exam patterns
3. **Poor Time Management Under Pressure**: Students struggle with time constraints and exam anxiety without realistic practice environments and strategic question prioritization

Current solutions are either too generic (standard textbooks) or too expensive (private tutoring), leaving a gap for intelligent, affordable, personalized preparation that leverages real exam data.

## Target Audience

### Target Audience Segmentation

**Primary Segments:**
- **High School Graduates (16-18 years)**: Preparing for ECAT, MCAT, GMAT, GRE, SAT
- **Middle School Students (12-14 years)**: Preparing for CCAT (7th-8th graders)

**Geographic Focus:**
- Primary: Pakistan (ECAT, MCAT, CCAT)
- Secondary: International students (GMAT, GRE, SAT)

**User Tiers:**
- **Anonymous Users**: Trying the platform (20 MCQs + 2 explanations daily, 1 SE, 1 half-length SRE, device-specific limits with no cross-device sync)
- **Free Users**: 2-week trial with enhanced limits (50 daily MCQs + 4 explanations daily with AI tutoring, 4 SEs, 2 SREs, max 3 devices with cross-device sync)
- **Paid Users**: Unlimited access with premium features (unlimited MCQs + explanations + sprint exams + simulated real exams + fair usage based unlimited AI follow-up tutoring for answer explanations, max 3 devices with cross-device sync)

## Unique Selling Points (USP)
1. **ARDE Intelligence**: Questions tagged with actual exam appearance probability and historical frequency data
2. **Precision Analytics**: Track time-per-question, attempt patterns, and topic mastery with surgical precision
3. **Adaptive Question Variations**: Dynamic question variants that test true understanding, not memorization
4. **Realistic Exam Simulation**: Perfect replicas of actual exam conditions, timing, and marking schemes
5. **Strategic Study Plans**: Time-compressed curricula that prioritize high-probability questions based on ARDE dates
6. **Expert-Created Content**: 10,000+ questions with step-by-step explanations, video tutorials, and ARDE probability insights
7. **Affordable Access**: Comprehensive preparation at a fraction of private tutoring costs

## Target Platforms
- **Primary**: Flutter mobile app (iOS/Android)
- **Secondary**: Web application (responsive design)
- **Backend**: Python FastAPI with Firebase infrastructure

## Features List

### Authentication & Onboarding
- [ ] As a user, I can continue as anonymous, sign up with Google/Facebook/Phone/Email, or login to existing account
- [ ] As a new user, I can select my target exam category (ECAT, MCAT, CCAT, GMAT, GRE, SAT) during onboarding
- [ ] As a user, I can view my current tier limitations and usage statistics
- [ ] As an anonymous user, I am gracefully prompted to upgrade when I exhaust my limits
- [ ] As an anonymous user, my usage limits are tied to my current device only with no cross-device sync
- [ ] As a free/paid user, I can login on up to 3 devices maximum (tracked via device fingerprinting)
- [ ] As a free/paid user, my progress and session data syncs across all my connected devices
- [ ] As a user, I can view and manage my connected devices in account settings
- [ ] As a user, I receive notifications when attempting to login on a 4th device with options to replace an existing device

### Question Bank & Content Management
- [ ] As a user, I can access 10,000+ MCQs across all supported exam categories
- [ ] As a content creator, I can add question variations with different variable values and arrangements
- [ ] As a user, I can view detailed explanations (text/video) for each question after attempting (subject to tier limits)
- [ ] As a user, I can access AI-powered follow-up tutoring for conceptual discussions (subject to explanation limits)
- [ ] As a system, I track question popularity to prioritize variation creation
- [ ] As a system, I enforce daily explanation limits: 2 for anonymous, 4 for free, unlimited for paid users
- [ ] As a user, I can see ARDE probability indicators for each question to understand exam relevance
- [ ] As a user, I can view historical frequency data showing how often questions appeared on real exams

### Practice Mode
- [ ] As a user, I can practice MCQs by subject, topic, difficulty level, ARDE probability, and performance history
- [ ] As a user practicing, I get immediate feedback and up to 3 attempts per question
- [ ] As a user, I can view step-by-step solutions and video explanations after each attempt (subject to tier limits)
- [ ] As a user, I can access AI-powered follow-up tutoring for conceptual discussions (subject to explanation limits)
- [ ] As a user, I can bookmark difficult questions for later review
- [ ] As a user, I can filter questions by "High ARDE Probability" or "Frequently Asked on Real Exams"
- [ ] As a user, I can prioritize practice sessions based on question importance for actual exams
- [ ] As an anonymous user, I'm limited to 20 daily practice MCQs and 2 answer explanations per day
- [ ] As a free user, I get 50 daily practice MCQs and 4 answer explanations per day for 2 weeks
- [ ] As a paid user, I have unlimited daily practice access and unlimited answer explanations

### Sprint Exams (SE)
- [ ] As a user, I can create custom sprint exams with 5-50 questions and configurable time limits
- [ ] As a user, I can select specific topics, difficulty distributions, and ARDE probability levels for my sprint
- [ ] As a user taking a sprint, I don't see answer feedback until completion
- [ ] As a user, I receive detailed scorecards and analytics after sprint completion
- [ ] As a system, I track precise timing for each question attempt during sprints
- [ ] As a user, I can create "High-Probability" sprints focusing on questions most likely to appear on ARDE
- [ ] As an anonymous user, I'm limited to 1 sprint exam before requiring signup
- [ ] As a free user, I get 4 sprint exams total during my 2-week trial
- [ ] As a paid user, I have unlimited sprint exam access

### Simulated Real Exams (SRE)
- [ ] As a user, I can take full-length simulated exams matching actual ARDE conditions
- [ ] As a user, I experience exact timing, question count, marking schemes, and break intervals
- [ ] As a user, I receive comprehensive performance analysis after SRE completion with ARDE probability insights
- [ ] As a user, I can see what percentage of my SRE focused on high-probability vs. low-probability questions
- [ ] As an anonymous user, I get 1 half-length SRE before requiring signup
- [ ] As a free user, I get 2 full-length SREs during my trial period
- [ ] As a paid user, I have unlimited SRE access

### Analytics & Performance Tracking
- [ ] As a user, I can view detailed analytics on my question attempt patterns
- [ ] As a user, I can see time-to-first-answer, total attempts, and accuracy rates per topic
- [ ] As a user, I can identify my strongest and weakest subject areas
- [ ] As a user, I can track my improvement over time with historical performance data
- [ ] As a system, I maintain separate databases for learning analytics vs. general app usage
- [ ] As a user, I can export my performance data for external analysis
- [ ] As a user, I can see what percentage of my practice time focuses on high-ARDE-probability questions
- [ ] As a user, I can view my performance specifically on questions that frequently appear on real exams
- [ ] As a user, I can get strategic recommendations on which question types to prioritize based on ARDE data

### Business Intelligence & Analytics
- [ ] **User Engagement Metrics**: Track page/feature time spent, feature usage frequency, session duration & frequency, and user flow analysis for funnel optimization
- [ ] **Conversion & Business Metrics**: Monitor tier progression rates, churn analysis, feature adoption patterns, and revenue per user by acquisition channel
- [ ] **Content Performance**: Analyze question popularity, explanation usage patterns, AI tutoring interaction topics, and error rates across question bank
- [ ] **Product Optimization**: Performance monitoring for API response times and crash rates, A/B testing framework for pricing/UI changes, and seasonal usage pattern analysis for capacity planning

### Study Plans & Curriculum
- [ ] As a user, I can access multi-week structured study plans based on my target ARDE date
- [ ] As a user, I can accelerate my study plan when time is limited before my exam
- [ ] As a user, I receive daily goals and progress tracking within my study plan
- [ ] As a paid user, I can access personalized recommendations based on my weak areas and ARDE probability data
- [ ] As a user, I can compare my current performance against my historical baseline
- [ ] As a user with limited time, I can access "Strategic Mode" that prioritizes high-ARDE-probability questions
- [ ] As a user, my study plan automatically adjusts to focus more on high-probability topics as my ARDE date approaches

### Social Accountability & Competition
- [ ] As a user, I can view leaderboards showing top performers in my exam category
- [ ] As a user, I can create or join study groups with friends or other students
- [ ] As a user, I can view my group members' performance and progress (with their consent)
- [ ] As a user, I can compete in weekly/monthly challenges with other users
- [ ] As a user, I can share my achievements and milestones on social platforms
- [ ] As a group member, I can see comparative analytics showing my performance vs. group average
- [ ] As a user, I receive motivational notifications about peer achievements and challenges
- [ ] As a user, I can set group study goals and track collective progress
- [ ] As a user, I can see how my group performs on high-ARDE-probability questions compared to other groups

### Content Quality & User Support
- [ ] As a content creator, I am responsible for question accuracy and quality control
- [ ] As a user, I can report incorrect questions or submit answer corrections through in-app system
- [ ] As a user, I can access in-app help system and customer support phone number with human assistance
- [ ] As an admin, I can review and process user-submitted question corrections
- [ ] As a system, I track user reports to identify problematic content for review

### Admin & Content Creator Tools
- [ ] As an admin, I can access a comprehensive dashboard for managing questions and variations
- [ ] As a content creator, I can view analytics on question performance and user interaction
- [ ] As an admin, I can bulk upload, edit, and manage question bank content
- [ ] As a content creator, I can track which questions need more variations based on popularity
- [ ] As an admin, I can manage user accounts, subscriptions, and support requests
- [ ] As a content creator, I can update ARDE probability and frequency data for questions
- [ ] As an admin, I can analyze which high-probability questions are underrepresented in the question bank

### Learning Center & Expert Content
- [ ] As a paid user, I can access video content, written guides, and interactive lessons
- [ ] As a user, I can browse tips and tricks from subject matter experts
- [ ] As a user, I can search for specific topics or question types in the learning center
- [ ] As a user, I can bookmark and organize learning center content
- [ ] As a user, I can access strategic guides on prioritizing study time based on ARDE probability data

### Monetization & Subscription Management
- [ ] As a user, I can upgrade from anonymous to free tier seamlessly
- [ ] As a user, I can upgrade from free to paid tier through Paddle.com integration
- [ ] As a free user, I see ads after every 5 practice MCQs (time excluded from tracking)
- [ ] As a paid user, I see minimal ads (every 5 practice MCQs) and only one ad per simulated real exam or sprint exam (time excluded from tracking)
- [ ] As an admin, I can manage subscription tiers and pricing through Paddle.com

### UX/UI Considerations

#### Onboarding Flow
- [ ] **Welcome Screen**: Clean, exam-focused design with clear tier explanations and ARDE intelligence highlights
- [ ] **Exam Selection**: Visual exam category selector with brief descriptions and ARDE data availability indicators
- [ ] **Anonymous vs. Signup**: Prominent anonymous option with clear upgrade path and ARDE feature previews

#### Practice Interface
- [ ] **Question Display**: Clean MCQ layout with timer, progress indicator, attempt counter, explanation limit indicator, and ARDE probability badge
- [ ] **Answer Selection**: Clear visual feedback for selected answers
- [ ] **Immediate Feedback State**: Green/red highlighting with explanation panel (if explanations remaining)
- [ ] **Explanation Overlay**: Expandable panel with text/video content, AI chat option (subject to daily limits), and ARDE context
- [ ] **Explanation Limit Notification**: Gentle reminder when approaching daily explanation limit with upgrade suggestion
- [ ] **ARDE Probability Indicator**: Visual badges showing question importance (High/Medium/Low probability)
- [ ] **Strategic Filtering**: Easy-access filters for ARDE probability and historical frequency

#### Sprint Exam Interface
- [ ] **Pre-Sprint Setup**: Intuitive configuration with visual question/time selectors and ARDE probability distribution controls
- [ ] **Sprint Mode**: Focused, distraction-free interface with prominent timer and optional ARDE probability indicators
- [ ] **Sprint Results**: Comprehensive scorecard with interactive performance breakdown and ARDE probability analysis
- [ ] **Question Review**: Post-sprint detailed review with filtering, search, and ARDE probability insights

#### Analytics Dashboard
- [ ] **Performance Overview**: Chart-heavy dashboard with key metrics highlighted and ARDE probability performance tracking
- [ ] **Topic Breakdown**: Interactive subject/topic performance visualization with ARDE probability weighting
- [ ] **Historical Trends**: Time-series graphs showing improvement trajectories and strategic question focus
- [ ] **Recommendations Panel**: AI-driven suggestions with actionable next steps prioritized by ARDE probability
- [ ] **Strategic Insights**: Dedicated section showing ARDE probability performance and study time optimization

#### Social Features Interface
- [ ] **Leaderboards**: Clean, filterable rankings by exam type, timeframe, and performance metrics including ARDE-focused challenges
- [ ] **Group Dashboard**: Collaborative space showing group member progress and shared goals with strategic insights
- [ ] **Challenge Cards**: Engaging weekly/monthly competition displays with progress tracking and ARDE probability themes
- [ ] **Achievement Notifications**: Celebratory popups for personal and peer milestones including strategic study achievements
- [ ] **Comparative Analytics**: Side-by-side performance charts showing user vs. group/global averages with ARDE probability breakdowns

#### Upgrade Prompts
- [ ] **Gentle Nudges**: Non-intrusive upgrade suggestions with clear value propositions emphasizing ARDE intelligence features
- [ ] **Limit Reached**: Friendly limit notifications with immediate upgrade options highlighting strategic study benefits
- [ ] **Feature Previews**: Sneak peeks of premium features including advanced ARDE probability tools

### Non-Functional Requirements

#### Performance
- [ ] **Response Time**: API responses under 200ms for question loading including ARDE metadata
- [ ] **Image Optimization**: Standard compression for question images with lazy loading
- [ ] **Caching Strategy**: Intelligent question bank caching for frequently accessed content and ARDE probability data

#### Scalability
- [ ] **Database Design**: Optimized for 10,000+ questions with complex querying including ARDE probability filtering
- [ ] **Auto-scaling**: Firebase Functions auto-scale during seasonal exam periods
- [ ] **CDN Integration**: Global content delivery for video explanations and images
- [ ] **Load Testing**: Support for concurrent users during peak exam seasons

#### Security
- [ ] **Device Management**: 3-device limit per account tracked via Flutter device_info_plus package fingerprinting for registered users only
- [ ] **Anonymous User Tracking**: Device-specific session limits without cross-device sync or compromising privacy
- [ ] **Payment Security**: PCI-compliant payment processing through Paddle.com
- [ ] **API Security**: Rate limiting and authentication for all backend endpoints

#### Accessibility
- [ ] **Screen Reader Support**: Full compatibility with accessibility tools
- [ ] **High Contrast Mode**: Alternative color schemes for visual impairments
- [ ] **Font Scaling**: Adjustable text sizes for improved readability
- [ ] **Keyboard Navigation**: Complete app functionality without touch/mouse input

## Technical Architecture

### Frontend Stack
- **Framework**: Flutter with Dart
- **State Management**: Riverpod for reactive state management
- **Navigation**: Flutter's built-in routing with deep linking support
- **Local Storage**: Hive for limited offline question caching and user preferences
- **Device Identification**: device_info_plus package for device fingerprinting and multi-device management

### Backend Stack
- **API Framework**: Python FastAPI for high-performance REST APIs
- **Hosting**: Firebase Functions for serverless Python execution
- **Database**: Cloud Firestore for real-time data synchronization
- **File Storage**: Firebase Storage for video content and images
- **Authentication**: Firebase Auth with Google/Facebook/Phone/Email providers

### Third-Party Integrations
- **Analytics**: Google Analytics for app usage insights plus Firebase Crashlytics for error tracking
- **Payments & Subscriptions**: Paddle.com for complete payment processing
- **Advertising**: Google AdSense for monetizing free tier users
- **Content Delivery**: Firebase CDN for global content distribution

### Data Architecture
- **Question Bank**: Structured collections with tagging, difficulty metadata, per-user appearance tracking, appearance probability on ARDE, and reported frequency of appearance on ARDE
- **User Performance**: Separate analytical database for learning insights with ARDE probability performance tracking
- **Content Management**: Version-controlled system for question variations, explanations, and ARDE probability updates

## Monetization

**Revenue Streams:**
1. **Primary**: Monthly/Annual subscriptions through Paddle.com (PKR 2,000/month, PKR 20,000/year)
2. **Secondary**: Google AdSense revenue from free tier users

**Conversion Funnel:**
- Anonymous users → Free users (through usage limits and ARDE feature previews)
- Free users → Paid users (through 2-week trial expiration and strategic study feature access)

**Customer Lifetime Value Strategy:**
- High engagement through personalized study plans with ARDE intelligence
- Seasonal retention during exam periods with strategic preparation tools
- Word-of-mouth growth through exam success stories and improved scores

**Pricing Strategy:**
- Competitive with private tutoring (1/10th the cost)
- Premium pricing justified by comprehensive analytics, expert content, and exclusive ARDE probability insights
- Regional pricing adjustments for developing markets