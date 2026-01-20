// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get apiPopupTitle => 'First sail';

  @override
  String get apiPopupText => 'Yer API key be missin’. Set it in the holdin’ and grant all permissions, aye.';

  @override
  String get apiPopupButton => 'Fetch yer API key';

  @override
  String get donationPopupTitle => 'Care to toss a coin to the crew?';

  @override
  String get donationPopupText => 'frii.site’s never filled the treasure chest, and with Namecheap raisin’ the domain tolls, we be losin’ more gold than ever. Even a wee donation (like 1€ or \$1) would help keep us afloat.';

  @override
  String get donationPopupButton => 'Spy donation options';

  @override
  String get dontShowAgainButton => 'Don’t show again, savvy?';

  @override
  String get languageLabel => 'Tongue';

  @override
  String get cityLabel => 'Port o’ call';

  @override
  String get countryLabel => 'Realm';

  @override
  String get joinedLabel => 'Signed aboard';

  @override
  String get twoFaEnabledLabel => '2FA Hoisted';

  @override
  String get referralCodeLabel => 'Referral Code';

  @override
  String get referredPeopleLabel => 'Crew Recruited';

  @override
  String get maxDomainsLabel => 'Max Domains';

  @override
  String get maxSubdomainsLabel => 'Max Subdomains';

  @override
  String get userDetailsAccessLabel => 'Crew Details Access';

  @override
  String get ownedTldsLabel => 'Owned TLDs';

  @override
  String get discordLinkedLabel => 'Discord Linked';

  @override
  String get yes => 'Aye';

  @override
  String get no => 'Nay';

  @override
  String get none => 'None';

  @override
  String get notAvailable => 'N/A';

  @override
  String get unknown => 'Unknown';

  @override
  String modifyDomainTitle(Object domain) {
    return 'Tinker with $domain';
  }

  @override
  String get deleteDomainWarning => 'Once scuttled, it be gone forever.';

  @override
  String deleteDomainTitle(Object domain) {
    return 'Scuttle $domain?';
  }

  @override
  String get valueLabel => 'Value';

  @override
  String get typeLabel => 'Type';

  @override
  String get yourIpLabel => 'Yer IP';

  @override
  String get useYourIpButton => 'Set domain to yer IP';

  @override
  String get saveButton => 'Stow it';

  @override
  String get deleteButton => 'Scuttle';

  @override
  String get domainModifiedSuccess => 'Domain tweaked with success!';

  @override
  String get domainModifyError => 'Blimey! Error tweakin’ domain';

  @override
  String get domainDeletedSuccess => 'Domain scuttled successfully!';

  @override
  String get domainDeleteError => 'Arrr! Error scuttlin’ domain';

  @override
  String get ipLabel => 'IP';

  @override
  String get lastUpdatedLabel => 'Last Updated';

  @override
  String get unableToFetchIp => 'Can’t fetch the IP, matey';

  @override
  String get modifyButton => 'Tinker';

  @override
  String get noInternetTitle => 'No Wind in the Sails';

  @override
  String get noInternetMessage => 'Yer device be adrift. Check yer connection.';

  @override
  String get okButton => 'Aye aye';

  @override
  String get registerDomainTitle => 'Claim a Domain';

  @override
  String get domainLabel => 'Domain';

  @override
  String invalidDomainMessage(Object domain) {
    return 'Domain must be: $domain.frii.site, $domain.pill.ovh, or $domain.arrh.ovh';
  }

  @override
  String get registerButton => 'Claim it';

  @override
  String get cancelButton => 'Belay that';

  @override
  String helloUser(Object name) {
    return 'Ahoy, $name!';
  }

  @override
  String get domainRegisteredSuccess => 'Domain claimed successfully!';

  @override
  String get domainRegisterError => 'Error';

  @override
  String get drawerDashboard => 'Captain’s Deck';

  @override
  String get drawerAccount => 'Yer Account';

  @override
  String get drawerBlogs => 'Ship Logs';

  @override
  String get drawerLogs => 'Logs';

  @override
  String get refreshDomainsTooltip => 'Refresh Domains';

  @override
  String get settingsTooltip => 'Riggin’';

  @override
  String get appBarTitle => 'arrh.ovh';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Abandon Ship';

  @override
  String get name => 'Name';

  @override
  String get emailLabel => 'Email';

  @override
  String get lastLogin => 'Last Watch';

  @override
  String get viewLogs => 'View Logs';

  @override
  String get failedLoadProfile => 'Failed to load profile';

  @override
  String get settings => 'Riggin’';

  @override
  String get apiToken => 'API Token';

  @override
  String get apiUrl => 'API URL';

  @override
  String get selectTheme => 'Choose Yer Colors';

  @override
  String get selectLanguage => 'Choose Yer Tongue';

  @override
  String get cancel => 'Belay';

  @override
  String get save => 'Stow';

  @override
  String get blogReadMore => 'Tap to read more, savvy?';

  @override
  String get blogCollapse => 'Tap to fold it up';

  @override
  String get blogError => 'Error loadin’ ship logs';

  @override
  String get blogLoading => 'Loadin’...';

  @override
  String blogFailed(Object status) {
    return 'Failed to load logs ($status)';
  }
}
