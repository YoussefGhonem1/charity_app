import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'ما هي المؤسسات التي يتعامل معها التطبيق؟',
      'answer': 'يتعامل التطبيق مع مجموعة من المؤسسات الخيرية الموثوقة والمسجلة رسمياً. يتم التحقق من شفافية هذه المؤسسات بشكل دوري لضمان وصول التبرعات لمستحقيها بالكامل. يمكنك مراجعة قائمة "الجمعيات" على الشاشة الرئيسية.',
    },
    {
      'question': 'كيف أضمن أن تبرعي وصل إلى الحملة الصحيحة؟',
      'answer': 'التطبيق يستخدم نظام تتبع متكامل لكل معاملة، مدعوم بقاعدة بيانات Firebase. يتم ربط تبرعك مباشرة برقم الحملة، ويمكنك متابعة إجمالي المبلغ الذي تم جمعه للحملة في صفحتها الرئيسية.',
    },
    {
      'question': 'هل يمكنني التبرع كشخص مجهول؟',
      'answer': 'نعم، يوفر التطبيق خيار "التبرع كمجهول". يمكنك تفعيل هذا الخيار من صفحة "إعدادات" ضمن قسم "إدارة الملف الشخصي"، وبذلك لن يظهر اسمك في قائمة المتبرعين للحملة.',
    },
    {
      'question': 'ما هي طرق الدفع المتاحة؟',
      'answer': 'نقبل الدفع عبر محفظة التبرعات الخاصة بك، وبطاقات الائتمان (Visa/Mastercard)، وخيارات الدفع الإلكتروني الشهيرة مثل PayPal و Google Pay و Apple Pay لسهولة العملية.',
    },
    {
      'question': 'هل يتم خصم أي رسوم من مبلغ التبرع؟',
      'answer': 'نحن نلتزم بأن يصل المبلغ كاملاً للمؤسسة الخيرية. التطبيق يغطي رسوم المعاملات المصرفية الخاصة به (إن وجدت)، ولكن قد تطبق رسوم بسيطة من جهة الدفع الخاصة بك (مثل البنك أو بطاقة الائتمان) وهي خارج سيطرتنا.',
    },
    {
      'question': 'ما الفرق بين حاسبة الزكاة وحاسبة التبرع؟',
      'answer': 'حاسبة الزكاة (Zakat Calculator) هي أداة شرعية تساعدك في تحديد المبلغ الواجب عليك دفعه كزكاة مال. أما حاسبة التبرع فهي أداة اختيارية تساعدك في تحديد مبلغ التبرع الذي ترغب في دفعه لأي حملة.',
    },
    {
      'question': 'كيف يمكنني إضافة حملة تبرع جديدة؟',
      'answer': 'من صفحة "إدارة الملف الشخصي"، يمكنك اختيار "إضافة حملة". يتم إرسال طلبك للمراجعة والتحقق من مصداقية المنظمة التابعة لها قبل أن يتم تفعيل الحملة في التطبيق.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(t.translate('faq_title')),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: faqs.map((faq) {
          return Card(
            elevation: 1,
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ExpansionTile(
                iconColor: AppColors.primaryColor,
                collapsedIconColor: Colors.grey,
                title: Text(
                  faq['question']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.right,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      faq['answer']!,
                      style: const TextStyle(fontSize: 15, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}