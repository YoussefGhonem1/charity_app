import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StoryDetailScreen extends StatelessWidget {
  final String storyTitle;
  const StoryDetailScreen({super.key, required this.storyTitle});

  @override
  Widget build(BuildContext context) {
    final storyData = _getStaticStoryData(storyTitle);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                storyTitle,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              centerTitle: true,
              background: Image.network(
                storyData['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      storyTitle,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'تاريخ النشر: ${storyData['date']!}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      storyData['fullStory']!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(height: 1.8),
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        'شكراً لكل من ساهم في تحقيق هذا الأثر العظيم!',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: Colors.green.shade700,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Map<String, String> _getStaticStoryData(String title) {
    final defaultStory = {
      'image':
          'https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Collections/Embargoed/13-12-2024-WFP-Syria-02.jpg/image1170x530cropped.jpg',
      'date': '2025/11/28',
      'fullStory':
          'قصة النجاح هذه قيد التوثيق والتفصيل. لكن يمكننا تأكيد أن مساهماتكم لها أثر عظيم ومستمر في مساعدة آلاف العائلات حول العالم وتوفير الاحتياجات الأساسية لهم.',
    };

    if (title.contains('بئر الأمل')) {
      return {
        'image': 'https://img.youm7.com/large/201809111241224122.jpg',
        'date': '2025/11/15',
        'fullStory': '''
الحمد لله الذي بنعمته تتم الصالحات. بعد حملة استمرت لثلاثة أشهر، نجحنا في جمع المبلغ المستهدف لحفر بئر ارتوازي عميق في إحدى القرى التي تعاني من ندرة المياه. هذا المشروع لم يقتصر على توفير مياه الشرب النظيفة فحسب، بل ساهم أيضاً في إنعاش الحياة الزراعية وتوفير مصدر دخل مستدام للعائلات.

تلقينا صوراً وفيديوهات من فريقنا الميداني تُظهر فرحة الأطفال والنساء بوصول المياه النظيفة لأول مرة في حياتهم. هذا الإنجاز هو ثمرة تعاونكم وتبرعاتكم السخية. كل قطرة ماء تصل هي صدقة جارية في ميزان حسناتكم. شكراً لكونكم جزءاً من الأمل.
        ''',
      };
    } else if (title.contains('مستقبل مضيء')) {
      return {
        'image':
            'https://m.gomhuriaonline.com/Upload/News/29-9-2023_21_34_45_GomhuriaOnline_12031696012485.jpg',
        'date': '2025/10/20',
        'fullStory': '''
التعليم هو أساس التقدم، وبفضل دعمكم اللامحدود، تم الانتهاء من أعمال بناء وتجهيز مدرسة "النور" الجديدة بالكامل. هذه المدرسة مجهزة بأحدث الوسائل التعليمية وستفتح أبوابها لـ 300 طالب من الأيتام والأسر الأشد فقراً.

توفير بيئة تعليمية آمنة ومحفزة يضمن للأجيال القادمة فرصة أفضل لبناء مستقبلهم. إن تبرعاتكم التي رأيتموها في التطبيق تحولت إلى فصول دراسية، ومقاعد، وكتب، ومعلمين. نتوجه بجزيل الشكر لجميع المتبرعين الذين آمنوا بقوة العلم.
        ''',
      };
    } else if (title.contains('شفاء وعلاج')) {
      return {
        'image':
            'https://images.akhbarelyom.com/images/images/large/20241107203939124.jpg',
        'date': '2025/09/01',
        'fullStory': '''
في مناطق النزاعات والفقر، الرعاية الصحية تكون حلماً بعيد المنال. بفضل مساهماتكم في حملة "قافلة الشفاء"، تمكنا من تسيير قافلة طبية متكاملة شملت أطباء متخصصين وأدوية مجانية.

تم فحص وعلاج أكثر من 1000 حالة مرضية حرجة ومزمنة، وتم إجراء عمليات جراحية بسيطة أنقذت حياة العشرات. لقد أثبتنا معاً أن التكافل يصنع المعجزات. كل تبرع دفعتموه ساهم مباشرة في شراء دواء أو توفير جهاز طبي. حمى الله الجميع.
        ''',
      };
    } else if (title.contains('سقف يحمي')) {
      return {
        'image':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3UrT4WiYmlGx-gbrnX0uoNbqJyjGI0RAe8Q&s',
        'date': '2025/08/10',
        'fullStory': '''
مع اقتراب موسم الأمطار، كانت هناك عائلات كثيرة مهددة بالبرد والمخاطر بسبب تهالك منازلهم. حملة "سقف يحمي" نجحت في ترميم 50 منزلاً بشكل كامل، وتوفير العزل الحراري والأسقف الآمنة.

هذه البيوت لم تعد مجرد جدران، بل أصبحت ملاذاً آمناً يحفظ كرامة الأسر ويوفر لهم الدفء. نُشكر المتبرعين الذين جعلوا هذا الدفء حقيقة. تبرعكم هو جدار صلب يحمي الضعفاء من قسوة الظروف.
        ''',
      };
    }
    return defaultStory;
  }
}
