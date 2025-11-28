import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ZakatTopicsScreen extends StatelessWidget {
  const ZakatTopicsScreen({super.key});

  final List<String> zakatTopics = const [
    'زكاة المال والأموال النقدية',
    'زكاة الذهب والفضة والمجوهرات',
    'زكاة عروض التجارة والأعمال',
    'زكاة الأسهم والسندات الاستثمارية',
    'زكاة العقارات والأراضي المؤجرة',
    'زكاة الزروع والثمار (الإنتاج الزراعي)',
    'زكاة الديون (المستحقة على الغير)',
    'شروط وجوب الزكاة ومقدار النصاب',
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('zakat_guidelines')),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: zakatTopics.length,
        itemBuilder: (context, index) {
          final topic = zakatTopics[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: Icon(Icons.menu_book, color: Colors.green.shade700),
              title: Text(topic),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.zakatTopicDetail,
                  arguments: topic,
                );
              },
            ),
          );
        },
      ),
    );
  }
}