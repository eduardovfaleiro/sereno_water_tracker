import 'package:community_material_icon/community_material_icon.dart';
import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../../domain/entities/drink_record_entity.dart';
import '../../controllers/drink_history_controller.dart';
import '../../utils/dialogs.dart';

class DrinkHistoryView extends StatefulWidget {
  const DrinkHistoryView({super.key});

  @override
  State<DrinkHistoryView> createState() => _DrinkHistoryView();
}

class _DrinkHistoryView extends State<DrinkHistoryView> {
  final _controller = getIt<DrinkHistoryController>();

  String _getDateTimeText(DateTime dateTime) {
    String padLeft(int time) => time.toString().padLeft(2, '0');

    String day = dateTime.isYesterday ? 'ontem' : 'hoje';
    String hourAndMin = '${padLeft(dateTime.hour)}:${padLeft(dateTime.minute)}';

    return '$day, $hourAndMin';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: _controller.records,
        builder: (drinkHistoryPageContext, records, _) {
          if (records.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/images/water_bottle.svg',
                      height: 200,
                      width: 200,
                    ),
                  ),
                  const Text(
                    'Não há nenhum registro pelo jeito.\nQue tal beber um pouco?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color.fromARGB(255, 197, 197, 197), fontSize: FontSize.small1),
                  ),
                ],
              ),
            );
          }

          return Container(
            padding: const EdgeInsets.only(top: Spacing.huge),
            child: Scrollbar(
              thickness: 0.5,
              radius: const Radius.circular(Sizes.borderRadius),
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  left: Spacing.small2,
                  right: Spacing.small2,
                ),
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
                                  size: Spacing.medium1,
                                  color: MyColors.lightGrey2,
                                ),
                                const SizedBox(width: Spacing.small2),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${record.amount} ml',
                                      style: const TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    Text(_getDateTimeText(record.dateTime)),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              decoration: const BoxDecoration(border: Border(left: BorderSide(width: 2))),
                              padding: const EdgeInsets.only(
                                left: Spacing.small3,
                                bottom: Spacing.small2,
                                top: Spacing.small2,
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(CupertinoIcons.delete, color: MyColors.lightGrey),
                                    padding: EdgeInsets.zero,
                                    visualDensity: VisualDensity.compact,
                                    onPressed: () async {
                                      await Dialogs.confirm(
                                        title: 'Remover registro?',
                                        text: 'A quantidade bebida será removida da quantidade atual.',
                                        context: context,
                                        onYes: () async {
                                          await _controller.remove(context, record);
                                          Navigator.pop(drinkHistoryPageContext);
                                        },
                                        onNo: () {
                                          Navigator.pop(context);
                                        },
                                        cancelText: 'Cancelar',
                                        confirmText: 'Sim, remover',
                                      );
                                    },
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
            ),
          );
        },
      ),
    );
  }
}
