import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../styles/colors/up_colors.dart';
import '../../../styles/fonts/fonts.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/image_builder.dart';
import '../provider/create_provider.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  static const routeName = '/create';
  @override
  ConsumerState<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final createNotifier = ref.read(createProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Project',
          style: Fonts.ROBOTO_20_NORMAL.copyWith(
            color: Colors.black,
          ),
        ),
        // backbutton
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 28,
          ),
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                _CustomImagePicker(),
                CustomInput(
                  label: 'PROJECT NAME',
                  placeholder: 'Something Catchy...',
                  onChanged: (value) =>
                      createNotifier.updateField('name', value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  label: 'PROJECT ADDRESS',
                  placeholder: '123 Disney way here...',
                  keyboardType: TextInputType.streetAddress,
                  onChanged: (value) =>
                      createNotifier.updateField('location', value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  label: 'PRICE',
                  placeholder: '\$PRICE',
                  keyboardType: TextInputType.number,
                  onChanged: (value) => createNotifier.updateField(
                      'price', int.parse(value.isEmpty ? '0' : value)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                CustomInput(
                  label: 'DESCRIPTION',
                  placeholder: 'Neighborhood or city..',
                  maxLines: 4,
                  // onChanged: (value) => createNotifier.updateField(
                  //     'description',
                  //     value), //todo: falta implementar el campo en la db
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: PrimaryTextButton(
                    text: 'SAVE',
                    onPressed: () async {
                      final imageState =
                          ref.read(createProvider).fields['image_url'];

                      if (imageState == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please add an image'),
                          ),
                        );
                        return;
                      }
                      if (_formKey.currentState!.validate() &&
                          !ref.read(createProvider.notifier).validateFields()) {
                        _formKey.currentState!.save();
                        return;
                      }

                      await ref.read(createProvider.notifier).createProject();
                      Navigator.of(context).pop(true);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomImagePicker extends ConsumerStatefulWidget {
  const _CustomImagePicker();

  @override
  ConsumerState<_CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends ConsumerState<_CustomImagePicker> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final imageState = ref.watch(createProvider).fields['image_url'];

    return GestureDetector(
      onTap: pickImage,
      onLongPress: showMenuOptions,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: UpColors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        height: size.height * 0.190,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageState == null) ...[
                Icon(
                  Icons.image_outlined,
                  color: UpColors.greyBold,
                  size: 70,
                ),
                SizedBox(height: 10),
                Text(
                  'Add Image',
                  style: Fonts.ROBOTO_16_BOLD.copyWith(
                    color: UpColors.greyBold,
                  ),
                ),
              ],
              if (imageState != null) ...[
                ImageBuilder(
                  image: imageState,
                  height: size.height * 0.190,
                  fit: BoxFit.cover,
                  border: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    final _picker = ImagePicker();

    try {
      await getPermission();
      XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        throw Exception('No image selected');
      }

      ref
          .read(createProvider.notifier)
          .updateField('image_url', pickedImage.path);

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }

  Future<void> getPermission() async {
    final permission = await Permission.photos.request();
    if (permission.isGranted) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied'),
        ),
      );
    }
  }

  void showMenuOptions() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text('Options'),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              ref.read(createProvider.notifier).updateField('image_url', '');
              Navigator.pop(context);
            },
            child: Text('Remove'),
          ),
        ],
      ),
    );
  }
}
