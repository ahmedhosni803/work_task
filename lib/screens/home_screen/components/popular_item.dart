import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:task/screens/details_screen/details_screen.dart';

import '../../../constant/constant_api.dart';
import '../../../model/popular_response.dart';

class PopularItem extends StatelessWidget {
  PersonResults people;
  PopularItem(this.people);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailsScreen.route, arguments: people);
      },
      child: Card(
          margin: const EdgeInsets.all(5),
          shape: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: ApiConst.imageUrl + (people.profilePath ?? ""),
                    height: 10.h,
                    width: 20.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 2.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(people.originalName ?? "",
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(people.knownForDepartment ?? "",
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                const Spacer(),
                Text(people.gender!.toInt() == 2 ? "Male" : "Female",
                    style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
          )),
    );
  }
}
