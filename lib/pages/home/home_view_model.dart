import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:task/pages/home/services/local_service/home_local_service.dart';
import 'package:task/pages/home/services/network_service/home_api_service.dart';

import '../../models/popular_response.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    checkConnected();
    getPopular();
    getMorePopular();
  }
  List<PersonResults> peoples = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPages = 500;
  bool isEnd = false;
  late ConnectivityResult connectivity;
  getPopular({int page = 1}) async {
    connectivity = await checkConnected();
    if (connectivity != ConnectivityResult.none) {
      HomeApiService.getPopular(page).then((value) {
        isEnd = false;

        if (peoples.isEmpty) {
          isEnd = false;
          peoples = value.personResults ?? [];
          HomeLocalService.saveData(
              key: "popular", value: jsonEncode(peoples), poxName: "popular");
        } else if (totalPages != page) {
          peoples.addAll(value.personResults ?? []);
          HomeLocalService.saveData(
              key: "popular", value: jsonEncode(peoples), poxName: "popular");
        } else {
          isEnd = true;
        }
        notifyListeners();
      }).onError((error, stackTrace) {});
    } else {
      HomeLocalService.getData(key: "popular", poxName: "popular")
          .then((value) {
        jsonDecode(value).forEach((v) {
          peoples.add(PersonResults.fromJson(v));
          isEnd = true;
        });
      }).onError((error, stackTrace) {
        print(error);
      });
    }
  }

  getMorePopular() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          getPopular(page: ++page);
        }
      }
    });
  }

  Future<ConnectivityResult> checkConnected() async {
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    Connectivity().onConnectivityChanged.listen((event) {
      connectivityResult = event;
      connectivity = event;
      notifyListeners();
    });
    connectivity = connectivityResult;
    return connectivityResult;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
