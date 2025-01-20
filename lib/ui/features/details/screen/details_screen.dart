import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/exports.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../domain/entities/project.dart';
import '../../../extensions/color_convert.dart';
import '../../../styles/fonts/fonts.dart';
import '../../../widgets/bluetooth_device_card.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/image_builder.dart';
import '../provider/details_provider.dart';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({
    super.key,
    required this.project,
  });

  final Project project;

  static const routeName = '/details';

  @override
  ConsumerState<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(detailsProvider.notifier).getBluetoothDevices();
    ref
        .read(detailsProvider.notifier)
        .getAgencyById(widget.project.agencyId)
        .then((agency) {
      if (agency == null) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(themeNotifierProvider.notifier)
            .updateTheme(agency.themeColor.toColor());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: widget.project.id,
                          child: ImageBuilder(
                            image: widget.project.imageUrl ?? 'no assets',
                            border: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            height: 350,
                          ),
                        ),
                        FadeIn(
                          duration: const Duration(milliseconds: 300),
                          delay: const Duration(milliseconds: 400),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                size: 28,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      widget.project.name,
                      style: Fonts.ROBOTO_24_BOLD.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.location,
                      style: Fonts.ROBOTO_14_NORMAL.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      text.description,
                      style: Fonts.ROBOTO_16_BOLD.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.project.description ?? text.descriptionIsNull,
                      style: Fonts.ROBOTO_14_NORMAL.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              if (ref.watch(detailsProvider).bluetoothDevices != null) ...[
                const SizedBox(height: 16),
                BluetoothDeviceCard(
                  devices: ref.watch(detailsProvider).bluetoothDevices ?? [],
                ),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: FadeInUp(
        duration: const Duration(milliseconds: 300),
        delay: const Duration(milliseconds: 100),
        child: _FooterWidget(price: widget.project.price.toString()),
      ),
    );
  }
}

class _FooterWidget extends StatelessWidget {
  const _FooterWidget({
    required this.price,
  });

  final String price;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: Fonts.ROBOTO_24_BOLD.copyWith(
                  color: Colors.white,
                ),
                children: [
                  TextSpan(text: '\$$price '),
                  TextSpan(
                    text: text.taxes,
                    style: Fonts.ROBOTO_14_NORMAL.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            PrimaryTextButton(
              text: text.buttonContact,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
