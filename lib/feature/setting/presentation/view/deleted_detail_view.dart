// import 'dart:developer';

// import 'package:NearMii/config/app_utils.dart';
// import 'package:NearMii/config/assets.dart';
// import 'package:NearMii/config/constants.dart';
// import 'package:NearMii/config/enums.dart';
// import 'package:NearMii/config/helper.dart';
// import 'package:NearMii/core/helpers/all_getter.dart';
// import 'package:NearMii/core/utils/routing/routes.dart';
// import 'package:NearMii/feature/common_widgets/app_text.dart';
// import 'package:NearMii/feature/common_widgets/common_button.dart';
// import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
// import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
// import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
// import 'package:NearMii/feature/common_widgets/custom_toast.dart';
// import 'package:NearMii/feature/setting/presentation/provider/delete_account_provider.dart';
// import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
// import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class DeletedDetailView extends ConsumerStatefulWidget {
//   final String socialId;
//   const DeletedDetailView({super.key, required this.socialId});

//   @override
//   ConsumerState<DeletedDetailView> createState() => _DeletedDetailViewState();
// }

// class _DeletedDetailViewState extends ConsumerState<DeletedDetailView> {
//   @override
//   Widget build(BuildContext context) {
//     final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

//     ref.listen(
//       deleteAccountProvider,
//       (previous, next) async {
//         if (next is SettingApiLoading &&
//             next.settingType == Setting.deleteAccount) {
//           Utils.showLoader();
//         } else if (next is SettingApiSuccess &&
//             next.settingType == Setting.deleteAccount) {
//           Utils.hideLoader();

//           await Getters.getLocalStorage.clearLoginData();
//           toast(msg: AppString.accountDeleted);
//           if (context.mounted) {
//             offAllNamed(context, Routes.login);
//           }
//         } else if (next is SettingApiFailed &&
//             next.settingType == Setting.deleteAccount) {
//           Utils.hideLoader();

//           toast(msg: next.error);
//         }
//       },
//     );

//     return Scaffold(
//       appBar: const CustomAppBar(title: AppString.deleteAccount),
//       backgroundColor: AppColor.greyf9f9f9,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 130),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SvgPicture.asset(Assets.deleteAccount),
//               const SizedBox(height: 20),
//               AppText(
//                   text: AppString.deleteAccount,
//                   fontFamily: Constants.fontFamily,
//                   fontSize: 14.sp,
//                   color: AppColor.black000000,
//                   fontWeight: FontWeight.w500),
//               const SizedBox(height: 10),
//               AppText(
//                 text: AppString.enterYourCurrentPswd,
//                 fontFamily: Constants.fontFamily,
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w500,
//                 color: AppColor.black000000.withOpacity(0.6),
//               ),
//               const SizedBox(height: 20),

//               Column(
//                 children: [
//                   // Consumer(builder: (context, ref, child) {
//                   //   var deleteAccountNotifier =
//                   //       ref.read(deleteAccountProvider.notifier);

//                   //   int selected = ref.watch(selectedDeleteIndex);

//                   //   return CustomLabelTextField(
//                   //     onChanged: (value) {
//                   //       log("delete reason:-> $value");
//                   //     },
//                   //     prefixIcon: Assets.icLock,
//                   //     readOnly: true,
//                   //     suffixIcon: Assets.icArrowDown,

//                   //     controller: deleteAccountNotifier.reasonController,
//                   //     labelText: AppString.reason,
//                   //     onTap: () {
//                   //       showCustomBottomSheet(
//                   //         context: context,
//                   //         content: Consumer(
//                   //           builder: (context, ref, child) {
//                   //             int selected = ref.watch(selectedDeleteIndex);

//                   //             return SingleChildScrollView(
//                   //               child: Column(
//                   //                 mainAxisSize: MainAxisSize.min,
//                   //                 children: [
//                   //                   SvgPicture.asset(Assets.reportNavClose),
//                   //                   15.verticalSpace,
//                   //                   Padding(
//                   //                     padding: EdgeInsets.symmetric(
//                   //                         horizontal: 4,
//                   //                         vertical: context.height * .02),
//                   //                     child: AppText(
//                   //                         text: AppString.reason,
//                   //                         fontSize: 20.sp,
//                   //                         color: AppColor.black1A1C1E,
//                   //                         fontWeight: FontWeight.w700),
//                   //                   ),
//                   //                   CustomReportTile(
//                   //                     title: AppString.noLongerNeed,
//                   //                     check: selected == 0,
//                   //                     ontap: () {
//                   //                       ref
//                   //                           .read(selectedDeleteIndex.notifier)
//                   //                           .state = 0;

//                   //                       deleteAccountNotifier.reasonController
//                   //                           .text = AppString.noLongerNeed;
//                   //                       back(context);
//                   //                     },
//                   //                   ),
//                   //                   CustomReportTile(
//                   //                     title: AppString.notUsingAppAnymore,
//                   //                     check: selected == 1,
//                   //                     ontap: () {
//                   //                       ref
//                   //                           .read(selectedDeleteIndex.notifier)
//                   //                           .state = 1;

