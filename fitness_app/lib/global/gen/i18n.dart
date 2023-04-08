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
	/// "Done"
	String get button_Done => "Done";
	/// "Cancel"
	String get button_Cancel => "Cancel";
	/// "OK"
	String get button_Ok => "OK";
	/// ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"]
	List<String> get onboard_Title => ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"];
	/// ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"]
	List<String> get onboard_Description => ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"];
	/// ["English (US)", "Tiếng Việt"]
	List<String> get language => ["English (US)", "Tiếng Việt"];
	/// "Social"
	String get main_Social => "Social";
	/// "Home"
	String get main_Home => "Home";
	/// "Setting"
	String get main_Setting => "Setting";
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
	/// "Create New Account"
	String get signup_CreateNewAccount => "Create New Account";
	/// "By signing up, you agree to our"
	String get signup_BySigningUpYouAgreeTo => "By signing up, you agree to our";
	/// "Join us before?"
	String get signup_JoinUsBefore => "Join us before?";
	/// "Log in"
	String get signup_LogIn => "Log in";
	/// "Enter your full name"
	String get signup_EnterYourFullName => "Enter your full name";
	/// "Confirm your password"
	String get signup_ConfirmYourPassword => "Confirm your password";
	/// "Confirm Password"
	String get signup_ConfirmPassword => "Confirm Password";
	/// "Register"
	String get signup_Register => "Register";
	/// "Privacy Policy"
	String get signup_PrivacyPolicy => "Privacy Policy";
	/// "Verify code"
	String get signup_VerifyCode => "Verify code";
	/// "and"
	String get signup_And => "and";
	/// "Terms & Conditions"
	String get signup_TermsAndConditions => "Terms & Conditions";
	/// "Full name"
	String get signup_FullName => "Full name";
	/// "Full name is required"
	String get signup_FullNameIsRequired => "Full name is required";
	/// "Confirm password is required"
	String get signup_ConfirmPasswordIsRequired => "Confirm password is required";
	/// "Password not match"
	String get signup_PasswordNotMatch => "Password not match";
	/// "Forgot password"
	String get forgotPassword_Title => "Forgot password";
	/// "Please enter your email address to get login code"
	String get forgotPassword_Description => "Please enter your email address to get login code";
	/// "Get Code"
	String get forgotPassword_GetCode => "Get Code";
	/// "Ready to go"
	String get countdown_ReadyToGo => "Ready to go";
	/// "Start Now"
	String get countdown_StartNow => "Start Now";
	/// "Break time"
	String get countdown_BreakTime => "Break time";
	/// "You have finished ${count} exercises. Keep continue!"
	String countdown_YouHaveFinishCountEx(String count) => "You have finished ${count} exercises. Keep continue!";
	/// "Do not forget to drink water."
	String get countdown_DoNotForgetToDrinkWater => "Do not forget to drink water.";
	/// "Walk around"
	String get countdown_WalkAround => "Walk around";
	/// "Setting"
	String get setting_Title => "Setting";
	/// "Language"
	String get setting_Language => "Language";
	/// "Share with friends"
	String get setting_ShareWithFriends => "Share with friends";
	/// "Privacy policy"
	String get setting_PrivacyPolicy => "Privacy policy";
	/// "Terms and conditions"
	String get setting_TermsAndConditions => "Terms and conditions";
	/// "Change password"
	String get setting_ChangePassword => "Change password";
	/// "Log out"
	String get setting_Logout => "Log out";
	/// "Account"
	String get setting_Account => "Account";
	/// "Security"
	String get setting_Security => "Security";
	/// "About app"
	String get setting_AboutApp => "About app";
	/// "Please enter your old password, then enter the new password to proceed with the password change"
	String get setting_ChangePasswordDes => "Please enter your old password, then enter the new password to proceed with the password change";
	/// "Old password"
	String get setting_OldPassword => "Old password";
	/// "Enter your old password"
	String get setting_OldPasswordHint => "Enter your old password";
	/// "Old password is required"
	String get setting_OldPasswordRequired => "Old password is required";
	/// "New password"
	String get setting_NewPassword => "New password";
	/// "Enter your new password"
	String get setting_NewPasswordHint => "Enter your new password";
	/// "New password is required"
	String get setting_NewPasswordRequired => "New password is required";
	/// "Confirm new password"
	String get setting_ConfirmNewPassword => "Confirm new password";
	/// "Enter your confirm new password"
	String get setting_ConfirmNewPasswordHint => "Enter your confirm new password";
	/// "Confirm new password is required"
	String get setting_ConfirmNewPasswordRequired => "Confirm new password is required";
	/// "Password not match"
	String get setting_PasswordNotMatch => "Password not match";
	/// "Confirm logout"
	String get setting_ConfirmLogout => "Confirm logout";
	/// "You need confirm to logout from this app"
	String get setting_ConfirmLogoutDes => "You need confirm to logout from this app";
	/// "Confirm quit"
	String get exerciseDetail_QuitWorkout => "Confirm quit";
	/// "Are you sure you want to quit workout?"
	String get exerciseDetail_QuitWorkoutDes => "Are you sure you want to quit workout?";
	/// "Hooray!\n You have finished your workout."
	String get finish_Hooray => "Hooray!\n You have finished your workout.";
	/// "Go back to home"
	String get finish_GoBackToHome => "Go back to home";
	/// "Xác nhận thay đổi"
	String get setting_ConfirmChange => "Xác nhận thay đổi";
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
	/// "Xong"
	@override
	String get button_Done => "Xong";
	/// "Huỷ bỏ"
	@override
	String get button_Cancel => "Huỷ bỏ";
	/// "Đồng ý"
	@override
	String get button_Ok => "Đồng ý";
	/// ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"]
	@override
	List<String> get onboard_Title => ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"];
	/// ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"]
	@override
	List<String> get onboard_Description => ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"];
	/// ["English (US)", "Tiếng Việt"]
	@override
	List<String> get language => ["English (US)", "Tiếng Việt"];
	/// "Cộng đồng"
	@override
	String get main_Social => "Cộng đồng";
	/// "Trang chủ"
	@override
	String get main_Home => "Trang chủ";
	/// "Cài đặt"
	@override
	String get main_Setting => "Cài đặt";
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
	/// "Tạo tài khoản mới"
	@override
	String get signup_CreateNewAccount => "Tạo tài khoản mới";
	/// "Để tạo tài khoản mới, bạn phải đồng ý với chúng tôi về"
	@override
	String get signup_BySigningUpYouAgreeTo => "Để tạo tài khoản mới, bạn phải đồng ý với chúng tôi về";
	/// "Bạn đã có tài khoản?"
	@override
	String get signup_JoinUsBefore => "Bạn đã có tài khoản?";
	/// "Đăng nhập"
	@override
	String get signup_LogIn => "Đăng nhập";
	/// "Nhập tên của bạn"
	@override
	String get signup_EnterYourFullName => "Nhập tên của bạn";
	/// "Xác nhận mật khẩu của bạn"
	@override
	String get signup_ConfirmYourPassword => "Xác nhận mật khẩu của bạn";
	/// "Xác nhận mật khẩu"
	@override
	String get signup_ConfirmPassword => "Xác nhận mật khẩu";
	/// "Đăng Ký"
	@override
	String get signup_Register => "Đăng Ký";
	/// "Chính sách Bảo mật"
	@override
	String get signup_PrivacyPolicy => "Chính sách Bảo mật";
	/// "Xác minh mã"
	@override
	String get signup_VerifyCode => "Xác minh mã";
	/// "và"
	@override
	String get signup_And => "và";
	/// "Điều Khoản & Dịch Vụ"
	@override
	String get signup_TermsAndConditions => "Điều Khoản & Dịch Vụ";
	/// "Họ và tên"
	@override
	String get signup_FullName => "Họ và tên";
	/// "Họ và tên bắt buộc"
	@override
	String get signup_FullNameIsRequired => "Họ và tên bắt buộc";
	/// "Xác nhận mật khẩu bắt buộc"
	@override
	String get signup_ConfirmPasswordIsRequired => "Xác nhận mật khẩu bắt buộc";
	/// "Mật khẩu không khớp"
	@override
	String get signup_PasswordNotMatch => "Mật khẩu không khớp";
	/// "Quên mật khẩu"
	@override
	String get forgotPassword_Title => "Quên mật khẩu";
	/// "Vui lòng nhập địa chỉ email của bạn để nhận mã đăng nhập"
	@override
	String get forgotPassword_Description => "Vui lòng nhập địa chỉ email của bạn để nhận mã đăng nhập";
	/// "Lấy Mã Xác Nhận"
	@override
	String get forgotPassword_GetCode => "Lấy Mã Xác Nhận";
	/// "Sẵn sàng tập luyện"
	@override
	String get countdown_ReadyToGo => "Sẵn sàng tập luyện";
	/// "Bắt Đầu"
	@override
	String get countdown_StartNow => "Bắt Đầu";
	/// "Giải lao"
	@override
	String get countdown_BreakTime => "Giải lao";
	/// "Bạn đã hoàn thành ${count} bài tập. Hãy tiếp tục!"
	@override
	String countdown_YouHaveFinishCountEx(String count) => "Bạn đã hoàn thành ${count} bài tập. Hãy tiếp tục!";
	/// "Đừng quên uống nước nhé."
	@override
	String get countdown_DoNotForgetToDrinkWater => "Đừng quên uống nước nhé.";
	/// "Đi lại nhẹ nhàng"
	@override
	String get countdown_WalkAround => "Đi lại nhẹ nhàng";
	/// "Cài đặt"
	@override
	String get setting_Title => "Cài đặt";
	/// "Ngôn ngữ"
	@override
	String get setting_Language => "Ngôn ngữ";
	/// "Chia sẻ với bạn bè"
	@override
	String get setting_ShareWithFriends => "Chia sẻ với bạn bè";
	/// "Chính sách bảo mật"
	@override
	String get setting_PrivacyPolicy => "Chính sách bảo mật";
	/// "Điều khoản và điều kiện"
	@override
	String get setting_TermsAndConditions => "Điều khoản và điều kiện";
	/// "Thay đổi mật khẩu"
	@override
	String get setting_ChangePassword => "Thay đổi mật khẩu";
	/// "Đăng xuất"
	@override
	String get setting_Logout => "Đăng xuất";
	/// "Tài khoản"
	@override
	String get setting_Account => "Tài khoản";
	/// "Bảo mật"
	@override
	String get setting_Security => "Bảo mật";
	/// "Về ứng dụng"
	@override
	String get setting_AboutApp => "Về ứng dụng";
	/// "Vui lòng nhập mật khẩu cũ của bạn, sau đó nhập mật khẩu mới để tiến hành thay đổi mật khẩu"
	@override
	String get setting_ChangePasswordDes => "Vui lòng nhập mật khẩu cũ của bạn, sau đó nhập mật khẩu mới để tiến hành thay đổi mật khẩu";
	/// "Mật khẩu cũ"
	@override
	String get setting_OldPassword => "Mật khẩu cũ";
	/// "Nhập mật khẩu cũ của bạn"
	@override
	String get setting_OldPasswordHint => "Nhập mật khẩu cũ của bạn";
	/// "Mật khẩu cũ bắt buộc"
	@override
	String get setting_OldPasswordRequired => "Mật khẩu cũ bắt buộc";
	/// "Mật khẩu mới"
	@override
	String get setting_NewPassword => "Mật khẩu mới";
	/// "Nhập mật khẩu mới của bạn"
	@override
	String get setting_NewPasswordHint => "Nhập mật khẩu mới của bạn";
	/// "Mật khẩu mới bắt buộc"
	@override
	String get setting_NewPasswordRequired => "Mật khẩu mới bắt buộc";
	/// "Xác nhận mật khẩu mới"
	@override
	String get setting_ConfirmNewPassword => "Xác nhận mật khẩu mới";
	/// "Nhập xác nhận mật khẩu mới"
	@override
	String get setting_ConfirmNewPasswordHint => "Nhập xác nhận mật khẩu mới";
	/// "Xác nhận mật khẩu mới bắt buộc"
	@override
	String get setting_ConfirmNewPasswordRequired => "Xác nhận mật khẩu mới bắt buộc";
	/// "Mật khẩu không khớp"
	@override
	String get setting_PasswordNotMatch => "Mật khẩu không khớp";
	/// "Xác nhận đăng xuất"
	@override
	String get setting_ConfirmLogout => "Xác nhận đăng xuất";
	/// "Bạn cần xác nhận để đăng xuất khỏi ứng dụng"
	@override
	String get setting_ConfirmLogoutDes => "Bạn cần xác nhận để đăng xuất khỏi ứng dụng";
	/// "Confirm quit"
	@override
	String get exerciseDetail_QuitWorkout => "Confirm quit";
	/// "Are you sure you want to quit workout?"
	@override
	String get exerciseDetail_QuitWorkoutDes => "Are you sure you want to quit workout?";
	/// "Hooray!\n Bạn đã hoàn thành tất cả bài tập."
	@override
	String get finish_Hooray => "Hooray!\n Bạn đã hoàn thành tất cả bài tập.";
	/// "Trở về trang chủ"
	@override
	String get finish_GoBackToHome => "Trở về trang chủ";
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
