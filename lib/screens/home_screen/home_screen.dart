import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/home_provider.dart';

import '../../model/popular_response.dart';

class HomeScreen extends StatelessWidget {
  static const String route = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Selector<HomeViewModel, List<PersonResults>>(
                selector: (_, val) => val.people,
                builder: (context, value, child) {
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return Card();
                      },
                      separatorBuilder: (context, index) => SizedBox(),
                      itemCount: 1);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
