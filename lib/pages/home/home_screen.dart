import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';
import 'package:task/models/popular_response.dart';
import 'package:task/pages/home/home_view_model.dart';

import 'widgets/popular_item.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "home";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (value.connectivity == ConnectivityResult.none) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("not connected"),
              showCloseIcon: true,
              closeIconColor: Colors.white,
            ));
          }
        });

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Selector<HomeViewModel, List<PersonResults>>(
                selector: (_, val) => val.peoples,
                builder: (context, peoples, child) {
                  return Expanded(
                    child: ListView.separated(
                        controller: value.scrollController,
                        itemBuilder: (context, index) {
                          if (index + 1 == peoples.length) {
                            return Center(
                                child: value.isEnd
                                    ? Text(
                                        "No more Data",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    : const CircularProgressIndicator());
                          } else {
                            return PopularItem(peoples[index]);
                          }
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1.h,
                            ),
                        itemCount: peoples.length),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
