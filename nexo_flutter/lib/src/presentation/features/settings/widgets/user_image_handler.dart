import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserImageHandler {
  static Future<void> updateUserImage({
    required BuildContext context,
    required Future<void> Function(ByteData data) onUpload,
  }) async {
    const imageSize = 256;
    var toolbarColor = Theme.of(context).primaryColor;
    var toolbarWidgetColor =
        Theme.of(context).buttonTheme.colorScheme?.onPrimary ?? Colors.white;

    var picker = ImagePicker();
    // Pick an image
    var imageFile = await picker.pickImage(source: ImageSource.gallery);
    if (imageFile == null) return;

    // Crop the image
    var croppedImageFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      maxHeight: imageSize,
      maxWidth: imageSize,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: toolbarColor,
            toolbarWidgetColor: toolbarWidgetColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedImageFile == null) return;

    // Load and resize
    var image = img.decodeImage(await croppedImageFile.readAsBytes());
    if (image == null) return;

    if (image.width != imageSize || image.height != imageSize) {
      image = img.copyResize(image, width: imageSize, height: imageSize);
    }

    // Encode as png
    var encoded = img.encodePng(image);
    var bytes = Uint8List.fromList(encoded);
    var data = ByteData.view(bytes.buffer);

    // Upload the image to the server
    await onUpload(data);
  }
}
