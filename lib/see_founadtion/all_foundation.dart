import 'package:charity/src/features/home/cubits/foundations_cubit.dart';
import 'package:charity/src/features/home/models/foundation_model.dart';
import 'package:charity/src/features/home/widgets/foundation_card.dart';
import 'package:charity/src/shared/routing/app_routs.dart';
import 'package:charity/src/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllFoundation extends StatelessWidget {
  AllFoundation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'all foundation',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[300],
        centerTitle: true,
        foregroundColor: AppColors.primaryColor.shade50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<FoundationCubit, FoundationsState>(
                builder: (context, state) {
                  if (state is FoundationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is FoundationsLoaded) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
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
                          child: FoundationCard(foundation: foundation),
                        );
                      },
                    );
                  }

                  if (state is FoundationsError) {
                    return Center(child: Text(state.message));
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
