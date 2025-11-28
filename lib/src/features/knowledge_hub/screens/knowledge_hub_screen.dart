import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class KnowledgeHubScreen extends StatelessWidget {
  const KnowledgeHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('knowledge_hub')),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureCard(
            context: context,
            title: t.translate('zakat_guidelines'),
            subtitle: 'تعرّف على أحكام وشروط الزكاة في مختلف الأصول.',
            icon: Icons.auto_stories,
            color: Colors.green.shade700,
            onTap: () => Navigator.pushNamed(context, Routes.zakatTopics),
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context: context,
            title: t.translate('success_stories'),
            subtitle: 'شاهد الأثر الحقيقي لتبرعاتك من خلال قصصنا.',
            icon: Icons.star_border,
            color: Colors.blue.shade700,
            onTap: () => Navigator.pushNamed(context, Routes.successStories),
          ),
          const SizedBox(height: 16),
          _buildFeatureCard(
            context: context,
            title: t.translate('faq_title'),
            subtitle: 'إجابات على أسئلتك حول التبرع وحسابات التطبيق.',
            icon: Icons.help_outline,
            color: Colors.orange.shade700,
            onTap: () => Navigator.pushNamed(context, Routes.faq),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}