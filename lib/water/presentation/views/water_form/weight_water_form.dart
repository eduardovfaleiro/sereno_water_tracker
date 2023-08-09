library water_starter_view;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/core.dart';
import '../../../../core/theme/themes.dart';
import '../../controllers/water_form_controller.dart';
import '../../widgets/number_picker.dart';

class WeightWaterForm extends StatelessWidget {
  const WeightWaterForm({super.key});

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
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: FontSize.small2,
                    color: Color.fromARGB(255, 226, 226, 226),
                    fontWeight: FontWeight.w500,
                  ),
                  text: 'Bem-vindo ao ',
                  children: [
                    TextSpan(
                      text: 'Sereno',
                      style: TextStyle(
                        color: Color(0xFF4E9CC8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: '!'),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.small2),
              const Text(
                'Para começar, precisamos de algumas informações.',
                style: TextStyle(
                  fontSize: FontSize.medium2,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 231, 231, 231),
                ),
              ),
              const Divider(
                height: Spacing.big,
                thickness: 1,
              ),
              const SizedBox(height: Spacing.medium),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: FontSize.small3, color: MyColors.lightGrey),
                      text: 'Qual é seu ',
                      children: [
                        TextSpan(
                          text: 'peso',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: '?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.small),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.center,
                    child: NumberPicker(
                      initialValue: controller.user.weight,
                      loop: true,
                      suffixWidget: const Text('kg'),
                      range: MAX_WEIGHT,
                      includeZero: false,
                      onChanged: (value) {
                        controller.setWeight(value);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class InputCardWidget extends StatefulWidget {
  final Widget question;
  final Widget value;
  final Slider slider;

  const InputCardWidget({
    super.key,
    required this.question,
    required this.value,
    required this.slider,
  });

  @override
  State<InputCardWidget> createState() => _InputCardWidgetState();
}

class _InputCardWidgetState extends State<InputCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Spacing.small3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        color: MyColors.darkGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.question,
              widget.value,
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: Spacing.normal, bottom: Spacing.small2),
            child: widget.slider,
          ),
        ],
      ),
    );
  }
}

// class DateInputCardWidget extends StatefulWidget {
//   final Widget question;
//   final void Function() onTap;

//   const DateInputCardWidget({
//     super.key,
//     required this.onTap,
//     required this.question,
//   });

//   @override
//   State<DateInputCardWidget> createState() => _DateInputCardWidgetState();
// }

// class _DateInputCardWidgetState extends State<DateInputCardWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<controller>(
//       builder: (context, controller, _) {
//         return InkWell(
//           onTap: widget.onTap,
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(Spacing.small3),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(Sizes.borderRadius),
//               color: MyColors.darkGrey,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     widget.question,
//                     const DatePickerMessage(),
//                   ],
//                 ),
//                 const Icon(Icons.access_time_filled, color: Colors.grey),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class DatePickerMessage extends StatefulWidget {
//   const DatePickerMessage({super.key});

//   @override
//   State<DatePickerMessage> createState() => _DatePickerMessageState();
// }

// class _DatePickerMessageState extends State<DatePickerMessage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<controller>(
//         builder: (context, controller, _) {
//       if (controller.isUserValid) {
//         return Text(
//           'From ${getTimeOfDayValue(controller.wakeUpTime!)} to '
//           '${getTimeOfDayValue(controller.sleeptime!)}',
//           style: const TextStyle(
//               fontSize: FontSize.small, color: MyColors.lightBlue),
//         );
//       }

//       return const Text(
//         'Press to select time',
//         style: TextStyle(color: MyColors.lightBlue, fontSize: FontSize.small),
//       );
//     });
//   }
// }
