import 'package:flutter/material.dart';
import 'package:recipe_app/navigation/app_link.dart';
import '../models/models.dart';
import '../screens/screens.dart';
// 1
class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier,
        PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  // 3
  final AppStateManager appStateManager;
  // 4
  final GroceryManager groceryManager;
  // 5
  final ProfileManager profileManager;
  AppRouter({
    required this.appStateManager,
    required this.groceryManager,
    required this.profileManager,
  })
      : navigatorKey = GlobalKey<NavigatorState>() {

    // Add Listeners
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }
  // Dispose listeners
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }
  // 6
  @override
  Widget build(BuildContext context) {
    // 7
    return Navigator(
      // 8
      key: navigatorKey,
      // onPopPage
      onPopPage: _handlePopPage,
      // 9
      pages: [
        // SplashScreen
        if (!appStateManager.isInitialized) SplashScreen.page(),
        // LoginScreen
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)LoginScreen.page(),
        // OnboardingScreen
        if (appStateManager.isLoggedIn && !appStateManager.isOnboardingComplete)OnboardingScreen.page(),
        // Home
        if (appStateManager.isOnboardingComplete)Home.page(appStateManager.getSelectedTab),
        // Create new item
        if (groceryManager.isCreatingNewItem)
        GroceryItemScreen.page(
          onCreate: (item) {
            // 3
            groceryManager.addItem(item);
          }, onUpdate: (item, index) {
          // 4 No update
        },
        ),
        // Select GroceryItemScreen
        if (groceryManager.selectedIndex != -1)
        // 2
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                // 3
                groceryManager.updateItem(item, index);
              },
              onCreate: (_) {
                // 4 No create
              }
          ),
        // Add Profile Screen
        if (profileManager.didSelectUser)ProfileScreen.page(profileManager.getUser),
        // Add WebView Screen
        if (profileManager.didTapOnRaywenderlich)WebViewScreen.page(),
      ],
    );
  }
  // _handlePopPage
  bool _handlePopPage(
      // 1
      Route<dynamic> route,
      // 2
      result) {
    // 3
    if (!route.didPop(result)) {
      // 4
      return false;
    }
    // 5
    // Handle Onboarding and splash
    if (route.settings.name == FooderlichPages.onboardingPath) {
      appStateManager.logout();
    }
    // Handle state when user closes grocery item screen
    if (route.settings.name == FooderlichPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }
    // Handle state when user closes profile screen
    if (route.settings.name == FooderlichPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    // Handle state when user closes WebView screen
    if (route.settings.name == FooderlichPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }
    // 6
    return true;
  }
  // TODO: Convert app state to applink

  // TODO: Apply configuration helper

  // TODO: Replace setNewRoutePath
  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    // 2
    switch (newLink.location) {
    // 3
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;
    // 4
      case AppLink.kItemPath:
      // 5
        final itemId = newLink.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          // 6
          groceryManager.createNewItem();
        }
        // 7
        profileManager.tapOnProfile(false);
        break;
    // 8
      case AppLink.kHomePath:
      // 9
        appStateManager.goToTab(newLink.currentTab ?? 0);
        // 10
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
    // 11
      default:
        break;
    }
  }
  // 10
  //@override
  //Future<void> setNewRoutePath(configuration) async => null;
}