import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fitness_app/global/extensions/support_status_extension.dart';
import 'package:fitness_app/global/gen/assets.gen.dart';
import 'package:fitness_app/global/gen/i18n.dart';
import 'package:fitness_app/global/graphql/fragment/__generated__/support_fragment.data.gql.dart';
import 'package:fitness_app/global/themes/app_colors.dart';
import 'package:fitness_app/global/widgets/label.dart';
import 'package:fitness_app/global/widgets/loading_overlay.dart';
import 'package:fitness_app/global/widgets/selected_image.dart';
import 'package:fitness_app/global/widgets/shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../global/graphql/__generated__/schema.schema.gql.dart';
import '../../../../global/graphql/cache_handler/upsert_support_cache_handler.dart';
import '../../../../global/graphql/client.dart';
import '../../../../global/graphql/mutation/__generated__/mutation_upsert_support.req.gql.dart';
import '../../../../global/providers/me_provider.dart';
import '../../../../global/utils/dialogs.dart';
import '../../../../global/utils/file_helper.dart';
import '../../../../global/widgets/dialogs/confirmation_dialog.dart';
import '../../../../global/widgets/tag.dart';

enum _ImageSource { camera, gallery }

class SupportUpsertPage extends ConsumerStatefulWidget {
  const SupportUpsertPage({
    super.key,
    this.support,
  });

  final GSupport? support;

  @override
  ConsumerState<SupportUpsertPage> createState() => _SupportPageState();
}

class _SupportPageState extends ConsumerState<SupportUpsertPage> {
  XFile? image;
  bool loading = false;
  var formKey = GlobalKey<FormBuilderState>();
  late final isCreateNew = widget.support == null;

  void handleSubmit(bool isCancel) async {
    final i18n = I18n.of(context)!;

    if (formKey.currentState!.saveAndValidate()) {
      final formValue = formKey.currentState!.value;
      var user = ref.watch(meProvider);
      showDialog(
        context: context,
        builder: (dialogContext) {
          final client = ref.read(appClientProvider);

          return ConfirmationDialog(
            titleText: isCreateNew
                ? i18n.support_CreateTitle
                : isCancel
                    ? i18n.support_CancelTitle
                    : i18n.support_UpdateTitle,
            contentText: isCreateNew
                ? i18n.support_CreateDes
                : isCancel
                    ? i18n.support_CancelDes
                    : i18n.support_UpdateDes,
            onTapPositiveButton: () async {
              dialogContext.popRoute();
              setState(() => loading = true);
              String? imageUrl;

              if (image != null) {
                imageUrl = await FileHelper.uploadImage(image!, 'support');
              }

              final formData = GUpsertSupportInputDto(
                (b) => b
                  ..id = widget.support?.id
                  ..content = formValue['content']
                  ..imgUrl = imageUrl ?? widget.support?.imgUrl
                  ..userId = user?.id
                  ..isRead = isCreateNew ? false : true
                  ..status = isCancel
                      ? GSUPPORT_STATUS.Canceled
                      : GSUPPORT_STATUS.Waiting,
              );

              final request = GUpsertSupportReq(
                (b) => b
                  ..vars.input.replace(formData)
                  ..updateCacheHandlerKey = UpsertSupportCacheHandler.key
                  ..updateCacheHandlerContext = {
                    'upsertData': formData,
                  },
              );

              final response = await client.request(request).first;

              setState(() => loading = false);
              if (response.hasErrors) {
                if (mounted) {
                  DialogUtils.showError(context: context, response: response);
                }
              } else {
                if (mounted) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return ConfirmationDialog(
                        showNegativeButton: false,
                        titleText: i18n.common_Success,
                        contentText: isCreateNew
                            ? i18n.support_CreateSuccess
                            : isCancel
                                ? i18n.support_CancelSuccess
                                : i18n.support_UpdateSuccess,
                        image: const Icon(
                          Ionicons.checkmark_circle,
                          color: AppColors.primaryBold,
                        ),
                      );
                    },
                  );
                }
                if (mounted) {
                  context.popRoute();
                }
              }
            },
          );
        },
      );
    }
  }

  void handleReset() {
    setState(() {
      formKey = GlobalKey<FormBuilderState>();
      image = null;
    });
  }

  void pickImage() async {
    final i18n = I18n.of(context)!;

    final imageSource = await showModalActionSheet(
      context: context,
      title: i18n.support_UploadPhoto,
      actions: [
        SheetAction(
          label: i18n.support_TakePhoto,
          key: _ImageSource.camera,
        ),
        SheetAction(
          label: i18n.support_ChooseFormGallery,
          key: _ImageSource.gallery,
        ),
      ],
    );

    switch (imageSource) {
      case _ImageSource.camera:
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
        );
        if (pickedFile != null) {
          setState(() {
            image = pickedFile;
          });
        }
        {}
        break;
      case _ImageSource.gallery:
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          setState(() {
            image = pickedFile;
          });
        }
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final i18n = I18n.of(context)!;
    var user = ref.watch(meProvider)?.user;

    return LoadingOverlay(
      loading: loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.support_Title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCreateNew)
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 16,
                ),
                child: Tag(
                  text: widget.support!.status!.label(i18n),
                  color: widget.support!.status!.color(),
                ),
              ),
            Expanded(
              child: FormBuilder(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    if (isCreateNew) ...[
                      Text(
                        i18n.support_Description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Assets.images.supportCenter.image(height: 200),
                    ],
                    Label(
                      i18n.login_Email,
                      padding: const EdgeInsets.only(bottom: 8, top: 0),
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      initialValue: user?.email,
                      enabled: user?.email == null,
                      decoration: InputDecoration(
                        hintText: i18n.login_EmailHint,
                      ),
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const Label('Content'),
                    FormBuilderTextField(
                      name: 'content',
                      maxLines: 7,
                      initialValue: widget.support?.content,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: FormBuilderValidators.required(
                        errorText: i18n.login_EmailIsRequired,
                      ),
                      maxLength: 255,
                    ),
                    const Label('Image'),
                    GestureDetector(
                      onTap: pickImage,
                      child: DottedBorder(
                        strokeCap: StrokeCap.round,
                        dashPattern: const [8],
                        color: AppColors.information,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.information.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.upload,
                                  size: 40,
                                  color: AppColors.information,
                                ),
                                const SizedBox(height: 4),
                                Text(i18n.support_PickImage),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (widget.support?.imgUrl != null && image == null)
                      ShimmerImage(imageUrl: widget.support?.imgUrl ?? '_'),
                    if (image != null) ...[
                      const SizedBox(height: 16),
                      SelectedImage(image: image!),
                    ]
                  ],
                ),
              ),
            ),
            if (widget.support?.status == GSUPPORT_STATUS.Waiting ||
                widget.support?.status == null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey6,
                        ),
                        onPressed: isCreateNew
                            ? handleReset
                            : () => handleSubmit(true),
                        child: Text(
                          isCreateNew ? i18n.button_Reset : i18n.button_Cancel,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => handleSubmit(false),
                        child: Text(i18n.button_Send),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
