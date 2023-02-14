import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../global/gen/i18n.dart';
import '../../global/themes/app_colors.dart';
import '../../global/widgets/elevated_button_opacity.dart';
import '../../global/widgets/label.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  void forgotPass() {}
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final i18n = I18n.of(context)!;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: FormBuilder(
        key: formKey,
        child: GestureDetector(
          onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                i18n.forgotPassword_Title,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                i18n.forgotPassword_Description,
                overflow: TextOverflow.visible,
              ),
              const SizedBox(height: 8),
              Label(i18n.login_Email),
              FormBuilderTextField(
                name: 'email',
                decoration: InputDecoration(
                  fillColor: isLoading ? AppColors.grey6 : AppColors.white,
                  filled: true,
                  hintText: i18n.login_EmailHint,
                ),
                enabled: !isLoading,
                keyboardType: TextInputType.emailAddress,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(
                      errorText: i18n.login_EmailIsRequired,
                    ),
                    FormBuilderValidators.email(
                      errorText: i18n.login_EmailNotValid,
                    )
                  ],
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autocorrect: false,
                onSubmitted: (_) => forgotPass(),
              ),
              const SizedBox(height: 32),
              ElevatedButtonOpacity(
                onTap: isLoading ? null : forgotPass,
                loading: isLoading,
                label: i18n.forgotPassword_GetCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
