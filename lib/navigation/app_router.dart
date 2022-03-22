import 'package:flutter/material.dart';
import 'package:recipe_app/navigation/app_link.dart';
import '../models/models.dart';
import '../screens/screens.dart';
class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier,
        PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
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
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      // onPopPage
      onPopPage: _handlePopPage,
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
            groceryManager.addItem(item);
          }, onUpdate: (item, index) {
          // No update
        },
        ),
        // Select GroceryItemScreen
        if (groceryManager.selectedIndex != -1)
          GroceryItemScreen.page(
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
              onUpdate: (item, index) {
                groceryManager.updateItem(item, index);
              },
              onCreate: (_) {
                // No create
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
      Route<dynamic> route,
      result) {
    if (!route.didPop(result)) {
      return false;
    }
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
    return true;
  }
  // Convert app state to applink
  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.kLoginPath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.kOnboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.kProfilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.kItemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.kItemPath, itemId: id);
    } else {
      return AppLink(
          location: AppLink.kHomePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  // Apply configuration helper
  @override
  AppLink get currentConfiguration => getCurrentPath();

  // Replace setNewRoutePath
  @override
  Future<void> setNewRoutePath(AppLink newLink) async {
    switch (newLink.location) {
      case AppLink.kProfilePath:
        profileManager.tapOnProfile(true);
        break;
      case AppLink.kItemPath:
        final itemId = newLink.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;
      case AppLink.kHomePath:
        appStateManager.goToTab(newLink.currentTab ?? 0);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
      default:
        break;
    }
  }
  //@override
  //Future<void> setNewRoutePath(configuration) async => null;
}