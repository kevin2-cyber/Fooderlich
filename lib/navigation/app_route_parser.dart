// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:recipe_app/navigation/navigation.dart';

class AppRouteParser extends RouteInformationParser<AppLink> {
  @override
  Future<AppLink> parseRouteInformation(
      RouteInformation routeInformation) async {
    final link = AppLink.fromLocation(routeInformation.location);
    return link;
  }

  @override
  RouteInformation restoreRouteInformation(AppLink appLink) {
    final location = appLink.toLocation();
    return RouteInformation(location: location);
  }
}
