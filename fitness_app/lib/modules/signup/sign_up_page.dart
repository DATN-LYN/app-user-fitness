import 'package:adaptive_selector/adaptive_selector.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/extensions/gender_extension.dart';
import 'package:fitness_app/global/widgets/dialogs/confirmation_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ionicons/ionicons.dart';

import '../../global/gen/i18n.dart';
import '../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../global/graphql/auth/__generated__/mutation_register.req.gql.dart';
import '../../global/graphql/client.dart';
import '../../global/themes/app_colors.dart';
import '../../global/utils/dialogs.dart';
import '../../global/widgets/elevated_button_opacity.dart';
import '../../global/widgets/label.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;
  bool passwordObscure = true;
  bool confirmPasswordObscure = true;
  final focusConfirmPasswordNode = FocusNode();

  GRegisterInputDto get formData {
    final formValue = formKey.currentState!.value;
    return GRegisterInputDto(
      (b) => b
        ..age = double.parse(formValue['age'])
        ..fullName = formValue['fullName']
        ..email = formValue['email']
        ..password = formValue['password']
        ..gender = formValue['gender']
        ..isActive = true
        ..userRole = GROLE.User,
    );
  }

  void signUp() async {
    final client = ref.read(appClientProvider);
    final i18n = I18n.of(context)!;

    FocusManager.instance.primaryFocus?.unfocus();
    if (formKey.currentState!.saveAndValidate()) {
      setState(() => isLoading = true);
      final data = formKey.currentState!.value;
      final registerReq = GRegisterReq(
        (b) => b.vars.input.replace(
          GRegisterInputDto.fromJson(formData.toJson())!,
        ),
      );
      final response = await client.request(registerReq).first;
      setState(() => isLoading = false);
      if (response.hasErrors) {
        if (mounted) {
          DialogUtils.showError(context: context, response: response);
        }
      } else {
        if (response.data?.register.success == true) {
          if (mounted) {
            await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return ConfirmationDialog(
                  showNegativeButton: false,
                  titleText: i18n.common_Success,
                  contentText: i18n.signup_RegisterSuccess,
                  positiveButtonText: i18n.signup_BackToLogin,
                  image: const Icon(
                    Ionicons.checkmark_circle,
                    color: AppColors.primaryBold,
                  ),
                );
              },
            );
            if (mounted) {
              context.popRoute();
            }
          }
        }
      }
    }
  }

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
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        i18n.signup_CreateNewAccount,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      Label(i18n.login_Email),
                      FormBuilderTextField(
                        name: 'email',
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
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
                      const SizedBox(height: 8),
                      Label(i18n.signup_FullName),
                      FormBuilderTextField(
                        name: 'fullName',
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
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
                      Label(i18n.signup_Gender),
                      FormBuilderField<GGENDER>(
                        name: 'gender',
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
                          filled: true,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        builder: (field) {
                          final options = GGENDER.values
                              .map((e) => AdaptiveSelectorOption(
                                  label: e.label(i18n), value: e))
                              .toList();
                          return AdaptiveSelector(
                            options: options,
                            initialOption: options.first,
                            allowClear: false,
                            onChanged: (value) {
                              if (value != null) field.didChange(value.value);
                            },
                          );
                        },
                      ),
                      Label(i18n.signup_Age),
                      FormBuilderTextField(
                        name: 'age',
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
                          filled: true,
                          hintText: i18n.signup_EnterYourAge,
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: i18n.signup_AgeIsRequired,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                      ),
                      Label(i18n.login_Password),
                      FormBuilderTextField(
                        name: 'password',
                        enabled: !isLoading,
                        obscureText: passwordObscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
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
                              errorText:
                                  i18n.login_PasswordMustBeAtLeastSixCharacters,
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
                          fillColor:
                              isLoading ? AppColors.grey6 : AppColors.white,
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
                                confirmPasswordObscure =
                                    !confirmPasswordObscure;
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
                              errorText:
                                  i18n.login_PasswordMustBeAtLeastSixCharacters,
                            ),
                            (value) {
                              if (value !=
                                  formKey.currentState?.fields['password']
                                      ?.value) {
                                return i18n.setting_PasswordNotMatch;
                              } else {
                                return null;
                              }
                            }
                          ],
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: false,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
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
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
