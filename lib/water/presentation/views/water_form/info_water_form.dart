import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/themes.dart';
import '../../controllers/water_form_controller.dart';
import '../../utils/bottom_sheets.dart';
import '../../widgets/buttons/button.dart';
import '../../widgets/my_text_fields.dart';

class InfoWaterForm extends StatelessWidget {
  const InfoWaterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterFormController>(
      builder: (context, controller, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(top: Spacing.small, left: Spacing.small, right: Spacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Antes de finalizar...',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: FontSize.small3),
              ),
              const Text(
                'Isso está correto?',
                style: TextStyle(fontSize: FontSize.small2),
              ),
              const Divider(
                height: Spacing.big,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.normal),
              InkWell(
                borderRadius: BorderRadius.circular(Sizes.borderRadius),
                onTap: () {
                  int? amount;
                  final formKey = GlobalKey<FormState>();

                  BottomSheets.normal(
                    context: context,
                    title: 'Alterar meta diária',
                    content: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.small2,
                        vertical: Spacing.medium,
                      ),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: Spacing.small1),
                            DigitOnlyTextField(
                              suffix: 'ml',
                              label: 'Meta diária',
                              maxLength: 4,
                              autofocus: true,
                              onChanged: (value) {
                                amount = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira uma meta diária.';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(height: Spacing.small2),
                            Button.ok(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.setDailyGoal(amount!);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.all(Spacing.small3),
                  decoration: BoxDecoration(
                    color: MyColors.darkGrey,
                    borderRadius: BorderRadius.circular(Sizes.borderRadius),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.drop_fill, color: MyColors.lightGrey2),
                            SizedBox(width: Spacing.small2),
                            Expanded(child: Text('Meta diária')),
                          ],
                        ),
                      ),
                      Text('${controller.user.dailyGoal} ml', style: const TextStyle(color: MyColors.lightBlue)),
                      const SizedBox(width: Spacing.small3),
                      const Icon(CupertinoIcons.pencil, color: MyColors.lightGrey3),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Spacing.small1),
              Container(
                padding: const EdgeInsets.all(Spacing.small3),
                decoration: const BoxDecoration(
                  color: MyColors.darkGrey,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Sizes.borderRadius),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(CupertinoIcons.bell_fill, color: MyColors.lightGrey2),
                          SizedBox(width: Spacing.small2),
                          Expanded(child: Text('Notificações')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.darkGrey, width: Spacing.tiny),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Sizes.borderRadius)),
                ),
                child: const Column(
                  children: [
                    _ReminderCard(),
                    _ReminderCard(),
                    _ReminderCard(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ReminderCard extends StatelessWidget {
  const _ReminderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.small3),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('6:00'),
          Row(
            children: [
              Icon(CupertinoIcons.pencil, color: MyColors.lightGrey3),
              SizedBox(width: Spacing.medium1),
              Icon(CupertinoIcons.delete, color: MyColors.lightGrey3),
            ],
          )
        ],
      ),
    );
  }
}
