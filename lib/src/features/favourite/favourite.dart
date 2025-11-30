import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:charity/src/shared/localization/app_translations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:charity/src/features/favourite/cubits/favourite_cubit.dart';
import 'package:charity/src/shared/routing/app_routs.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppTranslations.of(context);
    final theme = Theme.of(context);
    
    return BlocProvider(
      create: (context) => FavouriteCubit()..loadFavourites(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.favourite,
                      style: TextStyle(
                        color: theme.textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<FavouriteCubit, FavouriteState>(
                  builder: (context, state) {
                    if (state is FavouriteLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is FavouriteError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.message,
                              style: TextStyle(color: Colors.red),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                context.read<FavouriteCubit>().loadFavourites();
                              },
                              child: Text(t.translate('try_again')),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is FavouriteLoaded) {
                      if (state.campaigns.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                t.translate('no_favourites'),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: state.campaigns.length,
                        itemBuilder: (context, index) {
                          final campaign = state.campaigns[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                Routes.donationPage,
                                arguments: campaign,
                              );
                            },
                            child: Card(
                              elevation: 2.0,
                              color: theme.cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              margin: const EdgeInsets.only(bottom: 20.0),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: (campaign.imageUrl.isNotEmpty)
                                              ? Image.network(
                                                  campaign.imageUrl,
                                                  height: 110,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/image1170x530cropped.jpg',
                                                  height: 110,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<FavouriteCubit>()
                                                .toggleFavourite(campaign, null);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5.0),
                                            padding: const EdgeInsets.all(4.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white.withValues(alpha: 0.9),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.favorite,
                                              color: AppColors.primaryColor,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: SizedBox(
                                        height: 110,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              campaign.title,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: theme.textTheme.bodyLarge?.color,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  t.translate('by'),
                                                  style: TextStyle(color: Colors.grey),
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  campaign.organization,
                                                  style: TextStyle(
                                                    color: AppColors.primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(width: 4.0),
                                                Icon(
                                                  Icons.verified_outlined,
                                                  color: AppColors.primaryColor,
                                                  size: 16,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      t.translate('raised'),
                                                      style: TextStyle(
                                                        color: Colors.grey[600],
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${(campaign.progress * 100).toInt()}%',
                                                      style: TextStyle(
                                                        color: theme.textTheme.bodyLarge?.color,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4.0),
                                                LinearProgressIndicator(
                                                  value: campaign.progress,
                                                  backgroundColor: Colors.grey[300],
                                                  color: AppColors.primaryColor,
                                                  minHeight: 8,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
