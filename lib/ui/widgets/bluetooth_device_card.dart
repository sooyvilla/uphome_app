import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../../core/exports.dart';
import '../styles/colors/up_colors.dart';
import '../styles/fonts/fonts.dart';
import 'buttons.dart';

class BluetoothDeviceCard extends StatefulWidget {
  const BluetoothDeviceCard({
    super.key,
    required this.devices,
  });

  final List<BluetoothDevice> devices;

  @override
  _BluetoothDeviceCardState createState() => _BluetoothDeviceCardState();
}

class _BluetoothDeviceCardState extends State<BluetoothDeviceCard> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final text = AppLocalizations.of(context)!;

    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text.availableBlue,
              style: Fonts.ROBOTO_14_NORMAL.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.devices.length,
              itemBuilder: (context, index) {
                final device = widget.devices[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryTextButton(
                            text: text.connectButton,
                            onPressed: () {
                              device.connect();
                            },
                            color: UpColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.devices.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.black
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
