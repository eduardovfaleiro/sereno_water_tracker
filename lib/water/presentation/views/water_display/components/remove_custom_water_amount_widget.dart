// ignore_for_file: must_be_immutable

part of water_display_view;

class RemoveCustomWaterAmountWidget extends StatelessWidget {
  RemoveCustomWaterAmountWidget({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  final WaterViewModel waterViewModel = getIt<WaterViewModel>();

  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        icon: const Icon(CommunityMaterialIcons.water_minus_outline, size: Spacing.medium2),
        title: const Align(
          child: Text(
            'Remove custom amount',
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
                  _amount = int.tryParse(value) ?? 0;
                },
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount shouldn\'t be empty.';
                  if (value == '0') return 'Amount shouldn\'t be zero.';

                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await waterViewModel.getAmountDrankToday().then((result) {
                    result.fold((failure) {
                      SnackBarMessage.normal(context: context, text: failure.message);
                    }, (success) async {
                      int amountDrankToday = success;
                      int updatedAmountDrankToday = amountDrankToday - _amount;

                      await waterViewModel.updateAmountDrankToday(updatedAmountDrankToday).whenComplete(() {
                        Navigator.pop(context);

                        SnackBarMessage.undo(
                            context: context,
                            text: 'Removed $_amount ml',
                            onPressed: () async {
                              updatedAmountDrankToday += _amount;

                              await waterViewModel.updateAmountDrankToday(updatedAmountDrankToday);
                            });
                      });
                    });
                  });
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(color: MyColors.darkGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
