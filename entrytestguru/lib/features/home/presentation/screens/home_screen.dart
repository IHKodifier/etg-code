// lib/screens/landing_page.dart
import 'package:flutter/material.dart' hide AppBar;
import '../../../../constants/app_constants.dart';
import '../../../../widgets/app_bar.dart';
import '../../../../widgets/navigation_rail.dart';
import '../widgets/hero_section.dart';
import '../widgets/features_section.dart';
import '../widgets/benefits_section.dart';
import '../widgets/pricing_section.dart';
import '../widgets/feature_comparison_table.dart';
import '../widgets/testimonial_section.dart';
import '../widgets/team_section.dart';
import '../widgets/gallery_section.dart';
import '../widgets/analytics_section.dart';
import '../widgets/blog_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (screenSize.width < minScreenWidth) {
      return Scaffold(
        backgroundColor: Colors.yellow,
        body: Center(
          child: SelectableText(
            'Screen size not supported. Please open this website on a larger screen.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    final isDesktop = screenSize.width > 768;
    final isTablet = screenSize.width > 576 && screenSize.width <= 768;

    if (isTablet) {
      // Tablet layout with navigation rail
      return Scaffold(
        body: Row(
          children: [
            AppNavigationRail(scrollController: _scrollController),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                slivers: const [
                  SliverToBoxAdapter(child: HeroSection()),
                  SliverToBoxAdapter(child: FeaturesSection()),
                  SliverToBoxAdapter(child: BenefitsSection()),
                  SliverToBoxAdapter(child: PricingSection()),
                  SliverToBoxAdapter(child: FeatureComparisonTable()),
                  SliverToBoxAdapter(child: TestimonialSection()),
                  SliverToBoxAdapter(child: TeamSection()),
                  SliverToBoxAdapter(child: GallerySection()),
                  SliverToBoxAdapter(child: AnalyticsSection()),
                  SliverToBoxAdapter(child: BlogSection()),
                  SliverToBoxAdapter(child: ContactSection()),
                  SliverToBoxAdapter(child: FooterSection()),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Desktop and mobile layout with app bar
      return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: const [
            AppBar(),
            SliverToBoxAdapter(child: HeroSection()),
            SliverToBoxAdapter(child: FeaturesSection()),
            SliverToBoxAdapter(child: BenefitsSection()),
            SliverToBoxAdapter(child: PricingSection()),
            SliverToBoxAdapter(child: FeatureComparisonTable()),
            SliverToBoxAdapter(child: TestimonialSection()),
            SliverToBoxAdapter(child: TeamSection()),
            SliverToBoxAdapter(child: GallerySection()),
            SliverToBoxAdapter(child: AnalyticsSection()),
            SliverToBoxAdapter(child: BlogSection()),
            SliverToBoxAdapter(child: ContactSection()),
            SliverToBoxAdapter(child: FooterSection()),
          ],
        ),
      );
    }
  }
}
