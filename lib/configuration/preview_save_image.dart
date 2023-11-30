import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant/constant_api.dart';
import '../providers/details_provider.dart';

previewSaveImage(
    {required String filename,
    required BuildContext context,
    required DetailsViewModel provider}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: CachedNetworkImage(
          imageUrl: ApiConst.imageUrl + (filename),
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                provider.saveImage(filename, context);
              },
              child: Text("Save to Device"))
        ],
      );
    },
  );
}
