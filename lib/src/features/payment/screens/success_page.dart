import 'package:charity/src/features/home/models/campaign_model.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/home/cubits/campaign_cubit.dart';

class SuccessPage extends StatefulWidget {
  final CampaignModel campaign;
  final double amount;
  const SuccessPage({super.key, required this.campaign, required this.amount});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  late ConfettiController _confettiController;
  bool _isProcessing = true; 

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    _confettiController.play();
    _processDonation();
  }

  Future<void> _processDonation() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User is not logged in.");
      }

      final double donationAmount = widget.amount;
      final CampaignModel campaign = widget.campaign;

      final campaignRef = FirebaseFirestore.instance
          .collection('campaigns')
          .doc(campaign.id);
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final transactionRef =
          userRef.collection('transactions').doc();

      final double newCurrentAmount = campaign.currentAmount + donationAmount;
      final double newProgress =
          (newCurrentAmount / campaign.amount).clamp(0.0, 1.0);

      final batch = FirebaseFirestore.instance.batch();

      batch.update(campaignRef, {
        'currentAmount': newCurrentAmount,
        'progress': newProgress,
        'donatedAmount':
            FieldValue.increment(1), 
      });

      batch.update(userRef, {
        'donatedAmount':
            FieldValue.increment(donationAmount), 
      });

      batch.set(transactionRef, {
        'title': 'Donation to ${campaign.title}',
        'amount': donationAmount,
        'date': Timestamp.now(),
        'dateMs': DateTime.now().millisecondsSinceEpoch,
        'campaignId': campaign.id,
      });

      await batch.commit();

      if (mounted) {
        context.read<UserCubit>().loadUserData();
        context.read<CampaignsCubit>().fetchCampaigns();
      }
    } catch (e) {
      print("Error processing donation: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false; 
        });
      }
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 100,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Success',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Thank you for donating \$${widget.amount.toStringAsFixed(2)}!',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: _isProcessing
                          ? null
                          : () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.layout,
                                (route) => false, 
                              );
                            },
                      child: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 18,
                                color: AppColors.bgColor,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: (size) {
                final path = Path();
                path.addOval(Rect.fromCircle(center: Offset.zero, radius: 8));
                return path;
              },
            ),
          ],
        ),
      ),
    );
  }
}
