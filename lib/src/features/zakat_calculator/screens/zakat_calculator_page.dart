import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ZakatCalculatorPage extends StatefulWidget {
  const ZakatCalculatorPage({super.key});

  @override
  State<ZakatCalculatorPage> createState() => _ZakatCalculatorPageState();
}

class _ZakatCalculatorPageState extends State<ZakatCalculatorPage> {
  final TextEditingController _wealthController = TextEditingController();
  final TextEditingController _goldPriceController = TextEditingController();
  double _zakatAmount = 0.0;
  bool _showResult = false;
  double _nisabThreshold = 0.0;
  final double _nisabGoldGrams = 85.0;
  final double _zakatRate = 0.025;
  final String _moreInfoUrl = 'https://www.ghirasalkhaeer.com/zakat-on-money/';

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لا يمكن فتح الرابط: $url'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _calculateZakat() {
    final double currentGoldPrice =
        double.tryParse(_goldPriceController.text) ?? 0.0;
    final double totalWealth = double.tryParse(_wealthController.text) ?? 0.0;

    if (currentGoldPrice <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال سعر صحيح لجرام الذهب'),
          backgroundColor: Colors.redAccent,
        ),
      );
      setState(() {
        _showResult = false;
      });
      return;
    }

    final double calculatedNisab = _nisabGoldGrams * currentGoldPrice;

    setState(() {
      _nisabThreshold = calculatedNisab;
      if (totalWealth >= _nisabThreshold) {
        _zakatAmount = totalWealth * _zakatRate;
      } else {
        _zakatAmount = 0.0;
      }
      _showResult = true;
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _wealthController.dispose();
    _goldPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسب زكاة المال'),
        backgroundColor: AppColors.primaryColor.shade100,
        foregroundColor: AppColors.primaryColor.shade800,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'حديث شريف عن زكاة المال:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.primaryColor.shade100),
                ),
                child: const Text(
                  'قال رسول الله صلى الله عليه وسلم: "حصنوا أموالكم بالزكاة، وداووا مرضاكم بالصدقة، وأعدوا للبلاء الدعاء". ',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'كيفية حساب زكاة المال:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 8),
              const Text(
                '1.  يجب أن يبلغ المال النصاب، وهو ما يعادل قيمة 85 جرامًا من الذهب الخالص.\n'
                '2.  يجب أن يحول على المال الحول، وهو مرور سنة هجرية كاملة على امتلاكه.\n'
                '3.  مقدار الزكاة الواجب إخراجها هو 2.5% (ربع العشر) من إجمالي المبلغ الذي بلغ النصاب وحال عليه الحول.\n'
                '4.  تشمل الأموال التي تجب فيها الزكاة: النقود، الذهب، الفضة، عروض التجارة، الأسهم (بشروطها)، وغيرها من الأموال النامية.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'لمزيد من المعلومات التفصيلية، يمكنك زيارة: ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700],
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'غراس الخير',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryColor.shade900,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL(_moreInfoUrl);
                        },
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),
              Text(
                'احسب زكاتك:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _goldPriceController,
                hintText: 'أدخل السعر الحالي لجرام الذهب (عيار 24)',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _wealthController,
                hintText: 'أدخل إجمالي المبلغ الخاضع للزكاة',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                ],
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
              if (_goldPriceController.text.isNotEmpty &&
                  (double.tryParse(_goldPriceController.text) ?? 0.0) > 0)
                Text(
                  'النصاب بناءً على السعر المُدخل: ${(_nisabGoldGrams * (double.tryParse(_goldPriceController.text) ?? 0.0)).toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.grey[600]),
                  textAlign: TextAlign.right,
                ),
              const SizedBox(height: 20),
              Center(
                child: ContinueButton(
                  onPressed: _calculateZakat,
                  text: 'احسب الزكاة',
                ),
              ),
              const SizedBox(height: 24),
              if (_showResult)
                Center(
                  child: Column(
                    children: [
                      Text(
                        'المبلغ المستحق للزكاة:',
                        style: theme.textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _zakatAmount.toStringAsFixed(2),
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColors.greenColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                      ),
                      if (_wealthController.text.isNotEmpty &&
                          (double.tryParse(_wealthController.text) ?? 0.0) <
                              _nisabThreshold &&
                          _nisabThreshold > 0)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '(المبلغ لم يبلغ النصاب)',
                            style: TextStyle(color: Colors.grey[700]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextDirection? textDirection;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: textAlign,
      textDirection: textDirection,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 15.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        filled: true,
        fillColor: AppColors.lightGrey,
        hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 17),
      ),
    );
  }
}
