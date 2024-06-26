import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:solveconomy_simple/data/dictionary_data.dart';
import 'package:solveconomy_simple/general_widget/general_divider.dart';
import 'package:solveconomy_simple/themes/custom_color.dart';
import 'package:solveconomy_simple/themes/custom_decoration.dart';
import 'package:solveconomy_simple/themes/custom_font.dart';

class DictionaryDetailPage extends StatelessWidget {
  final DictionaryData dictionaryData;

  const DictionaryDetailPage({
    super.key,
    required this.dictionaryData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dictionaryData.word,
                        style: CustomTextStyle.title1,
                      ),
                      const Gap(defaultGapS / 2),
                      const GeneralDivider(),
                      const Gap(defaultGapS / 2),
                      Text(
                        dictionaryData.description,
                        style: CustomTextStyle.body2.copyWith(height: 1.375),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(defaultPaddingS),
                child: Text(
                  '출처: 경제금융용어 700선, 한국은행',
                  style: CustomTextStyle.caption1.copyWith(color: gray),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}