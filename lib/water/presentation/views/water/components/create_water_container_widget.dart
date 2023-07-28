// ignore_for_file: must_be_immutable

part of water_view;

class CreateWaterContainerWidget extends StatelessWidget {
  CreateWaterContainerWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();

  int _amount = 0;
  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        icon: const Icon(CommunityMaterialIcons.shape_polygon_plus, size: Spacing.medium2),
        title: const Align(
          child: Text(
            'Add new container',
            style: TextStyle(
              fontSize: FontSize.small2,
              fontWeight: FontWeight.w500,
              color: MyColors.lightGrey,
            ),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                  label: Text('Amount'),
                  suffix: Text('ml'),
                ),
                onChanged: (value) {
                  _amount = int.parse(value);
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount shouldn\'t be empty.';
                  if (value == '0') return 'Amount shouldn\'t be zero.';

                  return null;
                },
              ),
              const SizedBox(height: Spacing.small1),
              IconPickerField(
                  onOk: (selectedIcon) {
                    _selectedIcon = selectedIcon;
                  },
                  icons: const [
                    CommunityMaterialIcons.cup_water,
                    CommunityMaterialIcons.bottle_soda_classic,
                  ]),
            ],
          ),
        ),
        actions: [
          SizedBox(
              width: double.infinity,
              child: Button.ok(
                onPressed: () async {
                  // TODO: maybe create a "WaterContainerEntityViewModel" (?)
                  if (_formKey.currentState!.validate() && _selectedIcon != null) {
                    var waterContainerEntity = WaterContainerEntity(
                      icon: _selectedIcon!,
                      amount: _amount,
                    );

                    await getIt<WaterContainerViewModel>().create(waterContainerEntity).then((value) {
                      Navigator.pop(context);

                      value.fold((failure) {
                        SnackBarMessage.normal(context: context, text: failure.message);
                      }, (success) {
                        SnackBarMessage.undo(context: context, text: 'Container created', onPressed: () {});
                      });
                    });
                  }
                },
              )),
        ],
      ),
    );
  }
}
