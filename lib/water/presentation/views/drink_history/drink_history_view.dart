import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../domain/entities/drink_record_entity.dart';
import '../../controllers/drink_history_controller.dart';

class DrinkHistoryView extends StatefulWidget {
  const DrinkHistoryView({super.key});

  @override
  State<DrinkHistoryView> createState() => _DrinkHistoryView();
}

class _DrinkHistoryView extends State<DrinkHistoryView> {
  final _controller = getIt<DrinkHistoryController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: _controller.records,
        builder: (context, records, _) {
          return Container(
            padding: const EdgeInsets.only(
              top: Spacing.huge,
              left: Spacing.small2,
              right: Spacing.small2,
            ),
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                DrinkRecordEntity record = records[index];

                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.darkGrey,
                        borderRadius: BorderRadius.circular(Sizes.borderRadius),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.small3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                CommunityMaterialIcons.water_plus,
                                size: Spacing.medium,
                                color: MyColors.lightGrey2,
                              ),
                              const SizedBox(width: Spacing.small2),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${record.amount} ml'),
                                  Text('${record.dateTime}'),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(left: BorderSide(width: 2)),
                            ),
                            padding:
                                const EdgeInsets.only(left: Spacing.small3, top: Spacing.small, bottom: Spacing.small),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(CupertinoIcons.delete, color: MyColors.lightGrey),
                                  padding: EdgeInsets.zero,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Spacing.small1),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
