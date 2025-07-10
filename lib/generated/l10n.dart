// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(
      _current != null,
      'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(
      instance != null,
      'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
      context,
      GeneratedLocalization,
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Statistics`
  String get statistics {
    return Intl.message('Statistics', name: 'statistics', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `QR Scanner`
  String get qrScannerTitle {
    return Intl.message(
      'QR Scanner',
      name: 'qrScannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tap the button to scan a QR code`
  String get qrScannerSubtitle {
    return Intl.message(
      'Tap the button to scan a QR code',
      name: 'qrScannerSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Open Scanner`
  String get openScanner {
    return Intl.message(
      'Open Scanner',
      name: 'openScanner',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Debates`
  String get debates {
    return Intl.message('Debates', name: 'debates', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Topic`
  String get topic {
    return Intl.message('Topic', name: 'topic', desc: '', args: []);
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Ongoing`
  String get ongoing {
    return Intl.message('Ongoing', name: 'ongoing', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Viewing Details`
  String get viewingDetails {
    return Intl.message(
      'Viewing Details',
      name: 'viewingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Sharing`
  String get sharing {
    return Intl.message('Sharing', name: 'sharing', desc: '', args: []);
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Timer`
  String get timer {
    return Intl.message('Timer', name: 'timer', desc: '', args: []);
  }

  /// `Choose language`
  String get chooseLanguage {
    return Intl.message(
      'Choose language',
      name: 'chooseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose theme mode`
  String get chooseTheme {
    return Intl.message(
      'Choose theme mode',
      name: 'chooseTheme',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Login`
  String get loginTitle {
    return Intl.message('Login', name: 'loginTitle', desc: '', args: []);
  }

  /// `Enter your credentials to log in`
  String get loginSubtitle {
    return Intl.message(
      'Enter your credentials to log in',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Log In`
  String get loginButton {
    return Intl.message('Log In', name: 'loginButton', desc: '', args: []);
  }

  /// `Invalid username or password`
  String get invalidCredentials {
    return Intl.message(
      'Invalid username or password',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Settings saved successfully!`
  String get savedSuccessfully {
    return Intl.message(
      'Settings saved successfully!',
      name: 'savedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Profile Information`
  String get profileInfo {
    return Intl.message(
      'Profile Information',
      name: 'profileInfo',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `This page is empty`
  String get empty_page {
    return Intl.message(
      'This page is empty',
      name: 'empty_page',
      desc: '',
      args: [],
    );
  }

  /// `QR Code Scanned`
  String get scanned_qr_code {
    return Intl.message(
      'QR Code Scanned',
      name: 'scanned_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Successfully scanned QR code:`
  String get successfully_scanned {
    return Intl.message(
      'Successfully scanned QR code:',
      name: 'successfully_scanned',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to use this QR code?`
  String get wanna_use {
    return Intl.message(
      'Do you want to use this QR code?',
      name: 'wanna_use',
      desc: '',
      args: [],
    );
  }

  /// `Scan again`
  String get scan_again {
    return Intl.message('Scan again', name: 'scan_again', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Position the QR code within the frame to scan`
  String get camera_position {
    return Intl.message(
      'Position the QR code within the frame to scan',
      name: 'camera_position',
      desc: '',
      args: [],
    );
  }

  /// `Camera Error:`
  String get camera_error {
    return Intl.message(
      'Camera Error:',
      name: 'camera_error',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get go_back {
    return Intl.message('Go Back', name: 'go_back', desc: '', args: []);
  }

  /// `Scan QR`
  String get scan_appbar {
    return Intl.message('Scan QR', name: 'scan_appbar', desc: '', args: []);
  }

  /// `Error restarting camera:`
  String get error_restarting_qrScanner {
    return Intl.message(
      'Error restarting camera:',
      name: 'error_restarting_qrScanner',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get logout_title {
    return Intl.message(
      'Confirm Logout',
      name: 'logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out of your account?`
  String get logout_message {
    return Intl.message(
      'Are you sure you want to log out of your account?',
      name: 'logout_message',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Log Out`
  String get confirm_log_out {
    return Intl.message(
      'Yes, Log Out',
      name: 'confirm_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `No data available yet`
  String get no_data {
    return Intl.message(
      'No data available yet',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `User Info`
  String get user_info {
    return Intl.message('User Info', name: 'user_info', desc: '', args: []);
  }

  /// `Ticket Info`
  String get ticket_info {
    return Intl.message('Ticket Info', name: 'ticket_info', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Age Group`
  String get age_group {
    return Intl.message('Age Group', name: 'age_group', desc: '', args: []);
  }

  /// `Ticket ID`
  String get ticket_id {
    return Intl.message('Ticket ID', name: 'ticket_id', desc: '', args: []);
  }

  /// `Debate ID`
  String get debate_id {
    return Intl.message('Debate ID', name: 'debate_id', desc: '', args: []);
  }

  /// `Do you want to confirm check-in for this user?`
  String get confirm_checkin_prompt {
    return Intl.message(
      'Do you want to confirm check-in for this user?',
      name: 'confirm_checkin_prompt',
      desc: '',
      args: [],
    );
  }

  /// `Processing ticket...`
  String get processing_ticket {
    return Intl.message(
      'Processing ticket...',
      name: 'processing_ticket',
      desc: '',
      args: [],
    );
  }

  /// `Returning to previous page...`
  String get returning_previous_page {
    return Intl.message(
      'Returning to previous page...',
      name: 'returning_previous_page',
      desc: '',
      args: [],
    );
  }

  /// `Check-in Successful`
  String get success_title {
    return Intl.message(
      'Check-in Successful',
      name: 'success_title',
      desc: '',
      args: [],
    );
  }

  /// `The user has been successfully checked in.`
  String get success_message {
    return Intl.message(
      'The user has been successfully checked in.',
      name: 'success_message',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Statistics are not available yet...`
  String get statistics_not_available_yet {
    return Intl.message(
      'Statistics are not available yet...',
      name: 'statistics_not_available_yet',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `English Level`
  String get english_level {
    return Intl.message(
      'English Level',
      name: 'english_level',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uz'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
