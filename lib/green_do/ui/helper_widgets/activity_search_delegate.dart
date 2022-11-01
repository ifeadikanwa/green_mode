import 'package:flutter/material.dart';
import 'package:green_mode/core/common_widgets/themed_divider.dart';
import 'package:green_mode/core/routing/app_router.dart';
import 'package:green_mode/green_do/data/activity.dart';

class ActivitySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Activity> matchQuery = [];
    for (var activity in Activity.values) {
      if (activity.presentationName
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(activity);
      }
    }
    return ListView.separated(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.presentationName),
          onTap: () {
            Navigator.push(
              context,
              AppRouter.activityDetailScreen(context, result),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const ThemedDivider(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Activity> matchQuery = [];
    for (var activity in Activity.values) {
      if (activity.presentationName
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(activity);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.presentationName),
          onTap: () {
            query = result.presentationName;
            showResults(context);
          },
        );
      },
    );
  }
}
