import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:task/constants/constants.dart';
import 'package:task/pages/popular_details/services/network_service/image_download_service.dart';
import 'package:task/pages/popular_details/services/network_service/popular_details_api_service.dart';

import '../../models/image_response.dart';
import '../../models/persone_response.dart';

class PopularDetailsViewModel extends ChangeNotifier {
  PopularDetailsViewModel() {
    checkConnected();
  }
  PersonResponse? personDetails;
  List<Profiles>? profiles;
  bool isLoading = true;
  late ConnectivityResult connectivity;

  void getPersonDetails(String id) {
    isLoading = true;
    DetailsPopularApiService.getPopularDetails(id).then((value) {
      personDetails = value;
      isLoading = false;
      notifyListeners();
    });
  }

  void getPersonImages(String id) {
    profiles?.clear();
    DetailsPopularApiService.getPopularImage(id).then((value) {
      profiles = value.profiles;
      notifyListeners();
    });
  }

  void saveImage(String image, BuildContext context) {
    try {
      ImageDownloadService.downloadImage(image);
      Navigator.pop(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Saved")));
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }

  void previewSaveImage(
      {required String filename, required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: CachedNetworkImage(
            imageUrl: Constants.imageUrl + (filename),
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  saveImage(filename, context);
                },
                child: const Text("Save to Device"))
          ],
        );
      },
    );
  }

  Future<ConnectivityResult> checkConnected() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((event) {
      connectivityResult = event;
      notifyListeners();
    });
    connectivity = connectivityResult;
    return connectivityResult;
  }
}
