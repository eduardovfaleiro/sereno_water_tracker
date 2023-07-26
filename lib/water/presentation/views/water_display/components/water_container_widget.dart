part of water_display_view;

class WaterContainerWidget extends StatefulWidget {
  const WaterContainerWidget({super.key});

  @override
  State<WaterContainerWidget> createState() => _WaterContainerWidgetState();
}

class _WaterContainerWidgetState extends State<WaterContainerWidget> {
  final GlobalKey _moreOptionsGlobalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterContainerViewModel>(
      builder: (context, waterContainerViewModel, _) {
        return FutureBuilder(
          future: waterContainerViewModel.getAllContainers(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }

            return snapshot.data!.fold((failure) {
              SnackBarMessage.normal(context: context, text: 'Couldn\'t get water containers');
              return const SizedBox();
            }, (success) {
              List<WaterContainerEntity> waterContainers = success;

              return Wrap(
                spacing: Spacing.small2,
                runSpacing: Spacing.small2,
                children: [
                  ...List.generate(
                    waterContainers.length,
                    (index) {
                      final globalKey = GlobalKey();

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularButton(
                            key: globalKey,
                            onLongPress: () async {
                              await Menus.buttons(
                                key: globalKey,
                                items: [
                                  PopupMenuButtonItem(
                                    onTap: () {
                                      waterContainerViewModel.delete(waterContainers[index]).then((result) {
                                        result.fold((failure) {
                                          SnackBarMessage.normal(context: context, text: failure.message);
                                        }, (success) {
                                          SnackBarMessage.undo(
                                            context: context,
                                            text: 'Container deleted',
                                            onPressed: () {
                                              waterContainerViewModel.create(waterContainers[index]).then((result) {
                                                result.fold((failure) {
                                                  SnackBarMessage.normal(context: context, text: 'Couldn\'t recreate container');
                                                }, (_) {});
                                              });
                                            },
                                          );
                                        });
                                      });

                                      Navigator.pop(context);
                                    },
                                    label: const Text('Delete',
                                        style: TextStyle(
                                          fontSize: FontSize.normal,
                                          color: MyColors.lightBlue,
                                        )),
                                    icon: const Icon(
                                      Icons.delete,
                                      size: Spacing.medium,
                                      color: MyColors.lightBlue,
                                    ),
                                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(Sizes.borderRadius)),
                                  ),
                                  PopupMenuButtonItem(
                                    onTap: () async {
                                      int amountDrankToday;
                                      var result = await getIt<WaterViewModel>().getAmountDrankToday().then((value) {
                                        value.fold((failure) {
                                          SnackBarMessage.normal(context: context, text: 'Couldn\'t get amount drank today');
                                          return failure;
                                        }, (success) {});
                                      });

                                      getIt<WaterViewModel>().updateAmountDrankToday(waterContainers[index].amount);

                                      Navigator.pop(context);
                                    },
                                    label: const Text('Remove',
                                        style: TextStyle(
                                          fontSize: FontSize.normal,
                                          color: MyColors.lightBlue,
                                        )),
                                    icon: const Icon(
                                      CommunityMaterialIcons.water_minus,
                                      size: Spacing.medium,
                                      color: MyColors.lightBlue,
                                    ),
                                    borderRadius: const BorderRadius.horizontal(right: Radius.circular(Sizes.borderRadius)),
                                  ),
                                ],
                                context: context,
                              );
                            },
                            color: MyColors.lightGrey,
                            label: Text(
                              '+${waterContainers[index].amount} $VOLUME_UNIT_M',
                              style: const TextStyle(
                                color: MyColors.lightGrey,
                                fontSize: FontSize.small,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            child: Icon(waterContainers[index].icon, color: MyColors.darkGrey),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircularButton(
                        key: _moreOptionsGlobalKey,
                        color: MyColors.darkGrey,
                        child: const Icon(
                          CommunityMaterialIcons.dots_vertical,
                          color: MyColors.lightGrey,
                        ),
                        onTap: () async {
                          await Menus.normal(
                            key: _moreOptionsGlobalKey,
                            context: context,
                            items: [
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      child: CreateWaterContainerWidget(),
                                      context: context,
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.shape_polygon_plus, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Add new container'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      context: context,
                                      child: AddCustomWaterAmountWidget(),
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_plus_outline, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Add custom amount'),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () async {
                                  await Future.delayed(Duration.zero, () {
                                    Dialogs.normal(
                                      context: context,
                                      child: RemoveCustomWaterAmountWidget(),
                                    );
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(CommunityMaterialIcons.water_minus_outline, color: MyColors.lightGrey),
                                    SizedBox(width: Spacing.small2),
                                    Text('Remove custom amount'),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            });
          },
        );
      },
    );
  }
}
