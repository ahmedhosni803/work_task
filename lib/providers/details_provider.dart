import 'package:flutter/material.dart';
import 'package:task/service/download/download_image.dart';
import 'package:task/service/netowrk/apis/api_manger.dart';

import '../model/image_response.dart';
import '../model/persone_response.dart';

class DetailsViewModel extends ChangeNotifier {
  PersonResponse? personDetails;
  List<Profiles>? profiles;

  bool isLoading = true;

  getPersonDetails(String id) {
    isLoading = true;
    ApiManger.getPopularDetails(id).then((value) {
      personDetails = value;
      isLoading = false;
      notifyListeners();
    });
  }

  getPersonImages() {
    profiles?.clear();
    ApiManger.getPopularImage(personDetails!.id.toString()).then((value) {
      profiles = value.profiles;
      notifyListeners();
    });
  }

  saveImage(String image, BuildContext context) {
    try {
      DownloadMange.imageDownload(image);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Saved")));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
