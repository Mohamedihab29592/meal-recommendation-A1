import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redacted/redacted.dart';
import '../../../../core/themes/app_text_styles.dart';

class LoadingSeeAllScreen extends StatelessWidget {
  LoadingSeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          ' Trending Recipes',
          style: AppTextStyles.font21BoldDarkBlue,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ShimmerTrendingRecipesItem(),
              );
            },
          ),
        ),
        Text(
          ' Recommended for you',
          style: AppTextStyles.font21BoldDarkBlue,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 11),
                child: ShimmerRecommendedRecipesItem(),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ShimmerTrendingRecipesItem extends StatelessWidget {
  const ShimmerTrendingRecipesItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
          child: AspectRatio(
            aspectRatio: 2.1 / 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'sssss',
            style: AppTextStyles.font21BoldDarkBlue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(
                'sssss',
                style: AppTextStyles.font14Regular.copyWith(fontSize: 12.sp),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                'sssss',
                style: AppTextStyles.font15MediumBlueGrey
                    .copyWith(fontSize: 12.sp),
              ),
            ],
          ),
        ),
      ],
    ).redacted(
      context: context,
      redact: true,
    );
  }
}

class ShimmerRecommendedRecipesItem extends StatelessWidget {
  const ShimmerRecommendedRecipesItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffDEDEDE), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 2.1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'sssss',
              style: AppTextStyles.font21BoldDarkBlue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  'sssss',
                  style: AppTextStyles.font15MediumBlueGrey,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'sssss',
                  style: AppTextStyles.font16Regular,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
                Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    ).redacted(
      context: context,
      redact: true,

    );
  }
}
