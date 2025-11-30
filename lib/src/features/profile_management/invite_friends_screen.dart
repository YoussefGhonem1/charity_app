import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/create_account/cubits/user_cubit.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen();

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
  late final String _referralCode;
  late final String _referralLink;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>().state;
    final base = user?.uid ?? 'guest';
    _referralCode = base.substring(0, base.length >= 8 ? 8 : base.length).toUpperCase();
    _referralLink = 'https://charity.example/invite?code=$_referralCode';
  }

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(t.translate('invite_friends_title'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.translate('share_your_referral_link'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              t.translate('invite_friends_description'),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.greyShade(context)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.translate('your_code'),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _referralCode,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.translate('referral_link'),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  SelectableText(_referralLink),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _copyLink,
                          icon: const Icon(Icons.copy),
                          label: Text(t.translate('copy_link')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(48),
              ),
              onPressed: _copyLink,
              child: Text(t.translate('copy_and_share_later')),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyLink() async {
    final t = AppTranslations.of(context);
    await Clipboard.setData(ClipboardData(text: _referralLink));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.translate('referral_link_copied'))),
    );
  }
}


