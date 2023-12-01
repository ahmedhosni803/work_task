import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/constants.dart';
import 'package:task/pages/popular_details/popular_details_view_model.dart';

import '../../models/persone_response.dart';
import '../../models/popular_response.dart';
import 'widgets/gallery_item.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = "details";
  PersonResults people;
  DetailsScreen(this.people);
  @override
  Widget build(BuildContext context) {
    Provider.of<PopularDetailsViewModel>(context, listen: false)
      ..getPersonDetails(people.id.toString())
      ..getPersonImages(people.id.toString());

    return Consumer<PopularDetailsViewModel>(
      builder: (context, provider, child) {
        provider.checkConnected();
        return Scaffold(
          appBar: AppBar(
            title: Text(people.name!),
          ),
          body: provider.connectivity == ConnectivityResult.none
              ? Center(
                  child: Text("Not Connected",
                      style: Theme.of(context).textTheme.bodySmall),
                )
              : Card(
                  elevation: 10,
                  margin: EdgeInsets.only(
                    right: 5.w,
                    top: 8.h,
                    left: 5.w,
                  ),
                  shape: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      )),
                  child: Selector<PopularDetailsViewModel, PersonResponse?>(
                    selector: (p0, p1) => p1.personDetails,
                    builder: (context, value, child) {
                      return provider.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              height: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            provider.previewSaveImage(
                                                filename:
                                                    people.profilePath ?? "",
                                                context: context);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: Constants.imageUrl +
                                                  (people.profilePath ?? ""),
                                              height: 25.h,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 40.w),
                                              child: Text(
                                                  people.originalName ?? "",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                                people.knownForDepartment ?? "",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                                Constants.gender(
                                                    people.gender!),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Text(
                                                "Birthday : ${value?.birthday ?? "unknown"}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text("Biograph",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(value?.biography ?? "unknown",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text("Place of birth",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(value?.placeOfBirth ?? "unknown",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text("Gallery",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall),
                                    GalleryItem(
                                      onTap: (index) {
                                        provider.previewSaveImage(
                                            filename: provider.profiles?[index]
                                                    .filePath ??
                                                "",
                                            context: context);
                                      },
                                      profiles: provider.profiles,
                                    ),
                                  ],
                                ),
                              ),
                            );
                    },
                  ),
                ),
        );
      },
    );
  }
}