//                   //                       deleteAccountNotifier
//                   //                               .reasonController.text =
//                   //                           AppString.notUsingAppAnymore;
//                   //                       back(context);
//                   //                     },
//                   //                   ),
//                   //                   CustomReportTile(
//                   //                     maxlines: 2,
//                   //                     title: AppString
//                   //                         .multipleAccountsSoNeedToRemove,
//                   //                     check: selected == 2,
//                   //                     ontap: () {
//                   //                       ref
//                   //                           .read(selectedDeleteIndex.notifier)
//                   //                           .state = 2;
//                   //                       deleteAccountNotifier
//                   //                               .reasonController.text =
//                   //                           AppString
//                   //                               .multipleAccountsSoNeedToRemove;
//                   //                       back(context);
//                   //                     },
//                   //                   ),
//                   //                   CustomReportTile(
//                   //                     maxlines: 2,
//                   //                     title: AppString.createNewAccount,
//                   //                     check: selected == 3,
//                   //                     ontap: () {
//                   //                       ref
//                   //                           .read(selectedDeleteIndex.notifier)
//                   //                           .state = 3;
//                   //                       deleteAccountNotifier.reasonController
//                   //                           .text = AppString.createNewAccount;
//                   //                       back(context);
//                   //                     },
//                   //                   ),
//                   //                   const SizedBox(height: 12),
//                   //                   5.verticalSpace,
//                   //                   // CommonAppBtn(
//                   //                   //   title: AppString.addReason,
//                   //                   //   onTap: () {
//                   //                   //     back(context);
//                   //                   //   },
//                   //                   // ),
//                   //                   10.verticalSpace
//                   //                 ],
//                   //               ),
//                   //             );
//                   //           },
//                   //         ),
//                   //       );
//                   //     },

//                   //     // suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
//                   //   );
//                   // }),
//                   Visibility(
//                     // visible: widget.socialId.isEmpty,
//                     child: Consumer(builder: (context, ref, child) {
//                       var isVisible = ref.watch(isCurrentPasswordVisible);

//                       var deleteAccountNotifier =
//                           ref.watch(deleteAccountProvider.notifier);
//                       ref.watch(deleteAccountProvider);
//                       return CustomLabelTextField(
//                         onTapOnSuffixIcon: () {
//                           ref.read(isCurrentPasswordVisible.notifier).state =
//                               !ref
//                                   .read(isCurrentPasswordVisible.notifier)
//                                   .state;
//                         },
//                         isObscure: isVisible,
//                         prefixIcon: Assets.icLock,
//                         controller:
//                             deleteAccountNotifier.currentPasswordController,
//                         labelText: AppString.currentPassword,
//                         suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//               // CustomLabelTextField(
//               //   labelBckColor: AppColor.greyf9f9f9,
//               //   prefixIcon: Assets.icLock,
//               //   controller: deleteAccountNotifier.currentPasswordController,
//               //   labelText: AppString.currentPassword,
//               // ),
//               const SizedBox(height: 20),
//               CommonAppBtn(
//                 onTap: () {
//                   log("on delete called new");
//                   // final isDeleteAccount =
//                   //     deleteAccountNotifier.validateDeleteAccountSocial();

//                   // if (isDeleteAccount) {
//                   //   showCustomBottomSheet(
//                   //       context: context,
//                   //       content: DeleteAccountConfirmationView(delete: () {
//                   //         deleteAccountNotifier.deleteAccountApi();
//                   //       }, onCancel: () {
//                   //         back(context);
//                   //       }));
//                   // } else {
//                   //   final isDeleteAccount =
//                   //       deleteAccountNotifier.validateDeleteAccount();

//                   //   if (isDeleteAccount) {
//                   //     showCustomBottomSheet(
//                   //         context: context,
//                   //         content: DeleteAccountConfirmationView(delete: () {
//                   //           deleteAccountNotifier.deleteAccountApi();
//                   //         }, onCancel: () {
//                   //           back(context);
//                   //         }));
//                   //   }
//                   // }
//                   if (widget.socialId.isNotEmpty) {
//                     final isDeleteAccount =
//                         deleteAccountNotifier.validateDeleteAccountSocial();

//                     if (isDeleteAccount) {
//                       showCustomBottomSheet(
//                           context: context,
//                           content: DeleteAccountConfirmationView(delete: () {
//                             deleteAccountNotifier.deleteAccountApi(
//                                 // socialId: widget.socialId
//                                 );
//                           }, onCancel: () {
//                             back(context);
//                           }));
//                     } else {
//                       final isDeleteAccount =
//                           deleteAccountNotifier.validateDeleteAccount();

//                       if (isDeleteAccount) {
//                         showCustomBottomSheet(
//                             context: context,
//                             content: DeleteAccountConfirmationView(delete: () {
//                               deleteAccountNotifier.deleteAccountApi();
//                             }, onCancel: () {
//                               back(context);
//                             }));
//                       }
//                     }
//                   }
//                 },
//                 title: AppString.done,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
