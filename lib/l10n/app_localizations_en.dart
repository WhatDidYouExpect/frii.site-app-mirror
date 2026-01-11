// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get emailLabel => 'Email';

  @override
  String get languageLabel => 'Language';

  @override
  String get cityLabel => 'City';

  @override
  String get countryLabel => 'Country';

  @override
  String get joinedLabel => 'Joined';

  @override
  String get twoFaEnabledLabel => '2FA Enabled';

  @override
  String get referralCodeLabel => 'Referral Code';

  @override
  String get referredPeopleLabel => 'Referred People';

  @override
  String get maxDomainsLabel => 'Max Domains';

  @override
  String get maxSubdomainsLabel => 'Max Subdomains';

  @override
  String get userDetailsAccessLabel => 'User Details Access';

  @override
  String get ownedTldsLabel => 'Owned TLDs';

  @override
  String get discordLinkedLabel => 'Discord Linked';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get none => 'None';

  @override
  String get notAvailable => 'N/A';

  @override
  String get unknown => 'Unknown';

  @override
  String modifyDomainTitle(Object domain) {
    return 'Modify $domain';
  }

  @override
  String get deleteDomainWarning => 'This action cannot be undone.';

  @override
  String deleteDomainTitle(Object domain) {
    return 'Delete $domain?';
  }

  @override
  String get valueLabel => 'Value';

  @override
  String get typeLabel => 'Type';

  @override
  String get yourIpLabel => 'Your IP';

  @override
  String get useYourIpButton => 'Use Your IP as Value';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get saveButton => 'Save';

  @override
  String get deleteButton => 'Delete';

  @override
  String get domainModifiedSuccess => 'Domain modified successfully!';

  @override
  String get domainModifyError => 'Error modifying domain';

  @override
  String get domainDeletedSuccess => 'Domain deleted successfully!';

  @override
  String get domainDeleteError => 'Error deleting domain';

  @override
  String get ipLabel => 'IP';

  @override
  String get lastUpdatedLabel => 'Last Updated';

  @override
  String get unableToFetchIp => 'Unable to fetch IP';

  @override
  String get modifyButton => 'Modify';

  @override
  String get noInternetTitle => 'No Internet';

  @override
  String get noInternetMessage => 'Your device is offline. Please check your connection.';

  @override
  String get okButton => 'OK';

  @override
  String get registerDomainTitle => 'Register Domain';

  @override
  String get domainLabel => 'Domain';

  @override
  String invalidDomainMessage(Object domain) {
    return 'Domain must be: $domain.frii.site, $domain.pill.ovh, or $domain.arrh.ovh';
  }

  @override
  String get registerButton => 'Register';

  @override
  String helloUser(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get domainRegisteredSuccess => 'Domain registered successfully!';

  @override
  String get domainRegisterError => 'Error';

  @override
  String get drawerDashboard => 'Dashboard';

  @override
  String get drawerAccount => 'Account';

  @override
  String get drawerBlogs => 'Blogs';

  @override
  String get drawerLogs => 'Logs';

  @override
  String get refreshDomainsTooltip => 'Refresh Domains';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get appBarTitle => 'frii.site';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Logout';

  @override
  String get name => 'Name';

  @override
  String get email => 'Email';

  @override
  String get lastLogin => 'Last Login';

  @override
  String get viewLogs => 'View Logs';

  @override
  String get failedLoadProfile => 'Failed to load profile';

  @override
  String get settings => 'Settings';

  @override
  String get apiToken => 'API Token';

  @override
  String get apiUrl => 'API URL';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get blogReadMore => 'Tap to read more';

  @override
  String get blogCollapse => 'Tap to collapse';

  @override
  String get blogError => 'Error loading blogs';

  @override
  String get blogLoading => 'Loading...';

  @override
  String blogFailed(Object status) {
    return 'Failed to load blogs ($status)';
  }
}
