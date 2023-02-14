import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../global/gen/i18n.dart';
import '../../global/themes/app_colors.dart';
import '../../global/widgets/elevated_button_opacity.dart';
import '../../global/widgets/label.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool passwordObscure = true;
  bool confirmPasswordObscure = true;
  final focusConfirmPasswordNode = FocusNode();

  void signUp() {}

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: FormBuilder(
        key: formKey,
        child: GestureDetector(
          onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                i18n.signup_CreateNewAccount,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Label(i18n.signup_FullName),
              FormBuilderTextField(
                name: 'fullName',
                enabled: !isLoading,
                decoration: InputDecoration(
                  fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                  filled: true,
                  hintText: i18n.signup_EnterYourFullName,
                ),
                validator: FormBuilderValidators.required(
                  errorText: i18n.signup_FullNameIsRequired,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
              ),
              Label(i18n.login_Email),
              FormBuilderTextField(
                name: 'email',
                enabled: !isLoading,
                decoration: InputDecoration(
                  fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                  filled: true,
                  hintText: i18n.login_EmailHint,
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: i18n.login_EmailIsRequired,
                    ),
                    FormBuilderValidators.email(
                      errorText: i18n.login_EmailNotValid,
                    ),
                  ],
                ),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              Label(i18n.login_Password),
              FormBuilderTextField(
                name: 'password',
                enabled: !isLoading,
                obscureText: passwordObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                  suffixIconConstraints: const BoxConstraints(),
                  hintText: i18n.login_PasswordHint,
                  suffixIcon: SizedBox.square(
                    dimension: 40,
                    child: IconButton(
                      icon: Icon(
                        passwordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey2,
                      ),
                      onPressed: () => setState(() {
                        passwordObscure = !passwordObscure;
                      }),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: i18n.login_PasswordIsRequired,
                    ),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: i18n.login_PasswordMustBeAtLeastSixCharacters,
                    ),
                  ],
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context)
                    .requestFocus(focusConfirmPasswordNode),
              ),
              Label(i18n.signup_ConfirmPassword),
              FormBuilderTextField(
                name: 'confirmPassword',
                enabled: !isLoading,
                focusNode: focusConfirmPasswordNode,
                obscureText: confirmPasswordObscure,
                decoration: InputDecoration(
                  fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                  filled: true,
                  suffixIconConstraints: const BoxConstraints(),
                  hintText: i18n.signup_ConfirmYourPassword,
                  suffixIcon: SizedBox.square(
                    dimension: 40,
                    child: IconButton(
                      icon: Icon(
                        confirmPasswordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey2,
                      ),
                      onPressed: () => setState(() {
                        confirmPasswordObscure = !confirmPasswordObscure;
                      }),
                    ),
                  ),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: i18n.signup_ConfirmPasswordIsRequired,
                    ),
                    FormBuilderValidators.minLength(
                      6,
                      errorText: i18n.login_PasswordMustBeAtLeastSixCharacters,
                    ),
                    (value) {
                      if (value !=
                          formKey.currentState?.fields['password']?.value) {
                        return i18n.signup_PasswordNotMatch;
                      }
                      return null;
                    }
                  ],
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16),
              Text.rich(
                overflow: TextOverflow.visible,
                TextSpan(
                  text: '${i18n.signup_BySigningUpYouAgreeTo} ',
                  children: [
                    TextSpan(
                      text: i18n.signup_TermsAndConditions,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // if (await canLaunchUrlString(termsAndConditionsUrl)) {
                          //   await launchUrlString(termsAndConditionsUrl);
                          // }
                        },
                    ),
                    TextSpan(
                      text: ' ${i18n.signup_And} ',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      text: i18n.signup_PrivacyPolicy,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          // if (await canLaunchUrlString(privacyPolicyUrl)) {
                          //   await launchUrlString(privacyPolicyUrl);
                          // }
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButtonOpacity(
                onTap: isLoading ? null : signUp,
                loading: isLoading,
                label: i18n.signup_Register,
              ),
              const SizedBox(height: 16),
              Text.rich(
                TextSpan(
                  text: '${i18n.signup_JoinUsBefore} ',
                  children: [
                    TextSpan(
                      text: i18n.signup_LogIn,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = AutoRouter.of(context).pop,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
