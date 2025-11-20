import 'package:charity/src/features/home/cubits/campaign_cubit.dart';
import 'package:charity/src/features/home/models/campaign_model.dart';
import 'package:charity/src/features/favourite/cubits/favourite_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/widgets/lastest_campaign_card.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsScreen({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFE7277),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          categoryName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CampaignsCubit, CampaignsState>(
        builder: (context, state) {
          if (state is CampaignsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CampaignsLoaded) {
            final filteredCampaigns = state.campaigns
                .where((campaign) => campaign.category == categoryName)
                .toList();

            if (filteredCampaigns.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t.translate('no_campaigns_found') ?? 'There are no campaigns in this category',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${filteredCampaigns.length} ${t.translate('campaigns') ?? 'campaigns'}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredCampaigns.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.99,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final campaign = filteredCampaigns[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.donationPage,
                          arguments: campaign,
                        );
                      },
                      child: BlocBuilder<FavouriteCubit, FavouriteState>(
                        builder: (context, favState) {
                          return FutureBuilder<bool>(
                            future: context
                                .read<FavouriteCubit>()
                                .isFavourite(campaign, null),
                            builder: (context, snapshot) {
                              final isFav = snapshot.data ?? false;
                              return LastestCampaignCard(
                                campaign: campaign,
                                isFavourite: isFav,
                                onFavouriteTap: () {
                                  context
                                      .read<FavouriteCubit>()
                                      .toggleFavourite(campaign, null);
                                },
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            );
          }

          if (state is CampaignsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 80,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${t.translate('error')}: ${state.message}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}