part of water_display_view;

class WaterDataWidget extends StatelessWidget {
  final String text;
  final Future<Result<int>> value;

  const WaterDataWidget(this.text, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        FutureBuilder(
          future: value,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Loading...',
                style: TextStyle(color: MyColors.lightBlue),
              );
            }

            return snapshot.data!.fold(
              (failure) {
                return const Text(
                  'Unavailable',
                  style: TextStyle(color: MyColors.lightBlue),
                );
              },
              (amountOfWaterDrankToday) {
                return Text(
                  '$amountOfWaterDrankToday ml',
                  style: const TextStyle(color: MyColors.lightBlue),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
