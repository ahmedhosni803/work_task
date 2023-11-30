import 'package:flutter/material.dart';
import 'package:task/service/netowrk/apis/api_manger.dart';

import '../model/popular_response.dart';

class HomeViewModel extends ChangeNotifier {
  List<PersonResults> people = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  int totalPages = 1;
  bool isEnd = false;
  HomeViewModel() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop) {
          getPopular(++page);
        }
      }
    });
  }
  getPopular(int page) {
    ApiManger.getPopular(page).then((value) {
      if (totalPages == 1) {
        totalPages = value.totalPages?.toInt() ?? 1;
      }
      if (people.isEmpty) {
        people = value.personResults ?? [];
      } else if (totalPages != page) {
        people.addAll(value.personResults ?? []);
      } else {
        isEnd = true;
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
