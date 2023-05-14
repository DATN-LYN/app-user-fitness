import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_user.req.gql.dart';
import 'package:fitness_app/global/models/hive/user.dart';
import 'package:fitness_app/global/providers/auth_provider.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

import '../../global/graphql/client.dart';
import '../../global/providers/me_provider.dart';
import '../../global/themes/app_colors.dart';
import '../../global/utils/dialogs.dart';
import '../../global/utils/file_helper.dart';
import '../../global/widgets/avatar.dart';
import '../../global/widgets/dialogs/confirmation_dialog.dart';
import '../../global/widgets/label.dart';
import '../../global/widgets/selected_image.dart';
import '../../global/widgets/shimmer_image.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  bool loading = false;
  var formKey = GlobalKey<FormBuilderState>();
  XFile? image;

  void handleSubmit() {
    final i18n = I18n.of(context)!;

    if (formKey.currentState!.saveAndValidate()) {
      final formValue = formKey.currentState!.value;
      final me = ref.read(meProvider);
      final client = ref.watch(appClientProvider);

      showAlertDialog(
        context: context,
        builder: (dialogContext, child) {
          return ConfirmationDialog(
            titleText: i18n.editProfile_Title,
            contentText: i18n.editProfile_EditDes,
            onTapPositiveButton: () async {
              dialogContext.popRoute(true);
              setState(() => loading = true);
              String? imageUrl = '';

              if (image != null) {
                imageUrl = await FileHelper.uploadImage(image!, 'user');
              } else {
                imageUrl = me?.user?.avatar;
              }

              final request = GUpsertUserReq((b) => b
                ..vars.input.email = formValue['email']
                ..vars.input.age = double.parse(formValue['age'])
                ..vars.input.fullName = formValue['fullName']
                ..vars.input.id = me?.user?.id
                ..vars.input.avatar = imageUrl);

              final response = await client.request(request).first;

              setState(() => loading = false);
              if (response.hasErrors) {
                if (mounted) {
                  DialogUtils.showError(context: context, response: response);
                }
              } else {
                ref.read(authProvider.notifier).editProfile(
                      me!.copyWith(
                        user: User(
                          email: formValue['email'],
                          fullName: formValue['fullName'],
                          age: double.parse(formValue['age']),
                          avatar: imageUrl,
                        ),
                      ),
                    );

                if (mounted) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        showNegativeButton: false,
                        titleText: i18n.common_Success,
                        contentText: i18n.editProfile_UpdateSuccess,
                      );
                    },
                  );
                  if (mounted) {
                    context.popRoute(response);
                  }
                }
              }
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(meProvider)?.user;
    final errorAvatar = Avatar(
      name: user?.fullName,
      size: 100,
    );
    final i18n = I18n.of(context)!;
    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.editProfile_Title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: FormBuilder(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final file = await FileHelper.pickImage();
                          setState(() {
                            image = file;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            user?.avatar != null && image == null
                                ? ShimmerImage(
                                    imageUrl: user?.avatar ?? '_',
                                    width: 100,
                                    height: 100,
                                    borderRadius: BorderRadius.circular(100),
                                    errorWidget: errorAvatar,
                                  )
                                : image != null
                                    ? SelectedImage(
                                        image: image!,
                                        borderRadius: 100,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : errorAvatar,
                            Container(
                              width: 30,
                              height: 30,
                              margin:
                                  const EdgeInsets.only(bottom: 4, right: 4),
                              decoration: BoxDecoration(
                                color: AppColors.grey1,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: AppColors.white,
                                size: 17,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Label(i18n.login_Email),
                    FormBuilderTextField(
                      name: 'email',
                      initialValue: user!.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                        errorText: i18n.login_EmailIsRequired,
                      ),
                      decoration:
                          InputDecoration(hintText: i18n.login_EmailHint),
                      enabled: false,
                    ),
                    Label(i18n.signup_FullName),
                    FormBuilderTextField(
                      name: 'fullName',
                      initialValue: user.fullName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                        errorText: i18n.signup_FullNameIsRequired,
                      ),
                      decoration: InputDecoration(
                        hintText: i18n.signup_EnterYourFullName,
                      ),
                    ),
                    Label(i18n.signup_Age),
                    FormBuilderTextField(
                      name: 'age',
                      initialValue: user.age.round().toString(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                        errorText: i18n.signup_AgeIsRequired,
                      ),
                      decoration: InputDecoration(
                        hintText: i18n.signup_EnterYourAge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
              child: ElevatedButton(
                onPressed: handleSubmit,
                child: Text(i18n.button_Apply),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
