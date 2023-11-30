import 'package:flutter/material.dart';
import 'package:task/service/netowrk/apis/api_manger.dart';

import '../model/popular_response.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    getMorePopular();
  }

  List<PersonResults> peoples = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPages = 500;
  bool isEnd = false;

  getPopular(int page) {
    ApiManger.getPopular(page).then((value) {
      if (peoples.isEmpty) {
        peoples = value.personResults ?? [];
      } else if (totalPages != page) {
        peoples.addAll(value.personResults ?? []);
      } else {
        isEnd = true;
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  getMorePopular() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          getPopular(++page);
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
