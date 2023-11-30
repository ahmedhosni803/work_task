import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/configuration/preview_save_image.dart';
import 'package:task/providers/details_provider.dart';

import '../../constant/constant_api.dart';
import '../../model/persone_response.dart';
import '../../model/popular_response.dart';
import '../gallery_screen/gallery_screen.dart';

class DetailsScreen extends StatelessWidget {
  static const String route = "details";
  @override
  Widget build(BuildContext context) {
    PersonResults people =
        ModalRoute.of(context)!.settings.arguments as PersonResults;
    Provider.of<DetailsViewModel>(context, listen: false)
        .getPersonDetails(people.id.toString());

    return Consumer<DetailsViewModel>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(people.name!),
          ),
          body: Card(
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
            child: Selector<DetailsViewModel, PersonResponse?>(
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
                                      previewSaveImage(
                                          filename: people.profilePath ?? "",
                                          context: context,
                                          provider: provider);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiConst.imageUrl +
                                            (people.profilePath ?? ""),
                                        height: 25.h,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 40.w),
                                        child: Text(people.originalName ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(people.knownForDepartment ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Text(
                                          people.gender!.toInt() == 2
                                              ? "Male"
                                              : "Female",
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
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(value?.biography ?? "unknown",
                                  style: Theme.of(context).textTheme.bodySmall),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text("Place of birth",
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(value?.placeOfBirth ?? "unknown",
                                  style: Theme.of(context).textTheme.bodySmall),
                              SizedBox(
                                height: 2.h,
                              ),
                              Center(
                                child: SizedBox(
                                  width: 70.w,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, GalleryScreen.route);
                                      },
                                      child: const Text("Gallery")),
                                ),
                              )
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
