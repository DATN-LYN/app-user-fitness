import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/graphql/__generated__/schema.schema.gql.dart';
import 'package:fitness_app/global/routers/app_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../global/gen/assets.gen.dart';
import '../../global/gen/i18n.dart';
import '../../global/graphql/auth/__generated__/query_login.data.gql.dart';
import '../../global/graphql/auth/__generated__/query_login.req.gql.dart';
import '../../global/graphql/client.dart';
import '../../global/providers/auth_provider.dart';
import '../../global/themes/app_colors.dart';
import '../../global/utils/dialogs.dart';
import '../../global/widgets/elevated_button_opacity.dart';
import '../../global/widgets/label.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool passwordObscure = true;
  bool isLoading = false;

  void login() async {
    final client = ref.read(appClientProvider);
    FocusManager.instance.primaryFocus?.unfocus();

    if (formKey.currentState!.saveAndValidate()) {
      final loginReq = GLoginReq(
        (b) => b.vars.input.replace(
          GLoginInputDto.fromJson(formKey.currentState!.value)!,
        ),
      );

      setState(() => isLoading = true);
      final response = await client.request(loginReq).first;
      setState(() => isLoading = false);

      if (response.hasErrors) {
        if (mounted) {
          DialogUtils.showError(context: context, response: response);
        }
      } else {
        handleLoginSuccess(response.data);
      }
    }
  }

  void handleLoginSuccess(GLoginData? response) async {
    ref.watch(authProvider.notifier).logIn(response!);

    AutoRouter.of(context).replaceAll([const MainRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: FormBuilder(
        key: formKey,
        child: GestureDetector(
          onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(padding: const EdgeInsets.all(16), children: [
            Assets.images.loginIllu.image(height: 250),
            const SizedBox(height: 18),

            Text(
              i18n.login_LogIn,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            Label(i18n.login_Email),
            FormBuilderTextField(
              name: 'email',
              enabled: !isLoading,
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
              decoration: InputDecoration(
                hintText: i18n.login_EmailHint,
                filled: true,
                fillColor: isLoading ? AppColors.grey6 : AppColors.white,
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autocorrect: false,
            ),
            Label(i18n.login_Password),
            FormBuilderTextField(
              name: 'password',
              enabled: !isLoading,
              obscureText: passwordObscure,
              validator: FormBuilderValidators.compose(
                [
                  FormBuilderValidators.required(
                    errorText: i18n.login_PasswordIsRequired,
                  ),
                  FormBuilderValidators.minLength(
                    6,
                    errorText: i18n.login_PasswordMustBeAtLeastSixCharacters,
                  )
                ],
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                filled: true,
                fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                hintText: i18n.login_PasswordHint,
                suffixIconConstraints: const BoxConstraints(),
                suffixIcon: SizedBox.square(
                  dimension: 40,
                  child: IconButton(
                    onPressed: () => setState(() {
                      passwordObscure = !passwordObscure;
                    }),
                    icon: Icon(
                      passwordObscure ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey2,
                    ),
                  ),
                ),
              ),
              onSubmitted: (_) => login(),
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  //TODO: forgot pass route
                },
                child: Text(i18n.login_ForgotPassword),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButtonOpacity(
              onTap: isLoading ? null : login,
              loading: isLoading,
              label: i18n.login_LogIn,
            ),
            // const SizedBox(height: 24),
            // Row(
            //   children: [
            //     const Expanded(child: Divider(endIndent: 12)),
            //     Text(
            //       i18n.login_OrLogInWith,
            //       textAlign: TextAlign.center,
            //     ),
            //     const Expanded(child: Divider(indent: 12)),
            //   ],
            // ),
            // const SizedBox(height: 24),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     BorderIconSocial(
            //       child: InkWell(
            //         onTap: isLoading ? null : loginWithFacebook,
            //         child: Assets.icons.facebook.svg(),
            //       ),
            //     ),
            //     if (Platform.isIOS)
            //       BorderIconSocial(
            //         child: InkWell(
            //           onTap: isLoading ? null : loginWithApple,
            //           child: Assets.icons.apple.svg(),
            //         ),
            //       ),
            //     BorderIconSocial(
            //       padding: const EdgeInsets.all(0),
            //       child: InkWell(
            //         onTap: isLoading ? null : loginWithGoogle,
            //         child: Assets.icons.google.svg(),
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 42),
            Text.rich(
              TextSpan(
                text: i18n.login_DoNotHaveAnAccount,
                children: [
                  TextSpan(
                    text: i18n.login_RegisterNow,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => AutoRouter.of(context).push(
                            const SignUpRoute(),
                          ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ]),
        ),
      ),
    );
  }
}
