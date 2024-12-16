// ignore_for_file: must_be_immutable

import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/paymentCardController.dart';
import 'package:app_fliplaptop/Screens/AddTextScreen.dart';
import 'package:app_fliplaptop/models/paymentCardModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:app_fliplaptop/widgets/disallow_indicator_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';

class SelectPaymentMethod extends StatefulWidget {
  SelectPaymentMethod(
      {super.key, this.isFromSubscriptions = false, this.fromProfile = false});

  bool isFromSubscriptions = false;
  bool fromProfile = false;

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

// enum PaymentOption { MasterCard, PayPal, ApplePay, Visa }

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final paymentCardController = Get.put(PaymentCardController());

  // PaymentOption _payOtp = PaymentOption.MasterCard;

  TextEditingController cardHolder = TextEditingController(text: 'John Smith');
  TextEditingController cardNo =
      TextEditingController(text: '4242424242424242');
  TextEditingController expDate = TextEditingController(text: '12 / 24');
  TextEditingController cvc = TextEditingController(text: '456');

  List cate = [
    'assets/Icon awesome-apple@3x.png',
    'assets/174861@3x.png',
    'assets/Image 19@3x.png',
    'assets/Rectangle 364(2).png'
  ];

  detailItem(String text, subText, icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: VisualDensity(horizontal: -3.7, vertical: -4.0),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                icon != 'assets/Group 957@3x.png'
                    ? SvgPicture.asset(
                        icon,
                        matchTextDirection: false,
                        alignment: Alignment.centerLeft,
                        width: icon == "assets/Group 642.svg" ? 15.r : null,
                      )
                    : Image.asset(
                        icon,
                        width: 31.r,
                      ),
              ],
            ),
            title: Text(text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                )),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 10.r),
              child: TextField(
                maxLength: 16,
                controller: subText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                    counterText: "",
                    border: InputBorder.none,
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.zero),
              ),
            )),
        10.verticalSpace,
        DottedLine(
          dashColor: Colors.black.withOpacity(0.7),
          dashGapLength: 1.4,
          lineThickness: 0.2,
        ),
        20.verticalSpace
      ],
    );
  }

  Future<dynamic> AddNewBankCardPopup(BuildContext context, bool isEdit) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            actions: [
              Container(
                  // height: .5.sh,
                  width: .85.sw,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Get.width,
                        height: 60.h,
                        decoration: BoxDecoration(
                            // color: kprimaryColor,
                            gradient: kbtngradient,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.r),
                                topLeft: Radius.circular(20.r))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.15,
                                  minWidth: Get.width * 0.15),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.45,
                                  minWidth: Get.width * 0.3),
                              child: Text(
                                isEdit ? "Edit Current Card" : 'Add New Card',
                                style: TextStyle(
                                    fontSize: 16.sp, color: Colors.white),
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: Get.width * 0.15,
                                  minWidth: Get.width * 0.15),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () => Get.back(),
                                  icon: IconButton(
                                    onPressed: () => Get.back(),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      32.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.r),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            detailItem('Card Holder', cardHolder,
                                'assets/Icon awesome-user-alt.svg'),
                            detailItem('Card Number', cardNo,
                                'assets/Icon metro-credit-card.svg'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: Get.width * 0.25,
                                  child: detailItem('Exp. Date', expDate,
                                      'assets/Icon awesome-calendar-alt.svg'),
                                ),
                                Container(
                                  width: Get.width * 0.25,
                                  child: detailItem('CVC/CVV', cvc,
                                      'assets/Group 957@3x.png'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      18.verticalSpace,
                      Dialogbutton(
                          265.w,
                          55.h,
                          "Save & Confirm",
                          isEdit
                              ? () {
                                  Get.back();
                                  paymentCardController.editPaymentCard(
                                      CardModel(
                                          name: cardHolder.text,
                                          cardNumber: cardNo.text,
                                          expDate: expDate.text,
                                          cvcCvv: cvc.text));
                                }
                              : () {
                                  /// for removing add popup
                                  Get.back();
                                  paymentCardController.postPaymentCard(
                                      CardModel(
                                          name: cardHolder.text,
                                          cardNumber: cardNo.text,
                                          expDate: expDate.text,
                                          cvcCvv: cvc.text));
                                  // setState(() {
                                  //   Get.back();
                                  // });
                                }),
                      10.h.verticalSpace,
                    ],
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    widget.isFromSubscriptions;
    print(
        "default card ID" + paymentCardController.cardModelID.value.toString());
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        // leadingWidth: 30.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
            child: SvgPicture.asset(
              'assets/Path 11.svg',
              width: 14,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Select Payment Method',
          style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      bottomNavigationBar: paymentCardController.isSelected.value
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
              child: GestureDetector(
                onTap: () {
                  AddNewBankCardPopup(context, true);
                  cvc.text = paymentCardController.editCardModel.value.cvcCvv!;
                  cardHolder.text =
                      paymentCardController.editCardModel.value.name!;
                  cardNo.text =
                      paymentCardController.editCardModel.value.cardNumber!;
                  expDate.text =
                      paymentCardController.editCardModel.value.expDate!;
                  // expDate.text = paymentCardController.editCardModel.value.expDate!;
                  var splittedExp = expDate.text.split("/");
                  print("exp month" + splittedExp[0]);
                  print("exp year" + splittedExp[1]);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    button(
                      280.w,
                      59.h,
                      'Set as Default',
                      () {
                        paymentCardController.cardSetAsDefault(
                            paymentCardController.editCardModel.value.id!,
                            widget.isFromSubscriptions,
                            widget.fromProfile);
                        // Get.toNamed('/OrderConfirmationScreen');
                      },
                    ),
                    Container(
                      width: 45.r,
                      height: 45.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 24.r,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ConfirmationPopup(
                          context,
                          "Delete",
                          "Are you Sure you want to Delete this Card?",
                          "Delete",
                          "Cancel",
                          () {
                            Get.back();
                            paymentCardController.deletePaymentCard(
                              paymentCardController.editCardModel.value.id!,
                            );
                            paymentCardController.isSelected.value = false;
                          },
                          () {
                            Get.back();
                            paymentCardController.isSelected.value = false;
                          },
                        );
                      },
                      child: Container(
                        width: 45.r,
                        height: 45.r,
                        // padding: EdgeInsets.all(5.r),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, gradient: kbtngradient),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 24.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
              child: button(Get.width, 59.h,
                  widget.isFromSubscriptions! ? "Go To Deal" : 'Confirm', () {
                widget.isFromSubscriptions!
                    ? paymentCardController.cardModelID.value == ""
                        ? Utils.showSnack("Select Any Default Card", context)
                        : Get.to(() => AddTextScreen(
                            // isSubscribedUser: true,
                            ))
                    : Get.toNamed('/OrderConfirmationScreen');
              })),
      body: DisAllowIndicatorWidget(
        child: GestureDetector(
          onTap: () {
            setState(() {
              paymentCardController.isSelected.value = false;
            });
            print(paymentCardController.isSelected.value);
          },
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(right: 20.r, left: 20.r, top: 20.r),
            children: [
              Obx(() {
                return paymentCardController.isLoading.value == true
                    ? Center(
                        child: Loader.spinkit,
                      )
                    : paymentCardController.completeDataList.length == 0
                        ? Center(
                            child: Text("No Cards Added"),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount:
                                paymentCardController.completeDataList.length,
                            itemBuilder: (context, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      paymentCardController.isSelected.value =
                                          true;
                                      paymentCardController
                                              .isSelectedCardNumber.value =
                                          paymentCardController
                                              .completeDataList[index]
                                              .cardNumber!;
                                      // paymentCardController
                                      //     .cardModelID.value =
                                      // paymentCardController
                                      //     .completeDataList[index].id!;
                                      ///making edit model value changed
                                      paymentCardController
                                              .editCardModel.value =
                                          paymentCardController
                                              .completeDataList[index];
                                      paymentCardController
                                              .isSelectedCardName.value =
                                          paymentCardController
                                              .completeDataList[index].name!;
                                      print(paymentCardController
                                          .isSelectedCardNumber.value);
                                      print(paymentCardController
                                          .isSelected.value);
                                      // print("card ID" +
                                      //     paymentCardController.cardModelID.value);
                                      print("card ID" +
                                          paymentCardController
                                              .editCardModel.value.id
                                              .toString());
                                    });
                                  },
                                  child: bankCard(
                                    paymentCardController
                                        .completeDataList[index],
                                    paymentCardController.completeDataList,
                                  ),
                                ),
                                20.h.verticalSpace
                              ],
                            ),
                          );
              }),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 22.r,
                      height: 22.r,
                      padding: EdgeInsets.all(5.r),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(
                          5.r,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/Icon ionic-ios-add.svg',
                      ),
                    ),
                    5.horizontalSpace,
                    InkWell(
                      onTap: () => AddNewBankCardPopup(context, false),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                            color: highlightedText,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bankCard(CardModel data, lst) {
    String imgUrl = "";
    switch (data.brand?.toLowerCase()) {
      case 'visa':
        imgUrl = cate[2];
        break;
      case 'mastercard':
        imgUrl = cate[3];
        // print('You chose a banana.');
        break;
      case 'paypal':
        imgUrl = cate[1];
        break;
      // default:
      //   print('Unknown fruit.');
    }
    String cardNumber = "";
    return Container(
      height: 68.h,
      // padding: EdgeInsets.only(left: 22.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: paymentCardController.isSelected.value &&
                paymentCardController.editCardModel.value.id == data.id
            ? Border.all(color: Colors.red, width: 2.5)
            : data.setAsDefault == "yes"
                ? Border.all(width: 1, color: Colors.black)
                : null,
        boxShadow: paymentCardController.isSelected.value &&
                paymentCardController.isSelectedCardNumber.value ==
                    data.cardNumber
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
            : [
                BoxShadow(
                    color: Color.fromARGB(255, 105, 105, 105).withOpacity(0.1),
                    blurRadius: 1.2,
                    spreadRadius: 2)
              ],
      ),
      child: Row(
        children: [
          // Text(data.id.toString()),
          Container(
            width: Get.width * 0.2,

            /// this image is kept static
            child: Image.asset(
              imgUrl,
              scale: 2.9,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.brand.toString().capitalize.toString(),
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff191919)),
                ),
                Text(
                  "**** **** **** ${data.last4.toString().capitalize.toString()}",
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w300,
                      color: Color(0xff191919)),
                ),
              ],
            ),
          ),
          // Obx(() {
          //   return Radio(
          //     value: data.id,
          //     groupValue: paymentCardController.cardModelID.value,
          //     activeColor: Colors.black,
          //     onChanged: (value) {
          //       setState(() {
          //         paymentCardController.cardModelID.value = value!;
          //         print(paymentCardController.cardModelID.value);
          //       });
          //       paymentCardController
          //           .cardSetAsDefault(paymentCardController.cardModelID.value);
          //     },
          //   );
          // }),
        ],
      ),
    );
  }
}
