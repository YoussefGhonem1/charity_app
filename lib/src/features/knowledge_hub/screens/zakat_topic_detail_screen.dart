import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ZakatTopicDetailScreen extends StatelessWidget {
  final String topic;
  const ZakatTopicDetailScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // محتوى ثابت افتراضي
    final String content = _getStaticContent(topic);

    return Scaffold(
      appBar: AppBar(
        title: Text(topic, maxLines: 1, overflow: TextOverflow.ellipsis),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                'الزكاة ركن أساسي في الإسلام، وهي تطهير للنفس والمال وتنمية للمجتمع.',
                style: TextStyle(color: Colors.green.shade800, fontStyle: FontStyle.italic),
                textAlign: TextAlign.right,
              ),
            ),
            
            Text(
              'تفاصيل ${topic}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.8),
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  String _getStaticContent(String topic) {
    switch (topic) {
      case 'زكاة المال والأموال النقدية':
        return '''
تجب الزكاة في الأموال النقدية التي بلغت النصاب وحال عليها الحول (مرور سنة هجرية كاملة). 
النصاب هو ما يعادل قيمة 85 جرامًا من الذهب الخالص. ومقدار الزكاة الواجب هو 2.5% من إجمالي المبلغ.
يشمل ذلك الودائع البنكية، والمدخرات، والأموال الموجودة في الحسابات الجارية التي لا يحتاجها صاحبها لنفقاته الأساسية في الحال. يجب الحساب بدقة عند نهاية الحول.
        ''';
      case 'زكاة الذهب والفضة والمجوهرات':
        return '''
تجب الزكاة في الذهب والفضة إذا بلغا النصاب وحال عليهما الحول. نصاب الذهب هو 85 جرامًا، ونصاب الفضة هو 595 جرامًا.
الزكاة تكون بنسبة 2.5% من قيمة المعدن. بالنسبة للمجوهرات، إذا كانت للاقتناء والاستعمال الشخصي (غير المحرم)، فلا تجب فيها الزكاة في قول الجمهور، أما إذا كانت للتجارة أو الادخار، فتجب فيها الزكاة.
        ''';
      case 'زكاة عروض التجارة والأعمال':
        return '''
عروض التجارة هي كل ما أُعدّ للبيع والشراء بقصد الربح، كالبضائع والمواد الخام والأجهزة. تجب الزكاة فيها إذا بلغت قيمتها النصاب وحال عليها الحول، وتُقوّم بسعر السوق عند نهاية الحول، ثم تخرج الزكاة بنسبة 2.5% من قيمتها.
        ''';
      case 'زكاة الأسهم والسندات الاستثمارية':
        return '''
زكاة الأسهم تختلف حسب نية المستثمر. إذا كانت للاستثمار طويل الأجل والاستفادة من العائد السنوي، فيُزكى العائد السنوي فقط. وإذا كانت للمضاربة (البيع والشراء السريع)، فتُزكى كعروض تجارة بقيمة الأسهم السوقية وقت وجوب الزكاة بنسبة 2.5%.
        ''';
      case 'زكاة العقارات والأراضي المؤجرة':
        return '''
العقارات والوحدات السكنية التي تُؤجر للاستفادة من ريعها، لا تجب الزكاة في قيمة الأصل (العقار نفسه)، وإنما تجب الزكاة في الإيجار (الأموال النقدية المستلمة) إذا بلغت النصاب وحال عليها الحول. أما إذا كانت معدة للبيع، فتزكى كعروض تجارة.
        ''';
      case 'زكاة الزروع والثمار (الإنتاج الزراعي)':
        return '''
تجب الزكاة في كل ما يُزرع ويُحصد مما يُقصد به الاقتيات (كالحبوب والتمر). ولا يشترط الحول فيها، بل تُزكى عند الحصاد. المقدار الواجب هو 10% مما يُسقى بلا كلفة (كالري بماء المطر)، و5% مما يُسقى بكلفة (كالري بالآلات).
        ''';
      case 'زكاة الديون (المستحقة على الغير)':
        return '''
الديون التي لك على الغير (القروض أو المبالغ المستحقة)، إذا كانت على مُقرٍّ مليء (قادر على السداد)، فتجب الزكاة عليها عند قبضها عن كل سنة مضت. أما الديون على مُعسر أو مُنكر، فلا زكاة فيها حتى تُقبض، ثم تُزكى لسنة واحدة فقط.
        ''';
      case 'شروط وجوب الزكاة ومقدار النصاب':
        return '''
للزكاة شروط أربعة أساسية: 1. الإسلام: لا تجب على غير المسلم. 2. الحرية: (لا تجب على العبد). 3. ملك النصاب: أن يبلغ المال الحد الأدنى للوجوب، وهو ما يعادل 85 جراماً من الذهب الخالص. 4. تمام الحول: مرور سنة قمرية كاملة على ملك المال دون نقصان عن النصاب.
        ''';
      default:
        return 'هذا الموضوع قيد الإعداد، يرجى مراجعة المواضيع الأخرى.';
    }
  }
}