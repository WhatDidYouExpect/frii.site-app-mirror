import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it')
  ];

  /// No description provided for @donationPopupTitle.
  ///
  /// In en, this message translates to:
  /// **'Have you considered donating?'**
  String get donationPopupTitle;

  /// No description provided for @donationPopupText.
  ///
  /// In en, this message translates to:
  /// **'frii.site has never been profitable, but due to Namecheap raising our domain\'s prices, we are losing more money than we ever have. Even small donations (e.g. 1€ or \$1) would help out immensely.'**
  String get donationPopupText;

  /// No description provided for @donationPopupButton.
  ///
  /// In en, this message translates to:
  /// **'View donation options'**
  String get donationPopupButton;

  /// No description provided for @dontShowAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Don\'t show again'**
  String get dontShowAgainButton;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @countryLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryLabel;

  /// No description provided for @joinedLabel.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joinedLabel;

  /// No description provided for @twoFaEnabledLabel.
  ///
  /// In en, this message translates to:
  /// **'2FA Enabled'**
  String get twoFaEnabledLabel;

  /// No description provided for @referralCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referralCodeLabel;

  /// No description provided for @referredPeopleLabel.
  ///
  /// In en, this message translates to:
  /// **'Referred People'**
  String get referredPeopleLabel;

  /// No description provided for @maxDomainsLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Domains'**
  String get maxDomainsLabel;

  /// No description provided for @maxSubdomainsLabel.
  ///
  /// In en, this message translates to:
  /// **'Max Subdomains'**
  String get maxSubdomainsLabel;

  /// No description provided for @userDetailsAccessLabel.
  ///
  /// In en, this message translates to:
  /// **'User Details Access'**
  String get userDetailsAccessLabel;

  /// No description provided for @ownedTldsLabel.
  ///
  /// In en, this message translates to:
  /// **'Owned TLDs'**
  String get ownedTldsLabel;

  /// No description provided for @discordLinkedLabel.
  ///
  /// In en, this message translates to:
  /// **'Discord Linked'**
  String get discordLinkedLabel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @modifyDomainTitle.
  ///
  /// In en, this message translates to:
  /// **'Modify {domain}'**
  String modifyDomainTitle(Object domain);

  /// No description provided for @deleteDomainWarning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteDomainWarning;

  /// No description provided for @deleteDomainTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {domain}?'**
  String deleteDomainTitle(Object domain);

  /// No description provided for @valueLabel.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get valueLabel;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get typeLabel;

  /// No description provided for @yourIpLabel.
  ///
  /// In en, this message translates to:
  /// **'Your IP'**
  String get yourIpLabel;

  /// No description provided for @useYourIpButton.
  ///
  /// In en, this message translates to:
  /// **'Use Your IP as Value'**
  String get useYourIpButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @domainModifiedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Domain modified successfully!'**
  String get domainModifiedSuccess;

  /// No description provided for @domainModifyError.
  ///
  /// In en, this message translates to:
  /// **'Error modifying domain'**
  String get domainModifyError;

  /// No description provided for @domainDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Domain deleted successfully!'**
  String get domainDeletedSuccess;

  /// No description provided for @domainDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting domain'**
  String get domainDeleteError;

  /// No description provided for @ipLabel.
  ///
  /// In en, this message translates to:
  /// **'IP'**
  String get ipLabel;

  /// No description provided for @lastUpdatedLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Updated'**
  String get lastUpdatedLabel;

  /// No description provided for @unableToFetchIp.
  ///
  /// In en, this message translates to:
  /// **'Unable to fetch IP'**
  String get unableToFetchIp;

  /// No description provided for @modifyButton.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modifyButton;

  /// No description provided for @noInternetTitle.
  ///
  /// In en, this message translates to:
  /// **'No Internet'**
  String get noInternetTitle;

  /// No description provided for @noInternetMessage.
  ///
  /// In en, this message translates to:
  /// **'Your device is offline. Please check your connection.'**
  String get noInternetMessage;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @registerDomainTitle.
  ///
  /// In en, this message translates to:
  /// **'Register Domain'**
  String get registerDomainTitle;

  /// No description provided for @domainLabel.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domainLabel;

  /// No description provided for @invalidDomainMessage.
  ///
  /// In en, this message translates to:
  /// **'Domain must be: {domain}.frii.site, {domain}.pill.ovh, or {domain}.arrh.ovh'**
  String invalidDomainMessage(Object domain);

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @helloUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String helloUser(Object name);

  /// No description provided for @domainRegisteredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Domain registered successfully!'**
  String get domainRegisteredSuccess;

  /// No description provided for @domainRegisterError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get domainRegisterError;

  /// No description provided for @drawerDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get drawerDashboard;

  /// No description provided for @drawerAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get drawerAccount;

  /// No description provided for @drawerBlogs.
  ///
  /// In en, this message translates to:
  /// **'Blogs'**
  String get drawerBlogs;

  /// No description provided for @drawerLogs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get drawerLogs;

  /// No description provided for @refreshDomainsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh Domains'**
  String get refreshDomainsTooltip;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// No description provided for @appBarTitle.
  ///
  /// In en, this message translates to:
  /// **'frii.site'**
  String get appBarTitle;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @lastLogin.
  ///
  /// In en, this message translates to:
  /// **'Last Login'**
  String get lastLogin;

  /// No description provided for @viewLogs.
  ///
  /// In en, this message translates to:
  /// **'View Logs'**
  String get viewLogs;

  /// No description provided for @failedLoadProfile.
  ///
  /// In en, this message translates to:
  /// **'Failed to load profile'**
  String get failedLoadProfile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @apiToken.
  ///
  /// In en, this message translates to:
  /// **'API Token'**
  String get apiToken;

  /// No description provided for @apiUrl.
  ///
  /// In en, this message translates to:
  /// **'API URL'**
  String get apiUrl;

  /// No description provided for @selectTheme.
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @blogReadMore.
  ///
  /// In en, this message translates to:
  /// **'Tap to read more'**
  String get blogReadMore;

  /// No description provided for @blogCollapse.
  ///
  /// In en, this message translates to:
  /// **'Tap to collapse'**
  String get blogCollapse;

  /// No description provided for @blogError.
  ///
  /// In en, this message translates to:
  /// **'Error loading blogs'**
  String get blogError;

  /// No description provided for @blogLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get blogLoading;

  /// No description provided for @blogFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load blogs ({status})'**
  String blogFailed(Object status);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'it'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'it': return AppLocalizationsIt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
