import 'package:charity/src/features/create_account/cubits/user_cubit.dart';
import 'package:charity/src/features/create_account/models/users_models.dart';
import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/home/widgets/foundation_card.dart';
import 'package:charity/src/features/favourite/cubits/favourite_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../category_details/category_details.dart';
import '../cubits/campaign_cubit.dart';
import '../widgets/feature_campaign_card.dart';
import '../widgets/lastest_campaign_card.dart';
import '../widgets/category_chip.dart';
import '../models/category_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  static final List<CategoryModel> categories = [
    CategoryModel('Education'),
    CategoryModel('Health'),
    CategoryModel('Food'),
    CategoryModel('Shelter'),
    CategoryModel('Clothes'),
    CategoryModel('Emergency'),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              if (user == null)
                return const Center(child: CircularProgressIndicator());
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: (user.avatarUrl.isNotEmpty)
                        ? NetworkImage(user.avatarUrl)
                        : null,
                    radius: 24,
                    child: (user.avatarUrl.isEmpty)
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${t.hello}, ${user.firstName} ${user.lastName}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                      Text(
                        "${t.donated} \$${user.donatedAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          BlocBuilder<UserCubit, UserModel?>(
            builder: (context, user) {
              if (user == null) return const SizedBox.shrink();
              return Card(
                color: const Color(0xFFFE7277),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.donationWallet,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "\$${user.wallet.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          t.topUp,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),


          Text(
            t.translate('categories') ?? 'categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.categoryDetails,
                      arguments: category.name,
                      );
                  },
                  child: CategoryChip(category: category),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              if (state is CampaignsLoading)
                return const Center(child: CircularProgressIndicator());
              if (state is CampaignsLoaded) {
                final featureCampaigns = state.campaigns;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.featureCampaigns,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: featureCampaigns.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final campaign = featureCampaigns[index];
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
                                    return FeatureCampaignCard(
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
                    ),
                  ],
                );
              }
              if (state is CampaignsError)
                return Center(
                    child: Text('${t.translate('error')}: ${state.message}'));
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          Text(
            t.foundations,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 240,
            child: BlocBuilder<FoundationCubit, FoundationsState>(
              builder: (context, state) {
                if (state is FoundationsLoading)
                  return const Center(child: CircularProgressIndicator());
                if (state is FoundationsLoaded) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.foundations.length,
                    itemBuilder: (context, index) {
                      final foundation = state.foundations[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.foundationPage,
                            arguments: foundation,
                          );
                        },
                        child: SizedBox(
                          width: 200,
                          child: FoundationCard(foundation: foundation),
                        ),
                      );
                    },
                  );
                }
                if (state is FoundationsError)
                  return Center(
                      child: Text('${t.translate('error')}: ${state.message}'));
                return const SizedBox();
              },
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<CampaignsCubit, CampaignsState>(
            builder: (context, state) {
              if (state is CampaignsLoading)
                return const Center(child: CircularProgressIndicator());
              if (state is CampaignsLoaded) {
                final latestCampaigns = state.campaigns;
                final displayedCampaigns = latestCampaigns.length > 4
                    ? latestCampaigns.sublist(0, 4)
                    : latestCampaigns;
                bool showAll = false;
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.latestCampaigns,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: showAll
                              ? latestCampaigns.length
                              : displayedCampaigns.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.99,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            final campaign = showAll
                                ? latestCampaigns[index]
                                : displayedCampaigns[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.donationPage,
                                  arguments: campaign,
                                );
                              },
                              child:
                              BlocBuilder<FavouriteCubit, FavouriteState>(
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
                        const SizedBox(height: 10),
                        ContinueButton(
                          text: showAll ? t.showLess : t.seeAll,
                          onPressed: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              }
              if (state is CampaignsError)
                return Center(
                    child: Text('${t.translate('error')}: ${state.message}'));
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}