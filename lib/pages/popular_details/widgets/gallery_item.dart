import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:task/constants/constants.dart';

import '../../../models/image_response.dart';

class GalleryItem extends StatelessWidget {
  Function onTap;
  List<Profiles>? profiles;

  GalleryItem({required this.onTap, this.profiles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                onTap(index);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:
                      Constants.imageUrl + (profiles?[index].filePath ?? ""),
                  height: 25.h,
                  width: 25.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: profiles!.length,
      ),
    );
  }
}
