enum AppPage { home, login, register, settings, profile }

extension AppPageExtension on AppPage {
  String get toPath {
    switch (this) {
      case AppPage.login:
        return '/login';
      case AppPage.register:
        return '/register';
      case AppPage.home:
        return '/';
      case AppPage.settings:
        return '/settings';
      case AppPage.profile:
        return '/profile';
    }
  }

  String get toName {
    switch (this) {
      case AppPage.login:
        return "Login";
      case AppPage.register:
        return "Register";
      case AppPage.home:
        return "Home";
      case AppPage.settings:
        return "Settings";
      case AppPage.profile:
        return "Profile";
    }
  }
}
