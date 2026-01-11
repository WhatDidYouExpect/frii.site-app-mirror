// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get donationPopupTitle => 'Oletko harkinnut lahjoitusta?';

  @override
  String get donationPopupText => 'frii.site ei ole ikinä ollut taloudellisesti kannattava, mutta menetämme enemmän rahaa kuin ikinä Namecheapin hintojen nousun takia. Jopa pienet lahjoitukset (esim. 1€ tai \$1) auttaisivat erittäin paljon.';

  @override
  String get donationPopupButton => 'Katso lahjoitusvaihtoehtoja';

  @override
  String get dontShowAgainButton => 'Älä näytä uudelleen';

  @override
  String get languageLabel => 'Kieli';

  @override
  String get cityLabel => 'Kaupunki';

  @override
  String get countryLabel => 'Maa';

  @override
  String get joinedLabel => 'Liittynyt';

  @override
  String get twoFaEnabledLabel => '2FA Päällä';

  @override
  String get referralCodeLabel => 'Suosittelukoodi';

  @override
  String get referredPeopleLabel => 'Suosittelun kautta liittyneet käyttäjät';

  @override
  String get maxDomainsLabel => 'Maksimi verkkotunnusten määrä';

  @override
  String get maxSubdomainsLabel => 'Maksimi aliverkkotunnusten määrä';

  @override
  String get userDetailsAccessLabel => 'Tilitietojen käyttöoikeus';

  @override
  String get ownedTldsLabel => 'Omistetut TLD:t';

  @override
  String get discordLinkedLabel => 'Discord linkitetty';

  @override
  String get yes => 'Kyllä';

  @override
  String get no => 'Ei';

  @override
  String get none => 'Ei määritelty';

  @override
  String get notAvailable => 'Ei yhtään';

  @override
  String get unknown => 'Tuntematon';

  @override
  String modifyDomainTitle(Object domain) {
    return 'Muokkaa $domain';
  }

  @override
  String get deleteDomainWarning => 'Tätä ei voi perua.';

  @override
  String deleteDomainTitle(Object domain) {
    return 'Haluatko poistaa $domain?';
  }

  @override
  String get valueLabel => 'Arvo';

  @override
  String get typeLabel => 'Tyyppi';

  @override
  String get yourIpLabel => 'IP-Osoitteesi';

  @override
  String get useYourIpButton => 'Päivitä verkkotunnuksesi IP-osoitteeseesi';

  @override
  String get saveButton => 'Tallenna';

  @override
  String get deleteButton => 'Poista';

  @override
  String get domainModifiedSuccess => 'Verkkotunnuksen muokkaus onnistui!';

  @override
  String get domainModifyError => 'Verkkotunnuksen muokkaus epäonnistui';

  @override
  String get domainDeletedSuccess => 'Verkkotunnus poistetiin!';

  @override
  String get domainDeleteError => 'Verkkotunnuksen poistamisessa tapahtui virhe';

  @override
  String get ipLabel => 'IP';

  @override
  String get lastUpdatedLabel => 'Viimeksi päivitetty';

  @override
  String get unableToFetchIp => 'IP-osoitteen hankkiminen epäonnistui';

  @override
  String get modifyButton => 'Muokkaa';

  @override
  String get noInternetTitle => 'Ei internet-yhteyttä';

  @override
  String get noInternetMessage => 'Laitteesi on offline-tilassa. Tarkista yhteytesi.';

  @override
  String get okButton => 'OK';

  @override
  String get registerDomainTitle => 'Rekisteröi verkkotunnus';

  @override
  String get domainLabel => 'Verkkotunnus';

  @override
  String invalidDomainMessage(Object domain) {
    return 'Verkkotunnuksen täytyy olla: $domain.frii.site, $domain.pill.ovh, tai $domain.arrh.ovh';
  }

  @override
  String get registerButton => 'Rekisteröi';

  @override
  String get cancelButton => 'Peru';

  @override
  String helloUser(Object name) {
    return 'Hei, $name!';
  }

  @override
  String get domainRegisteredSuccess => 'Verkkotunnus rekisteröitiin onnistuneesti!';

  @override
  String get domainRegisterError => 'Virhe';

  @override
  String get drawerDashboard => 'Kojelauta';

  @override
  String get drawerAccount => 'Käyttäjä';

  @override
  String get drawerBlogs => 'Blogit';

  @override
  String get drawerLogs => 'Lokit';

  @override
  String get refreshDomainsTooltip => 'Virkistä verkkotunnukset';

  @override
  String get settingsTooltip => 'Asetukset';

  @override
  String get appBarTitle => 'frii.site';

  @override
  String get account => 'Käyttäjä';

  @override
  String get logout => 'Kirjaudu ulos';

  @override
  String get name => 'Nimi';

  @override
  String get emailLabel => 'Sähköposti';

  @override
  String get lastLogin => 'Viimeinen kirjautuminen';

  @override
  String get viewLogs => 'Näytä lokit';

  @override
  String get failedLoadProfile => 'Profiilin lataaminen epäonnistui';

  @override
  String get settings => 'Asetukset';

  @override
  String get apiToken => 'API-avain';

  @override
  String get apiUrl => 'API URL';

  @override
  String get selectTheme => 'Valitse teema';

  @override
  String get selectLanguage => 'Valitse kieli';

  @override
  String get cancel => 'Peruuta';

  @override
  String get save => 'Tallenna';

  @override
  String get blogReadMore => 'Napsaute lukeakseen lisää';

  @override
  String get blogCollapse => 'Napsauta minimoiakseen';

  @override
  String get blogError => 'Blogien lataus epäonnistui';

  @override
  String get blogLoading => 'Ladataan...';

  @override
  String blogFailed(Object status) {
    return 'Blogien lataaminen epäonnistui ($status)';
  }
}
