// lib/widgets/team_section.dart
import 'package:flutter/material.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 16,
        vertical: 80,
      ),
      child: Column(
        children: [
          Text(
            'The Team Behind Essentials',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
              // textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 64),
          _buildTeamGrid(context),
        ],
      ),
    );
  }

  Widget _buildTeamGrid(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 1024;
    final teamMembers = [
      _TeamMember('John Doe', 'CEO & Founder', Icons.person),
      _TeamMember('Jane Smith', 'CTO', Icons.person),
      _TeamMember('Mike Johnson', 'Lead Developer', Icons.person),
    ];

    if (isDesktop) {
      return Row(
        children: teamMembers
            .map(
              (member) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _buildTeamCard(context, member),
                ),
              ),
            )
            .toList(),
      );
    } else {
      return Column(
        children: teamMembers
            .map(
              (member) => Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: _buildTeamCard(context, member),
              ),
            )
            .toList(),
      );
    }
  }

  Widget _buildTeamCard(BuildContext context, _TeamMember member) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              member.icon,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            member.name,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member.role,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamMember {
  final String name;
  final String role;
  final IconData icon;

  _TeamMember(this.name, this.role, this.icon);
}
