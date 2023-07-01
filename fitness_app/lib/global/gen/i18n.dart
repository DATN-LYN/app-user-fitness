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
	/// "Try Again"
	String get button_TryAgain => "Try Again";
	/// "Apply"
	String get button_Apply => "Apply";
	/// "Send"
	String get button_Send => "Send";
	/// "Reset"
	String get button_Reset => "Reset";
	/// ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"]
	List<String> get onboard_Title => ["JOIN US", "DAILY WORKOUT", "SET DIET PLAN"];
	/// ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"]
	List<String> get onboard_Description => ["Our teams with iconic athletes & sport brands to build the future of fitness", "Workout plans designed to  help you achieve your everyday fitness goals and plan", "Before you begin designing your own diet plan, some self-reflection is in order"];
	/// ["English (US)", "Tiếng Việt"]
	List<String> get language => ["English (US)", "Tiếng Việt"];
	/// ["Beginner", "Intermediate", "Advanced"]
	List<String> get workoutLevel => ["Beginner", "Intermediate", "Advanced"];
	/// "Chat"
	String get main_Chat => "Chat";
	/// "Home"
	String get main_Home => "Home";
	/// "Setting"
	String get main_Setting => "Setting";
	/// "Statistics"
	String get main_Statistics => "Statistics";
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
	/// "Age"
	String get signup_Age => "Age";
	/// "Age is required"
	String get signup_AgeIsRequired => "Age is required";
	/// "Enter your age"
	String get signup_EnterYourAge => "Enter your age";
	/// "You have registered successfully"
	String get signup_RegisterSuccess => "You have registered successfully";
	/// "Back to login"
	String get signup_BackToLogin => "Back to login";
	/// "Gender"
	String get signup_Gender => "Gender";
	/// "You account is inactive. Please contact admin at admin_fitness@gmail.com for help."
	String get signup_InactiveAccount => "You account is inactive. Please contact admin at admin_fitness@gmail.com for help.";
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
	/// "Edit Profile"
	String get setting_EditProfile => "Edit Profile";
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
	/// "Are you sure you want to change your password?"
	String get setting_ChangePasswordConfirm => "Are you sure you want to change your password?";
	/// "Your password has been updated successfully."
	String get setting_ChangePasswordSuccess => "Your password has been updated successfully.";
	/// "Confirm quit"
	String get exerciseDetail_QuitWorkout => "Confirm quit";
	/// "Are you sure you want to quit workout?"
	String get exerciseDetail_QuitWorkoutDes => "Are you sure you want to quit workout?";
	/// "Hooray!\n You have finished your workout."
	String get finish_Hooray => "Hooray!\n You have finished your workout.";
	/// "Go back to home"
	String get finish_GoBackToHome => "Go back to home";
	/// "Health Care Chat"
	String get chat_Title => "Health Care Chat";
	/// "Recent Workout"
	String get statistics_RecentWorkout => "Recent Workout";
	/// "You have burnt"
	String get statistics_YouHaveBurnt => "You have burnt";
	/// "this week"
	String get statistics_ThisWeek => "this week";
	/// "this month"
	String get statistics_ThisMonth => "this month";
	/// "calories"
	String get statistics_Calories => "calories";
	/// "What a great value!"
	String get statistics_WhatAGreatValue => "What a great value!";
	/// "Body Count History"
	String get statistics_BodyCountHistory => "Body Count History";
	/// "Select month"
	String get statistics_SelectMonth => "Select month";
	/// ["Upper", "Downer", "Abs", "Full Body"]
	List<String> get workoutBodyPart => ["Upper", "Downer", "Abs", "Full Body"];
	/// "Categories"
	String get categories_Categories => "Categories";
	/// "Category Not Found"
	String get categories_CategoryNotFound => "Category Not Found";
	/// "Input category name"
	String get categories_SearchHint => "Input category name";
	/// "Exercise"
	String get exercises_Exercises => "Exercise";
	/// "Exercise Not Found"
	String get exercises_ExerciseNotFound => "Exercise Not Found";
	/// "Programs"
	String get programs_Programs => "Programs";
	/// "Program Not Found"
	String get programs_ProgramNotFound => "Program Not Found";
	/// "Newest Programs"
	String get programs_NewestPrograms => "Newest Programs";
	/// "Most Viewed Programs"
	String get programs_MostViewedPrograms => "Most Viewed Programs";
	/// "Input program name"
	String get programs_SearchHint => "Input program name";
	/// "Description"
	String get programs_Description => "Description";
	/// "Filter"
	String get programs_Filter => "Filter";
	/// "Views"
	String get programs_View => "Views";
	/// "Choose a category"
	String get programs_ChooseCategory => "Choose a category";
	/// "Inboxes"
	String get inboxes_Inboxes => "Inboxes";
	/// "Inbox Not Found"
	String get inboxes_InboxNotFound => "Inbox Not Found";
	/// "Empty Data"
	String get common_EmptyData => "Empty Data";
	/// "Please pull to refresh data"
	String get common_PleasePullToTryAgain => "Please pull to refresh data";
	/// "Search"
	String get common_Search => "Search";
	/// "Minutes"
	String get common_Minutes => "Minutes";
	/// "Calories"
	String get common_Calories => "Calories";
	/// "Duration"
	String get common_Duration => "Duration";
	/// "Weekly"
	String get common_Weekly => "Weekly";
	/// "Monthly"
	String get common_Monthly => "Monthly";
	/// "Yearly"
	String get common_Yearly => "Yearly";
	/// "Level"
	String get common_Level => "Level";
	/// "Body Part"
	String get common_BodyPart => "Body Part";
	/// "Success"
	String get common_Success => "Success";
	/// "Oops!"
	String get common_Oops => "Oops!";
	/// "Please log in to use this feature"
	String get common_YouHaveToLogin => "Please log in to use this feature";
	/// "Description"
	String get common_Description => "Description";
	/// "Hello"
	String get home_Hello => "Hello";
	/// "Have a nice day"
	String get home_HaveANiceDay => "Have a nice day";
	/// "View all"
	String get home_ViewAll => "View all";
	/// "User"
	String get home_User => "User";
	/// "Recent Searches"
	String get search_RecentSearches => "Recent Searches";
	/// "Clear All"
	String get search_ClearAll => "Clear All";
	/// "Update Profile"
	String get editProfile_Title => "Update Profile";
	/// "Are you sure you want to update your profile?"
	String get editProfile_EditDes => "Are you sure you want to update your profile?";
	/// "Your profile has been updated successfully."
	String get editProfile_UpdateSuccess => "Your profile has been updated successfully.";
	/// ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
	List<String> get weekDays_ => ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
	/// "Content"
	String get support_Content => "Content";
	/// "Status"
	String get support_Status => "Status";
	/// ["Waiting", "Solving", "Done", "Cancelled"]
	List<String> get support_SupportStatus => ["Waiting", "Solving", "Done", "Cancelled"];
	/// "Support Request Details"
	String get support_SupportDetails => "Support Request Details";
	/// "Support"
	String get support_Title => "Support";
	/// "Tell us your problem"
	String get support_Description => "Tell us your problem";
	/// "Enter your question,problem,..."
	String get support_ContentHint => "Enter your question,problem,...";
	/// "Content is required"
	String get support_ContentRequired => "Content is required";
	/// "Upload Photo"
	String get support_UploadPhoto => "Upload Photo";
	/// "Take Photo"
	String get support_TakePhoto => "Take Photo";
	/// "Choose From Gallery"
	String get support_ChooseFormGallery => "Choose From Gallery";
	/// "Pick a image"
	String get support_PickImage => "Pick a image";
	/// "Image"
	String get support_Image => "Image";
	/// "Create support request"
	String get support_CreateTitle => "Create support request";
	/// "Are you sure you want to create a new support request?"
	String get support_CreateDes => "Are you sure you want to create a new support request?";
	/// "You have created a support request successfully"
	String get support_CreateSuccess => "You have created a support request successfully";
	/// "Cancel support request"
	String get support_CancelTitle => "Cancel support request";
	/// "Are you sure you want to cancel your support request?"
	String get support_CancelDes => "Are you sure you want to cancel your support request?";
	/// "You have cancelled a support request successfully"
	String get support_CancelSuccess => "You have cancelled a support request successfully";
	/// "Update support request"
	String get support_UpdateTitle => "Update support request";
	/// "Are you sure you want to update your support request?"
	String get support_UpdateDes => "Are you sure you want to update your support request?";
	/// "You have updated a support request successfully"
	String get support_UpdateSuccess => "You have updated a support request successfully";
	/// "Chart"
	String get chart_Chart => "Chart";
	/// ["column", "bar", "line", "stepline"]
	List<String> get chart_ChartType => ["column", "bar", "line", "stepline"];
	/// ["Male", "Female", "Others"]
	List<String> get gender => ["Male", "Female", "Others"];
	/// "Xác nhận thay đổi"
	String get setting_ConfirmChange => "Xác nhận thay đổi";
	/// "Chọn một hình ảnh"
	String get support_PickPhoto => "Chọn một hình ảnh";
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
	/// "Thử lại"
	@override
	String get button_TryAgain => "Thử lại";
	/// "Áp dụng"
	@override
	String get button_Apply => "Áp dụng";
	/// "Đặt lại"
	@override
	String get button_Reset => "Đặt lại";
	/// ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"]
	@override
	List<String> get onboard_Title => ["Tham gia cùng chúng tôi", "Tập luyện hàng ngày", "Lập kế hoạch ăn kiêng"];
	/// ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"]
	@override
	List<String> get onboard_Description => ["Với các vận động viên và thương hiệu thể thao hàng đầu nhằm xây dựng tương lai của tập luyện thể dục", "Các kế hoạch tập luyện được thiết kế để giúp bạn đạt được các mục tiêu của mình", "Trước khi bạn bắt đầu thiết kế kế hoạch ăn kiêng của riêng mình, hãy tự kiểm điểm bản thân"];
	/// ["English (US)", "Tiếng Việt"]
	@override
	List<String> get language => ["English (US)", "Tiếng Việt"];
	/// ["Dễ", "Trung bình", "Khó"]
	@override
	List<String> get workoutLevel => ["Dễ", "Trung bình", "Khó"];
	/// "Tư vấn"
	@override
	String get main_Chat => "Tư vấn";
	/// "Trang chủ"
	@override
	String get main_Home => "Trang chủ";
	/// "Cài đặt"
	@override
	String get main_Setting => "Cài đặt";
	/// "Thống kê"
	@override
	String get main_Statistics => "Thống kê";
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
	/// "Bạn chưa nhập email"
	@override
	String get login_EmailIsRequired => "Bạn chưa nhập email";
	/// "Mật khẩu phải dài tối thiểu 6 ký tự"
	@override
	String get login_PasswordMustBeAtLeastSixCharacters => "Mật khẩu phải dài tối thiểu 6 ký tự";
	/// "Bạn chưa nhập mật khẩu"
	@override
	String get login_PasswordIsRequired => "Bạn chưa nhập mật khẩu";
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
	/// "Bạn chưa nhập họ và tên"
	@override
	String get signup_FullNameIsRequired => "Bạn chưa nhập họ và tên";
	/// "Bạn chưa xác nhận mật khẩu"
	@override
	String get signup_ConfirmPasswordIsRequired => "Bạn chưa xác nhận mật khẩu";
	/// "Mật khẩu không khớp"
	@override
	String get signup_PasswordNotMatch => "Mật khẩu không khớp";
	/// "Tuổi"
	@override
	String get signup_Age => "Tuổi";
	/// "Bạn chưa nhập tuổi"
	@override
	String get signup_AgeIsRequired => "Bạn chưa nhập tuổi";
	/// "Nhập tuổi của bạn"
	@override
	String get signup_EnterYourAge => "Nhập tuổi của bạn";
	/// "Bạn đã đăng ký thành công"
	@override
	String get signup_RegisterSuccess => "Bạn đã đăng ký thành công";
	/// "Quay lại đăng nhập"
	@override
	String get signup_BackToLogin => "Quay lại đăng nhập";
	/// "Giới tính"
	@override
	String get signup_Gender => "Giới tính";
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
	/// "Hãy di chuyển nhẹ nhàng"
	@override
	String get countdown_WalkAround => "Hãy di chuyển nhẹ nhàng";
	/// "Cài đặt"
	@override
	String get setting_Title => "Cài đặt";
	/// "Cập nhật thông tin"
	@override
	String get setting_EditProfile => "Cập nhật thông tin";
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
	/// "Bạn có chắc chắn muốn thay đổi mật khẩu"
	@override
	String get setting_ChangePasswordConfirm => "Bạn có chắc chắn muốn thay đổi mật khẩu";
	/// "Bạn đã cập nhật mật khẩu thành công"
	@override
	String get setting_ChangePasswordSuccess => "Bạn đã cập nhật mật khẩu thành công";
	/// "Dừng tập luyện"
	@override
	String get exerciseDetail_QuitWorkout => "Dừng tập luyện";
	/// "Bạn có chắc chắn rằng bạn muốn dừng tập luyện?"
	@override
	String get exerciseDetail_QuitWorkoutDes => "Bạn có chắc chắn rằng bạn muốn dừng tập luyện?";
	/// "Hooray!\n Bạn đã hoàn thành tất cả bài tập."
	@override
	String get finish_Hooray => "Hooray!\n Bạn đã hoàn thành tất cả bài tập.";
	/// "Trở về trang chủ"
	@override
	String get finish_GoBackToHome => "Trở về trang chủ";
	/// "Tư Vấn Sức Khoẻ"
	@override
	String get chat_Title => "Tư Vấn Sức Khoẻ";
	/// "Chương trình tập gần đây"
	@override
	String get statistics_RecentWorkout => "Chương trình tập gần đây";
	/// "Bạn đã đốt"
	@override
	String get statistics_YouHaveBurnt => "Bạn đã đốt";
	/// "tuần này"
	@override
	String get statistics_ThisWeek => "tuần này";
	/// "tháng này"
	@override
	String get statistics_ThisMonth => "tháng này";
	/// "calories"
	@override
	String get statistics_Calories => "calories";
	/// "Thật tuyệt vời!"
	@override
	String get statistics_WhatAGreatValue => "Thật tuyệt vời!";
	/// "Lịch sử chỉ số cơ thể"
	@override
	String get statistics_BodyCountHistory => "Lịch sử chỉ số cơ thể";
	/// "Chọn tháng"
	@override
	String get statistics_SelectMonth => "Chọn tháng";
	/// ["Thân trên", "Thân dưới", "Bụng", "Toàn thân"]
	@override
	List<String> get workoutBodyPart => ["Thân trên", "Thân dưới", "Bụng", "Toàn thân"];
	/// "Thể Loại"
	@override
	String get categories_Categories => "Thể Loại";
	/// "Không tìm thấy thể loại"
	@override
	String get categories_CategoryNotFound => "Không tìm thấy thể loại";
	/// "Nhập tên thể loại"
	@override
	String get categories_SearchHint => "Nhập tên thể loại";
	/// "Bài Tập"
	@override
	String get exercises_Exercises => "Bài Tập";
	/// "Không tìm thấy bài tập"
	@override
	String get exercises_ExerciseNotFound => "Không tìm thấy bài tập";
	/// "Chương trình"
	@override
	String get programs_Programs => "Chương trình";
	/// "Không tìm thấy chương trình"
	@override
	String get programs_ProgramNotFound => "Không tìm thấy chương trình";
	/// "Chương trình mới nhất"
	@override
	String get programs_NewestPrograms => "Chương trình mới nhất";
	/// "Chương trình nhiều lượt xem"
	@override
	String get programs_MostViewedPrograms => "Chương trình nhiều lượt xem";
	/// "Nhập tên chương trình"
	@override
	String get programs_SearchHint => "Nhập tên chương trình";
	/// "Bộ lọc"
	@override
	String get programs_Filter => "Bộ lọc";
	/// "Lượt xem"
	@override
	String get programs_View => "Lượt xem";
	/// "Chọn thể loại"
	@override
	String get programs_ChooseCategory => "Chọn thể loại";
	/// "Tin nhắn"
	@override
	String get inboxes_Inboxes => "Tin nhắn";
	/// "Không tìm thấy tin nhắn"
	@override
	String get inboxes_InboxNotFound => "Không tìm thấy tin nhắn";
	/// "Không có dữ liệu"
	@override
	String get common_EmptyData => "Không có dữ liệu";
	/// "Hãy kéo xuống để làm mới dữ liệu"
	@override
	String get common_PleasePullToTryAgain => "Hãy kéo xuống để làm mới dữ liệu";
	/// "Tìm kiếm"
	@override
	String get common_Search => "Tìm kiếm";
	/// "Phút"
	@override
	String get common_Minutes => "Phút";
	/// "Calo"
	@override
	String get common_Calories => "Calo";
	/// "Mô Tả"
	@override
	String get common_Description => "Mô Tả";
	/// "Thời gian"
	@override
	String get common_Duration => "Thời gian";
	/// "Tuần"
	@override
	String get common_Weekly => "Tuần";
	/// "Tháng"
	@override
	String get common_Monthly => "Tháng";
	/// "Năm"
	@override
	String get common_Yearly => "Năm";
	/// "Độ khó"
	@override
	String get common_Level => "Độ khó";
	/// "Vùng cơ thể"
	@override
	String get common_BodyPart => "Vùng cơ thể";
	/// "Thành công"
	@override
	String get common_Success => "Thành công";
	/// "Oops!"
	@override
	String get common_Oops => "Oops!";
	/// "Vui lòng đăng nhập để sử dụng tính năng này"
	@override
	String get common_YouHaveToLogin => "Vui lòng đăng nhập để sử dụng tính năng này";
	/// "Xin chào"
	@override
	String get home_Hello => "Xin chào";
	/// "Chúc bạn một ngày vui vẻ"
	@override
	String get home_HaveANiceDay => "Chúc bạn một ngày vui vẻ";
	/// "Xem tất cả"
	@override
	String get home_ViewAll => "Xem tất cả";
	/// "Người dùng"
	@override
	String get home_User => "Người dùng";
	/// "Tìm kiếm gần đây"
	@override
	String get search_RecentSearches => "Tìm kiếm gần đây";
	/// "Xoá hết"
	@override
	String get search_ClearAll => "Xoá hết";
	/// "Cập nhật thông tin"
	@override
	String get editProfile_Title => "Cập nhật thông tin";
	/// "Bạn có chắc chắn muốn cập nhật thông tin cá nhân?"
	@override
	String get editProfile_EditDes => "Bạn có chắc chắn muốn cập nhật thông tin cá nhân?";
	/// "Thông tin của bạn đã được cập nhật thành công"
	@override
	String get editProfile_UpdateSuccess => "Thông tin của bạn đã được cập nhật thành công";
	/// ["T2", "T3", "T4", "T5", "T6", "T7", "CN"]
	@override
	List<String> get weekDays_ => ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
	/// "Nội dung"
	@override
	String get support_Content => "Nội dung";
	/// "Trạng thái"
	@override
	String get support_Status => "Trạng thái";
	/// ["Đang chờ", "Đang xử lý", "Hoàn thành", "Đã huỷ"]
	@override
	List<String> get support_SupportStatus => ["Đang chờ", "Đang xử lý", "Hoàn thành", "Đã huỷ"];
	/// "Chi tiết yêu cầu hỗ trợ"
	@override
	String get support_SupportDetails => "Chi tiết yêu cầu hỗ trợ";
	/// "Hỗ trợ"
	@override
	String get support_Title => "Hỗ trợ";
	/// "Hãy cho chúng tôi biết vấn đề của bạn"
	@override
	String get support_Description => "Hãy cho chúng tôi biết vấn đề của bạn";
	/// "Nhập câu hỏi,vấn đề,..."
	@override
	String get support_ContentHint => "Nhập câu hỏi,vấn đề,...";
	/// "Bạn chưa nhập nội dung"
	@override
	String get support_ContentRequired => "Bạn chưa nhập nội dung";
	/// "Tải lên hình ảnh"
	@override
	String get support_UploadPhoto => "Tải lên hình ảnh";
	/// "Chụp ảnh"
	@override
	String get support_TakePhoto => "Chụp ảnh";
	/// "Chọn từ thư viện"
	@override
	String get support_ChooseFormGallery => "Chọn từ thư viện";
	/// "Hình ảnh"
	@override
	String get support_Image => "Hình ảnh";
	/// "Tạo yêu cầu hỗ trợ"
	@override
	String get support_CreateTitle => "Tạo yêu cầu hỗ trợ";
	/// "Bạn có chắc chắn muốn tạo yêu cầu hỗ trợ?"
	@override
	String get support_CreateDes => "Bạn có chắc chắn muốn tạo yêu cầu hỗ trợ?";
	/// "Bạn đã tạo yêu cầu thành công"
	@override
	String get support_CreateSuccess => "Bạn đã tạo yêu cầu thành công";
	/// "Huỷ yêu cầu hỗ trợ"
	@override
	String get support_CancelTitle => "Huỷ yêu cầu hỗ trợ";
	/// "Bạn có chắc chắn muốn huỷ yêu cầu hỗ trợ?"
	@override
	String get support_CancelDes => "Bạn có chắc chắn muốn huỷ yêu cầu hỗ trợ?";
	/// "Bạn đã huỷ yêu cầu thành công"
	@override
	String get support_CancelSuccess => "Bạn đã huỷ yêu cầu thành công";
	/// "Cập nhật yêu cầu hỗ trợ"
	@override
	String get support_UpdateTitle => "Cập nhật yêu cầu hỗ trợ";
	/// "Bạn có chắc chắn muốn cập nhật yêu cầu hỗ trợ?"
	@override
	String get support_UpdateDes => "Bạn có chắc chắn muốn cập nhật yêu cầu hỗ trợ?";
	/// "Bạn đã cập nhật yêu cầu thành công"
	@override
	String get support_UpdateSuccess => "Bạn đã cập nhật yêu cầu thành công";
	/// "Biểu đồ"
	@override
	String get chart_Chart => "Biểu đồ";
	/// ["cột", "cột nằm ngang", "đường", "đường bậc thang"]
	@override
	List<String> get chart_ChartType => ["cột", "cột nằm ngang", "đường", "đường bậc thang"];
	/// ["Nam", "Nữ", "Khác"]
	@override
	List<String> get gender => ["Nam", "Nữ", "Khác"];
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
