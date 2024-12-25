import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.height,
    this.border,
    this.fit = BoxFit.cover,
    required this.image,
  });

  final String image;
  final double? height;
  final BoxFit fit;
  final BorderRadiusGeometry? border;

  bool _isNetworkImage(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return ClipRRect(
      borderRadius: border ??
          const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
      child: Center(
        child: _isNetworkImage(image)
            ? Image.network(
                image,
                fit: fit,
                width: double.infinity,
                height: height ?? 200,
                errorBuilder: (context, error, stackTrace) {
                  return _errorPlaceholder(text);
                },
              )
            : Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: height ?? 200,
                errorBuilder: (context, error, stackTrace) {
                  return _errorPlaceholder(text);
                },
              ),
      ),
    );
  }

  Widget _errorPlaceholder(AppLocalizations text) {
    return SizedBox(
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.image_not_supported_outlined,
            size: 46,
          ),
          Text(
            text.noImagesFound,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
