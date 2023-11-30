import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/details_provider.dart';

import '../../configuration/preview_save_image.dart';
import '../../constant/constant_api.dart';

class GalleryScreen extends StatelessWidget {
  static const String route = "gallery";
  @override
  Widget build(BuildContext context) {
    Provider.of<DetailsViewModel>(context, listen: false).getPersonImages();

    return Consumer<DetailsViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: Text(provider.personDetails?.name ?? "")),
          body: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: InkWell(
                  onTap: () {
                    previewSaveImage(
                        filename: provider.profiles?[index].filePath ?? "",
                        context: context,
                        provider: provider);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: ApiConst.imageUrl +
                          (provider.profiles?[index].filePath ?? ""),
                      height: 25.h,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              );
            },
            itemCount: provider.profiles!.length,
          ),
        );
      },
    );
  }
}
