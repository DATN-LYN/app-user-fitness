import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale? _locale;
  static bool _shouldReload = false;
  static Locale? get locale => _locale;
  static set locale(Locale? newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback? onLocaleChanged;

  static I18n? of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);
  @override
  TextDirection get textDirection => TextDirection.ltr;
	/// "Fitness App"
	String get appName => "Fitness App";
	/// "Next"
	String get button_Next => "Next";
	/// ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"]
	List<String> get onboard_Title => ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"];
	/// ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"]
	List<String> get onboard_Description => ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"];
	/// "Email"
	String get login_Email => "Email";
	/// "Password"
	String get login_Password => "Password";
	/// "Enter your email"
	String get login_EmailHint => "Enter your email";
	/// "Enter your password"
	String get login_PasswordHint => "Enter your password";
	/// "Forgot password?"
	String get login_ForgotPassword => "Forgot password?";
	/// "Or log in with"
	String get login_OrLogInWith => "Or log in with";
	/// "Don't have an account? "
	String get login_DoNotHaveAnAccount => "Don't have an account? ";
	/// "Register now"
	String get login_RegisterNow => "Register now";
	/// "Log In"
	String get login_LogIn => "Log In";
	/// "Email is invalid"
	String get login_EmailNotValid => "Email is invalid";
	/// "Email is required"
	String get login_EmailIsRequired => "Email is required";
	/// "Password must be at least 6 characters"
	String get login_PasswordMustBeAtLeastSixCharacters => "Password must be at least 6 characters";
	/// "Password is required"
	String get login_PasswordIsRequired => "Password is required";
}
class _I18n_en_US extends I18n {
  const _I18n_en_US();
}
class _I18n_vi_VN extends I18n {
  const _I18n_vi_VN();
  @override
  TextDirection get textDirection => TextDirection.ltr;
	/// "App thể thao"
	@override
	String get appName => "App thể thao";
	/// "Tiếp tục"
	@override
	String get button_Next => "Tiếp tục";
	/// ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"]
	@override
	List<String> get onboard_Title => ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"];
	/// ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"]
	@override
	List<String> get onboard_Description => ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"];
	/// "Email"
	@override
	String get login_Email => "Email";
	/// "Mật khẩu"
	@override
	String get login_Password => "Mật khẩu";
	/// "Nhập email của bạn"
	@override
	String get login_EmailHint => "Nhập email của bạn";
	/// "Nhập mật khẩu của bạn"
	@override
	String get login_PasswordHint => "Nhập mật khẩu của bạn";
	/// "Quên mật khẩu?"
	@override
	String get login_ForgotPassword => "Quên mật khẩu?";
	/// "Hoặc đăng nhập bằng"
	@override
	String get login_OrLogInWith => "Hoặc đăng nhập bằng";
	/// "Chưa có tài khoản? "
	@override
	String get login_DoNotHaveAnAccount => "Chưa có tài khoản? ";
	/// "Đăng ký"
	@override
	String get login_RegisterNow => "Đăng ký";
	/// "Đăng Nhập"
	@override
	String get login_LogIn => "Đăng Nhập";
	/// "Email không hợp lệ"
	@override
	String get login_EmailNotValid => "Email không hợp lệ";
	/// "Email bắt buộc"
	@override
	String get login_EmailIsRequired => "Email bắt buộc";
	/// "Mật khẩu phải dài tối thiểu 6 ký tự"
	@override
	String get login_PasswordMustBeAtLeastSixCharacters => "Mật khẩu phải dài tối thiểu 6 ký tự";
	/// "Mật khẩu bắt buộc"
	@override
	String get login_PasswordIsRequired => "Mật khẩu bắt buộc";
}
class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
			Locale("vi", "VN")
    ];
  }

  LocaleResolutionCallback resolution({Locale? fallback}) {
    return (Locale? locale, Iterable<Locale> supported) {
      if (locale != null && isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale!.languageCode : "";
    if ("en_US" == lang) {
			return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
		}
		else if ("vi_VN" == lang) {
			return SynchronousFuture<WidgetsLocalizations>(const _I18n_vi_VN());
		}
    else if ("en" == languageCode) {
			return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
		}
		else if ("vi" == languageCode) {
			return SynchronousFuture<WidgetsLocalizations>(const _I18n_vi_VN());
		}

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length ; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}
