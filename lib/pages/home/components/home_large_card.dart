import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:solveconomy_simple/data/dictionary_data.dart';
import 'package:solveconomy_simple/general_widget/general_divider.dart';
import 'package:solveconomy_simple/general_widget/general_shimmer.dart';
import 'package:solveconomy_simple/pages/dictionary/dictionary_detail_page.dart';
import 'package:solveconomy_simple/service/dictionary/dictionary_service.dart';
import 'package:solveconomy_simple/themes/custom_color.dart';
import 'package:solveconomy_simple/themes/custom_decoration.dart';
import 'package:solveconomy_simple/themes/custom_font.dart';

class HomeLargeCard extends StatefulWidget {
  final int randomIndex;

  const HomeLargeCard({
    super.key,
    required this.randomIndex,
  });

  @override
  State<HomeLargeCard> createState() => _HomeLargeCardState();
}

class _HomeLargeCardState extends State<HomeLargeCard> {
  late Future<List<DictionaryData>> _dictionaryData;

  @override
  void initState() {
    super.initState();
    _dictionaryData = Future.delayed(
      const Duration(milliseconds: 250),
      () => DictionaryService().loadDictionaryData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPaddingM,
        vertical: defaultPaddingS,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkWhite,
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Random Word', style: CustomTextStyle.title3),
          const Gap(defaultGapS / 2),
          const GeneralDivider(),
          const Gap(defaultGapS / 2),
          FutureBuilder(
            future: _dictionaryData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const GeneralShimmer(itemCount: 1);
              } else if (snapshot.hasError) {
                return const Center(child: Text('데이터를 불러오는 중 오류가 발생했습니다.'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('데이터가 없습니다.'));
              } else {
                final dictionaryData = snapshot.data!;
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => DictionaryDetailPage(
                          dictionaryData: dictionaryData[widget.randomIndex],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(dictionaryData[widget.randomIndex].word, style: CustomTextStyle.body1),
                      const Gap(defaultGapS),
                      Text(
                        dictionaryData[widget.randomIndex].description,
                        style: CustomTextStyle.body3,
                        textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      const Gap(defaultGapS),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '설명 더 보기',
                          style: CustomTextStyle.caption1.copyWith(color: gray),
                        ),
                      )
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
