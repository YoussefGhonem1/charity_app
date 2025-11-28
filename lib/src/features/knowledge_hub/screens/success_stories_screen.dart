import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({super.key});

  final List<Map<String, String>> stories = const [
    {
      'title': 'بئر الأمل: توفير المياه لقرية كاملة',
      'subtitle': 'بفضل تبرعاتكم، اكتمل مشروع حفر البئر في إفريقيا.',
      'image':
          'https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Collections/Embargoed/13-12-2024-WFP-Syria-02.jpg/image1170x530cropped.jpg',
      'icon': 'water_drop',
    },
    {
      'title': 'مستقبل مضيء: بناء مدرسة جديدة',
      'subtitle': 'تم افتتاح مدرسة "النور" لتعليم 300 طالب محتاج.',
      'image':
          'https://m.gomhuriaonline.com/Upload/News/29-9-2023_21_34_45_GomhuriaOnline_12031696012485.jpg',
      'date': '2025/10/20',
      'icon': 'school',
    },
    {
      'title': 'شفاء وعلاج: قافلة طبية ناجحة',
      'subtitle': 'تجهيز قافلة طبية بالكامل لعلاج أكثر من 1000 مريض.',
      'image':
          'https://images.akhbarelyom.com/images/images/large/20241107203939124.jpg',
      'icon': 'medical_services',
    },
    {
      'title': 'سقف يحمي: ترميم منازل الأسر المتعففة',
      'subtitle': 'تم ترميم وتجديد 50 منزلاً قديماً في موسم الشتاء.',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UrT4WiYmlGx-gbrnX0uoNbqJyjGI0RAe8Q&s',
      'date': '2025/08/10',
      'icon': 'home',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('success_stories')),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                Routes.storyDetail,
                arguments: story['title'],
              );
            },
            child: _buildStoryCard(story),
          );
        },
      ),
    );
  }

  Widget _buildStoryCard(Map<String, String> story) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.network(
              story['image']!,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  story['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(
                  story['subtitle']!,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
