// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get donationPopupTitle => 'Hai pensato di fare una donazione?';

  @override
  String get donationPopupText => 'frii.site non è mai stato redditizio, ma a causa dell\'aumento dei prezzi del nostro dominio da parte di Namecheap, stiamo perdendo più soldi che mai. Anche piccole donazioni (ad esempio €1 o 1 Fr.) sarebbero di grande aiuto.';

  @override
  String get donationPopupButton => 'Vedi le opzioni di donazione';

  @override
  String get dontShowAgainButton => 'Non mostrare più';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get cityLabel => 'Città';

  @override
  String get countryLabel => 'Paese';

  @override
  String get joinedLabel => 'Iscritto il';

  @override
  String get twoFaEnabledLabel => '2FA attivo';

  @override
  String get referralCodeLabel => 'Codice Referral';

  @override
  String get referredPeopleLabel => 'Persone Referite';

  @override
  String get maxDomainsLabel => 'Domini Massimi';

  @override
  String get maxSubdomainsLabel => 'Sottodomini Massimi';

  @override
  String get userDetailsAccessLabel => 'Accesso Dettagli Utente';

  @override
  String get ownedTldsLabel => 'TLD Posseduti';

  @override
  String get discordLinkedLabel => 'Discord Collegato';

  @override
  String get yes => 'Sì';

  @override
  String get no => 'No';

  @override
  String get none => 'Nessuno';

  @override
  String get notAvailable => 'N/D';

  @override
  String get unknown => 'Sconosciuto';

  @override
  String modifyDomainTitle(Object domain) {
    return 'Modifica $domain';
  }

  @override
  String get deleteDomainWarning => 'Questa azione non può essere annullata.';

  @override
  String deleteDomainTitle(Object domain) {
    return 'Eliminare $domain?';
  }

  @override
  String get valueLabel => 'Valore';

  @override
  String get typeLabel => 'Tipo';

  @override
  String get yourIpLabel => 'Il tuo IP';

  @override
  String get useYourIpButton => 'Usa il tuo IP come valore';

  @override
  String get saveButton => 'Salva';

  @override
  String get deleteButton => 'Elimina';

  @override
  String get domainModifiedSuccess => 'Dominio modificato con successo!';

  @override
  String get domainModifyError => 'Errore durante la modifica del dominio';

  @override
  String get domainDeletedSuccess => 'Dominio eliminato con successo!';

  @override
  String get domainDeleteError => 'Errore durante l\'eliminazione del dominio';

  @override
  String get ipLabel => 'IP';

  @override
  String get lastUpdatedLabel => 'Ultimo aggiornamento';

  @override
  String get unableToFetchIp => 'Impossibile ottenere l\'IP';

  @override
  String get modifyButton => 'Modifica';

  @override
  String get noInternetTitle => 'Nessuna connessione';

  @override
  String get noInternetMessage => 'Il tuo dispositivo è offline. Controlla la connessione.';

  @override
  String get okButton => 'OK';

  @override
  String get registerDomainTitle => 'Registra Dominio';

  @override
  String get domainLabel => 'Dominio';

  @override
  String invalidDomainMessage(Object domain) {
    return 'Il dominio deve essere: $domain.frii.site, $domain.pill.ovh o $domain.arrh.ovh';
  }

  @override
  String get registerButton => 'Registra';

  @override
  String get cancelButton => 'Annulla';

  @override
  String helloUser(Object name) {
    return 'Ciao, $name!';
  }

  @override
  String get domainRegisteredSuccess => 'Dominio registrato con successo!';

  @override
  String get domainRegisterError => 'Errore';

  @override
  String get drawerDashboard => 'Dashboard';

  @override
  String get drawerAccount => 'Account';

  @override
  String get drawerBlogs => 'Blog';

  @override
  String get drawerLogs => 'Log';

  @override
  String get refreshDomainsTooltip => 'Aggiorna Domini';

  @override
  String get settingsTooltip => 'Impostazioni';

  @override
  String get appBarTitle => 'frii.site';

  @override
  String get account => 'Account';

  @override
  String get logout => 'Disconnetti';

  @override
  String get name => 'Nome';

  @override
  String get emailLabel => 'Email';

  @override
  String get lastLogin => 'Ultimo accesso';

  @override
  String get viewLogs => 'Visualizza log';

  @override
  String get failedLoadProfile => 'Impossibile caricare il profilo';

  @override
  String get settings => 'Impostazioni';

  @override
  String get apiToken => 'Token API';

  @override
  String get apiUrl => 'URL API';

  @override
  String get selectTheme => 'Seleziona tema';

  @override
  String get selectLanguage => 'Seleziona lingua';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get blogReadMore => 'Tocca per leggere di più';

  @override
  String get blogCollapse => 'Tocca per ridurre';

  @override
  String get blogError => 'Errore nel caricamento dei blog';

  @override
  String get blogLoading => 'Caricamento...';

  @override
  String blogFailed(Object status) {
    return 'Impossibile caricare i blog ($status)';
  }
}
