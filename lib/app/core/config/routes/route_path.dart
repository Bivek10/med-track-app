enum AppPage { home, login, register, settings, profile, addMedicine, history, reports, reminder, medicineList }

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
      case AppPage.addMedicine:
        return '/add-medicine';
      case AppPage.history:
        return '/history';
      case AppPage.reports:
        return '/reports';
      case AppPage.reminder:
        return '/reminder';
      case AppPage.medicineList:
        return '/medicine-list';
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
      case AppPage.addMedicine:
        return "Add Medicine";
      case AppPage.history:
        return "History";
      case AppPage.reports:
        return "Reports";
      case AppPage.reminder:
        return "Reminder";
      case AppPage.medicineList:
        return "Medicine";
    }
  }
}
