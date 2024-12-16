import 'dart:convert';
import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/firebaseServices.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Controller/wishListController.dart';
import 'package:app_fliplaptop/Screens/ImageViewerScreen.dart';
import 'package:app_fliplaptop/Screens/ListOfProduct.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/Screens/OrderConfirmation.dart';
import 'package:app_fliplaptop/Screens/StoreProfileScreen.dart';
import 'package:app_fliplaptop/Screens/editProductScreen.dart';
import 'package:app_fliplaptop/Screens/productReviews.dart';
import 'package:app_fliplaptop/components/dealCard.dart';
import 'package:app_fliplaptop/components/discount_card.dart';
import 'package:app_fliplaptop/components/global.dart';
import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:app_fliplaptop/models/purchaseModel.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

// List laptopImages = [
//   'assets/Rectangle 1011.png',
//   'assets/Rectangle 1012.png',
//   'assets/Rectangle 1013.png',
//   'assets/Rectangle 1014.png',
//   'assets/Rectangle 1013.png',
//   'assets/Rectangle 1014.png',
// ];

class ReviewProductScreen extends StatefulWidget {
  dynamic productData;
  dynamic storeData;
  bool? ownProduct;
  String? storeProfile;
  String? storeName;
  int? index;
  int? storeID;
  User? postedUserData;

  ReviewProductScreen({super.key,
    this.productData,
    this.ownProduct,
    this.storeProfile,
    this.storeName,
    this.storeData,
    this.index,
    this.storeID,
    this.postedUserData});

  @override
  State<ReviewProductScreen> createState() =>
      _ReviewProductScreenState(index: index!, storeID: storeID ?? null);
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  int? index;
  int? storeID;
  String discountDate = "";
  TextEditingController _searchTxt3 = TextEditingController();
  OrderController orderController = Get.put(OrderController());
  WishListController wishListController = Get.put(WishListController());
  final ProductController productController = Get.put(ProductController());
  final ChatController chatController = Get.put(ChatController());
  bool discountAvailable = false;

  _ReviewProductScreenState({this.index, this.storeID});

  Future<dynamic> addSuccessfulPopup(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: Material(
                type: MaterialType.transparency,
                child: Container(
                  height: 410.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 24.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              color: Colors.white),
                          // width: Get.width * 0.85,
                          width: 335.w,
                          height: 270.h,
                          // padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              101.verticalSpace,
                              Text(
                                'Thankyou!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              10.verticalSpace,
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 19.r),
                                // constraints: BoxConstraints(
                                //   maxWidth:  266.w
                                // ),
                                child: Text(
                                  'Your product has been added Successfully',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.sp),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              15.verticalSpace,
                              Dialogbutton2(
                                  Get.width, 50.h, "Go Back", () =>
                                  Get.close(2))
                            ],
                          )),
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 152.r,
                          height: 152.r,
                          padding: EdgeInsets.all(27.r),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 5)
                              ],
                              shape: BoxShape.circle,
                              gradient: kbtngradient,
                              border: Border.all(
                                  width: 3, color: highlightedText)),
                          child: Image.asset('assets/laptop-screen@3x.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.count.value=1;
  }

  @override
  Widget build(BuildContext context) {
    // log("product image Url"+widget.productData["image"].toString());
    Future.delayed(Duration.zero, () {
      if (wishListController.wishListCompleteData.value.data!.isNotEmpty) {
        var tr = wishListController.wishListCompleteData.value.data!.indexWhere(
                (element) =>
            element.id == orderController.datumInstance.value.id);
        print("=====>value $tr");
        if (tr != -1) {
          wishListController.isWishList.value = true;
        } else {
          wishListController.isWishList.value = false;
        }
      }
    });

    log("USer ID" + ApiServices.storeId);
    log("widget ID" + widget.storeData.id.toString());
    // log("dis start date " + widget.productData["discount"].startDatetime.toString());
    // log("dis end date " + widget.productData["discount"].endDatetime.toString());
    log("APi services . userID" + ApiServices.storeId);
    // log("datum name is" +
    //     orderController.datumInstance.value.name! +
    //     orderController.datumInstance.value.id!);
    widget.productData["discount"].toString() != "null"
        ? discountDate = widget.productData["discount"].endDatetime.toString()
        : "";
    bool compareDates(DateTime date1, DateTime date2) {
      log(date1.toString());
      log(date2.toString());
      if (date1.compareTo(date2) > 0) {
        print("DT1 is after DT2");
        setState(() {
          discountAvailable = false;
        });
      } else {
        print("DT1 is before DT2");
        setState(() {
          discountAvailable = true;
        });
      }
      return date1.isAfter(date2);
    }

    log(discountAvailable.toString());

    DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    widget.productData["discount"].toString() == "null"
        ? null
        : compareDates(dateFormat.parse(DateTime.now().toString()),
        dateFormat.parse(discountDate.substring(0, 19)));

    // log("discount available"+isDiscountAvailable.toString());

    // print( productController
    //     .productListingDataList.value[0].data![0].name);
    return Scaffold(
      backgroundColor: kPageBgColor,
      appBar: AppBar(
        leadingWidth: 50.r,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20.r),
              decoration:
              BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 20,
              )),
        ),
        title: Container(
          width: Get.width * 0.7,
          height: 51.h,
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 25.r),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: Offset(0, 2),
                color: Color.fromARGB(194, 241, 203, 216).withOpacity(
                  0.15,
                ),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              35.r,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              10.horizontalSpace,
              Icon(
                opticalSize: 0.9,
                Icons.search,
                color: Color(0xff1D1E1E).withOpacity(0.5),
                size: 21,
              ),
              14.horizontalSpace,
              Expanded(
                child: TextField(
                  controller: _searchTxt3,
                  style: GoogleFonts.inter(
                      color: Color(0xff1D1E1E).withOpacity(0.5),
                      fontSize: 15.sp),
                  cursorColor: Color(0xff1D1E1E),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 0, bottom: 3.5.r),
                    border: InputBorder.none,
                    hintText: 'Dell Laptop, MacBook Air',
                    hintStyle: GoogleFonts.inter(
                      color: Color(0xff1D1E1E).withOpacity(0.5),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/MyCartScreen');
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                height: 51.h,
                width: 69.w,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 25.r),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.r)),
                child: SvgPicture.asset(
                  'assets/Icon feather-shopping-cart.svg',
                  width: 23.r,
                ),
              ),
            ),
          ),
          10.horizontalSpace
        ],
      ),
      bottomNavigationBar: userController.user.value.store?.id.toString() ==
          widget.storeData.id.toString() ||
          ApiServices.storeId == widget.storeData.id.toString()
          ? Padding(
        padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 30.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            button2(Get.width * 0.45, 59.h, 'Edit', () {
              // productController.editDatumInstance.value = jsonDecode(widget.productData);
              // print( productController.editProductInstance.value);
              // final iteration = productController
              //     .productListingDataList.first.data![index!];
              // var abc = iteration;
              // print("Iteration value"+abc.toString());
              setState(() {
                // var datum = Datum(
                //     id: productController.editProductInstance.value.id,
                //     name:  productController.editProductInstance.value.name,
                //     price: productController.editProductInstance.value.price,
                //     qty: productController.editProductInstance.value.qty,
                //     conditionType: productController.editProductInstance.value.conditionType,
                //     deliveryType: productController.editProductInstance.value.deliveryType,
                //     model: productController.editProductInstance.value.model,
                //     descriptions: productController.editProductInstance.value.descriptions,
                //     createdAt: productController.editProductInstance.value.createdAt,
                //     brands: productController.editProductInstance.value.brands,
                //   // color:
                // );
                // print("============> Datum "+ datum.name.toString());
                Get.to(() =>
                    EditProductsScreen(
                      productData:
                      productController.editDatumInstance.value,
                    ));
              });
            }),
            button(Get.width * 0.45, 59.h, 'Delete', () {
              final ProductController productController =
              Get.put(ProductController());

              final iteration = productController
                  .productListingDataList.first.data![index!];
              ConfirmationPopup(
                context,
                "Delete",
                "Are you Sure you want to Delete this Item?",
                "Delete",
                "Cancel",
                    () {
                  Get.back();
                  print("Called delete on product ID" +
                      iteration.id.toString());

                  // _setState(() {
                  ApiServices().deleteProduct(context,
                      int.parse(iteration.id!), storeID.toString());
                  // });
                },
                    () {
                  Get.back();
                },
              );
            })
          ],
        ),
      )
          : Padding(
        padding: EdgeInsets.only(left: 20.r, right: 20.r, bottom: 30.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            button2(Get.width * 0.45, 59.h, 'Add To Cart',
                    () => openSheet(context)),
            button(Get.width * 0.45, 59.h, 'Buy Now',
                    () => buyNowModalSheet(context))
          ],
        ),
      ),
      body: GetBuilder(
          init: orderController,
          builder: (cont) {
            return ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
              children: [
                Stack(
                  children: [
                    Container(
                      height: 249.h,
                      // width: 500.sw,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        // color: Colors.black,
                        // image: DecorationImage(
                        //     image: AssetImage(
                        //         'assets/M2-MacBook-Air-2022-Feature0012@3x.png'),
                        //     fit: BoxFit.fill)
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(10.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.productData["image"]
                                    .toString() ==
                                    ""
                                    ?
                                // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                "NoImage"
                                    :
                                // ImageUrls.kProduct +
                                //         // widget
                                widget.productData["image"].toString(),
                                placeholder: (context, url) =>
                                    Icon(Icons.image),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 23,
                      right: 20,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.ownProduct! ||
                              userController.user.value.store?.id ==
                                  widget.storeData.id.toString() ||
                              ApiServices.storeId ==
                                  widget.storeData.id.toString()
                              ? Container()
                              : Obx(() {
                            return InkWell(
                              onTap: () {
                                if (!wishListController
                                    .isWishList.value) {
                                  wishListController.isWishList.value =
                                  !wishListController
                                      .isWishList.value;
                                  print(wishListController
                                      .isWishList.value);
                                  // var a = wishListController
                                  //     .wishListCompleteData.value.data!
                                  //     .where((element) =>
                                  //         element.id ==
                                  //         widget.productData.id);
                                  // print("A value" + a.toString());

                                  /// post wishList
                                  wishListController.postWishListItem(
                                      orderController
                                          .datumInstance.value.id
                                          .toString(),
                                      context);
                                } else {
                                  null;
                                }
                              },
                              child: Container(
                                width: 28.r,
                                height: 28.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: wishListController
                                        .isWishList.value
                                        ? Colors.red
                                        : Colors.white,
                                    shape: BoxShape.circle),
                                child: SvgPicture.asset(
                                  'assets/Icon feather-heart.svg',
                                  width: 13.r,
                                  color:
                                  wishListController.isWishList.value
                                      ? Colors.white
                                      : Colors.red,
                                  // color: Colors.white,
                                ),
                              ),
                            );
                          }),
                          15.horizontalSpace,
                          InkWell(
                            onTap: () {
                              Share.shareWithResult("Checkout this product!");
                            },
                            child: Container(
                              width: 28.r,
                              height: 28.r,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: SvgPicture.asset(
                                'assets/Icon feather-share-2.svg',
                                width: 13.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                31.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 0.4.sw,
                      child: Text(

                        widget.productData["name"].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // 'MacBook Air',
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => ProductReviews());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/Group 90.svg',
                            width: 96.27.r,
                          ),
                          10.horizontalSpace,
                          Text(
                            'Reviews(${widget.productData["rating"]
                                .toString()})',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.productData["price"].toString()}',
                          style: TextStyle(
                            decoration:
                            widget.productData["dealPrice"] != "\$ " ||
                                (widget.productData["discount"]
                                    .toString() !=
                                    "null")
                                ? TextDecoration.lineThrough
                                : null,
                            fontWeight: FontWeight.bold,
                            color: widget.productData["dealPrice"] != "\$ " ||
                                (widget.productData["discount"]
                                    .toString() !=
                                    "null")
                                ? Colors.grey
                                : highlightedText,
                            fontSize:
                            widget.productData["dealPrice"] != "\$ " ||
                                (widget.productData["discount"]
                                    .toString() !=
                                    "null")
                                ? 16.sp
                                : 20.sp,
                          ),
                        ),
                        15.horizontalSpace,
                        widget.productData["discount"].toString() == "null" ||
                            widget.productData["dealPrice"] != "\$ "
                            ? SizedBox()
                            : Text(
                          '\$ ${widget.productData["discount"].price
                              .toString()}',
                          style: TextStyle(
                            decoration: widget.productData["dealPrice"] !=
                                "\$ "
                            // || widget.productData["discount"].toString() != "null"
                                ? TextDecoration.lineThrough
                                : null,
                            fontWeight: FontWeight.bold,
                            color: widget.productData["dealPrice"] !=
                                "\$ "
                            // ||widget.productData["discount"].toString() != "null"
                                ? Colors.grey
                                : highlightedText,
                            fontSize: widget.productData["dealPrice"] !=
                                "\$ "
                            // ||widget.productData["discount"].toString() != "null"
                                ? 16.sp
                                : 20.sp,
                          ),
                        ),
                        5.horizontalSpace,
                        Visibility(
                          visible: widget.productData["dealPrice"] != "\$ ",
                          child: Text(
                            '${widget.productData["dealPrice"].toString()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: highlightedText,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),

                        // widget.productData["discount"].toString() != "null"
                        //     ? Text(
                        //         "\$ ${widget.productData["discount"
                        //   ].price.toString()}",
                        //         style: TextStyle(
                        //           fontWeight: FontWeight.bold,
                        //           color: highlightedText,
                        //           fontSize: 20.sp,
                        //         ),
                        //       )
                        //     : SizedBox(),
                        //  <<<<<<<<<<<<<<<<<<<<discount>>>>>>>>>>>>
                        // dynamic the discount
                        // Text('\$200',
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: Color(0xff3B3B3B).withOpacity(0.5),
                        //         fontSize: 12.sp,
                        //         decoration: TextDecoration.lineThrough))
                      ],
                    ),
                    widget.ownProduct! ||
                        userController.user.value.store?.id ==
                            widget.storeData.id.toString() ||
                        ApiServices.storeId ==
                            widget.storeData.id.toString()
                        ? Container()
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            log(productController
                                .editDatumInstance.value.name
                                .toString());
                            orderController.minus();
                          },
                          child: Container(
                            width: 28.r,
                            height: 28.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: kbtngradient,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                                'assets/Icon awesome-minus.svg'),
                          ),
                        ),
                        10.horizontalSpace,
                        Text(
                          orderController.count.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        10.horizontalSpace,
                        InkWell(
                          onTap: () {
                            log(productController
                                .editDatumInstance.value.qty
                                .toString());
                            log(orderController.count.value.toString());
                            if (productController
                                .editDatumInstance.value.qty! >
                                orderController.count.value) {
                              orderController.add();
                            } else {
                              Utils.showSnack(
                                  "Only ${productController.editDatumInstance
                                      .value.qty} items available in stock",
                                  context);
                            }
                          },
                          child: Container(
                            width: 29.r,
                            height: 29.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: kbtngradient,
                                shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              'assets/Icon awesome-plus.svg',
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                20.verticalSpace,
                // widget.productData.productImage.length >= 2
                //     ?
                Obx(() {
                  return Container(
                    height: 83.r,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      // userController.user.store==null?null:
                      userController.user.value.store?.id.toString() ==
                          widget.storeData.id.toString() ||
                          ApiServices.storeId ==
                              widget.storeData.id.toString()
                          ? productController.myProductImageList.length
                          : productController
                          .editDatumInstance.value.productImage?.length,
                      itemBuilder: (context, index) {
                        // final iteration =
                        //     widget.productData.productImage[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              ImageGallery(
                                data: userController.user.value.store?.id
                                    .toString() ==
                                    widget.storeData.id.toString() ||
                                    ApiServices.storeId ==
                                        widget.storeData.id.toString()
                                    ? productController.myProductImageList
                                    : productController
                                    .editDatumInstance.value.productImage!,
                                ind: index,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 20.r),
                            width: 96.r,
                            // height: 83.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              // image: DecorationImage(
                              //     image: AssetImage(widget.productData.productImage[index]),
                              //     fit: BoxFit.fill)
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: ImageUrls.kProduct +
                                  ((userController.user.value.store?.id ??
                                      "") ==
                                      widget.storeID
                                      ? productController
                                      .myProductImageList[index].name ??
                                      ""
                                      : productController
                                      .editDatumInstance
                                      .value
                                      .productImage?[index]
                                      .name ??
                                      ""),
                              placeholder: (context, url) => Icon(Icons.image),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                // : Container(),
                20.verticalSpace,
                Text(
                  'Product Description',
                  style:
                  TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.productData["description"].toString(),
                        // 'Lorem ipsum dolor sit amet consectetur adipiscing elit suscipit commodo enim tellus et nascetur at leo accumsan, odio habitanLorem ipsum dolor sit amet consectetur adipiscing elit suscipit commodo enim tellus et nascetur at leo accumsan, odio habita',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff667080),
                        ),
                      ),
                    ),
                    20.horizontalSpace,
                    // Text(userController.user.store!.first.id.toString()),
                    // Text(widget.storeID.toString()),
                    userController.user.value.store?.id.toString() ==
                        widget.storeID.toString() ||
                        ApiServices.storeId == widget.storeID.toString()
                        ? Container()
                        : InkWell(
                      onTap: () async {
                        // final getUserController = Get.put(UserController());
                        // Get.to(
                        //     () => ChatScreen(
                        //         senderData: userController.user,
                        //         conversationID: userController.user.id ??
                        //             "" + storeID.toString(),),
                        //     arguments: 'John Smith');
                        FirebaseServices().startConversation(
                            userController.user.value.id ?? "",
                            widget.postedUserData!);
                        FirebaseServices().fetchConversationsStream(
                            userController.user.value.id ?? "",
                            widget.postedUserData!.id ?? "");
                      },
                      child: Container(
                        width: 47.r,
                        height: 47.r,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: kbtngradient,
                        ),
                        child: SvgPicture.asset(
                          'assets/Group 11.svg',
                          width: 20.r,
                        ),
                      ),
                    )
                  ],
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        log(widget.storeData.image.toString());
                        widget.ownProduct! ||
                            userController.user.value.store?.id ==
                                widget.storeID ||
                            ApiServices.storeId == widget.storeID.toString()
                            ? Get.to(
                              () =>
                              MyStoreProfileScreen(
                                storeId: widget.storeID.toString(),
                              ),
                        )
                            : Get.to(
                              () =>
                              StoreProfileScreen(
                                isStore: true,
                                storeData: widget.storeData ?? Store(),
                                storeProfile: widget.storeProfile ?? "",
                                postedUserData:
                                widget.postedUserData ?? User(),
                              ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 48.r,
                            height: 48.r,
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(48.r),
                                color: Colors.white,
                                shape: BoxShape.circle
                              // borderRadius: BorderRadius.circular(radius)
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius: BorderRadius.circular(48.r),
                              child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: widget.storeData.image
                                // .productData.productImage
                                    .toString() ==
                                    ""
                                    ?
                                // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                "NoImage"
                                    : ImageUrls.kStoreProfile +
                                    widget.storeData.image.toString(),
                                placeholder: (context, url) =>
                                    Icon(Icons.image),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                          // Image.asset(
                          //   'assets/NoPath - Copy (15)-1@3x.png',
                          //   width: 48.r,
                          // ),
                          15.horizontalSpace,
                          Text(
                            widget.storeData.toString() == ""
                                ? widget.storeName.toString()
                                : widget.storeData.name ?? "",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xffFFCD3C),
                          size: 20.r,
                        ),
                        5.horizontalSpace,
                        Text(
                          widget.productData["rating"].toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
                15.verticalSpace,
                // Text(widget.productData["dealPrice"].toString()),
                widget.productData["discount"].toString() == "null" ||
                    widget.productData["dealPrice"] != "\$ "
                    ? Container()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DiscountCard(
                      discountAmountType:
                      // widget.productData["dealPrice"] != "\$ "
                      //    ? false
                      //    :
                      widget.productData["discount"].type
                          .toString() ==
                          "direct_amount"
                          ? true
                          : false,
                      amount:
                      // widget.productData["dealPrice"] != "\$ "
                      //     ? widget.productData["dealPrice"]
                      //     :
                      widget.productData["discount"].price.toString(),
                      endDate:
                      // widget.productData["dealPrice"] != "\$ "
                      //     ? widget.productData["dealItemEndDatetime"].toString()
                      //     :
                      widget.productData["discount"].endDatetime
                          .toString()
                          .substring(0, 10),
                      percentage:
                      // widget.productData["dealPrice"] != "\$ "
                      //     ? widget.productData["dealPrice"]
                      //     :
                      widget.productData["discount"].percentageTarget
                          .toString(),
                    ),
                    // CustomPaint(
                    //     painter: RPSCustomPainter2(),
                    //     child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 23.r, vertical: 12.r),
                    //         width: Get.width * 0.45,
                    //         height: 90.h,
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '20% Off',
                    //                   style: TextStyle(
                    //                       color: Color(0xff3B3B3B),
                    //                       fontSize: 16.sp),
                    //                 ),
                    //                 Container(
                    //                   constraints:
                    //                       BoxConstraints(maxWidth: 79.w),
                    //                   child: Text(
                    //                     'Use by Dec 30, 2022',
                    //                     style: TextStyle(
                    //                         color: Color(0xff3B3B3B),
                    //                         fontSize: 10.sp),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Image.asset(
                    //               'assets/gift@3x.png',
                    //               width: 50.r,
                    //             )
                    //           ],
                    //         ))),
                    // CustomPaint(
                    //     painter: RPSCustomPainter(),
                    //     child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 23.r, vertical: 12.r),
                    //         width: Get.width * 0.45,
                    //         height: 90.h,
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '20% Off',
                    //                   style: TextStyle(
                    //                       color: Colors.white,
                    //                       fontSize: 16.sp),
                    //                 ),
                    //                 Container(
                    //                   constraints:
                    //                       BoxConstraints(maxWidth: 79.w),
                    //                   child: Text(
                    //                     'Use by Dec 30, 2022',
                    //                     style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 10.sp),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Image.asset(
                    //               'assets/gift@3x.png',
                    //               width: 50.r,
                    //             )
                    //           ],
                    //         ))),
                  ],
                ),
                widget.productData["dealPrice"] == "\$ "
                    ? Container()
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DealCard(
                      discountAmountType: true,
                      amount: widget.productData["dealItemPercentage"],
                      endDate: widget.productData["dealItemEndDatetime"]
                          .toString()
                          .substring(0, 10),
                      percentage: widget.productData["dealPrice"],
                    ),
                    // CustomPaint(
                    //     painter: RPSCustomPainter2(),
                    //     child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 23.r, vertical: 12.r),
                    //         width: Get.width * 0.45,
                    //         height: 90.h,
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '20% Off',
                    //                   style: TextStyle(
                    //                       color: Color(0xff3B3B3B),
                    //                       fontSize: 16.sp),
                    //                 ),
                    //                 Container(
                    //                   constraints:
                    //                       BoxConstraints(maxWidth: 79.w),
                    //                   child: Text(
                    //                     'Use by Dec 30, 2022',
                    //                     style: TextStyle(
                    //                         color: Color(0xff3B3B3B),
                    //                         fontSize: 10.sp),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Image.asset(
                    //               'assets/gift@3x.png',
                    //               width: 50.r,
                    //             )
                    //           ],
                    //         ))),
                    // CustomPaint(
                    //     painter: RPSCustomPainter(),
                    //     child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: 23.r, vertical: 12.r),
                    //         width: Get.width * 0.45,
                    //         height: 90.h,
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment:
                    //                   CrossAxisAlignment.start,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Text(
                    //                   '20% Off',
                    //                   style: TextStyle(
                    //                       color: Colors.white,
                    //                       fontSize: 16.sp),
                    //                 ),
                    //                 Container(
                    //                   constraints:
                    //                       BoxConstraints(maxWidth: 79.w),
                    //                   child: Text(
                    //                     'Use by Dec 30, 2022',
                    //                     style: TextStyle(
                    //                         color: Colors.white,
                    //                         fontSize: 10.sp),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Image.asset(
                    //               'assets/gift@3x.png',
                    //               width: 50.r,
                    //             )
                    //           ],
                    //         ))),
                  ],
                ),
              ],
            );
          }),
    );
  }

  void openSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r))),
        isDismissible: true,
        enableDrag: true,
        useRootNavigator: true,
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return GetBuilder(
              init: orderController,
              builder: (cont) {
                return Container(
                  height: .35.sh,
                  decoration: BoxDecoration(
                      gradient: kbtngradient,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35.r))),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    // alignment: Alignment.topCenter,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 50.w,),
                          SvgPicture.asset('assets/Rectangle 773.svg'),
                          InkWell(
                        splashColor: Colors.white,
                        onTap: (){
                          Get.back();
                        },
                                            
                        child: SvgPicture.asset(
                          'assets/Icon ionic-ios-close.svg',
                          color: Colors.white,
                          height: 20.r,
                        ),
                      ),
                        ],
                      ).paddingSymmetric(horizontal: 30.w,vertical: 20.h),
                      
                      // 20.verticalSpace,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 30.verticalSpace,
                          ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.r, vertical: 5.r),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 108.r,
                                    height: 97.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      // image: DecorationImage(
                                      //     image: AssetImage(
                                      //         'assets/M2-MacBook-Air-2022-Feature0012.png'),
                                      //     fit: BoxFit.fill),
                                    ),
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.fill,
                                        imageUrl: widget.productData["image"]
                                            .toString() ==
                                            ""
                                            ?
                                        // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                        "NoImage"
                                            :
                                        // ImageUrls.kProduct +
                                        //         // widget
                                        widget.productData["image"]
                                            .toString(),
                                        placeholder: (context, url) =>
                                            Icon(Icons.image),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.productData["name"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Color : MK46 Black',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w100),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.sp)),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          orderController.minus();
                                        },
                                        child: Container(
                                          width: 28.r,
                                          height: 28.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/Icon awesome-minus.svg',
                                            color: highlightedText,
                                          ),
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Obx(() {
                                        return Text(
                                          orderController.count.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.bold),
                                        );
                                      }),
                                      10.horizontalSpace,
                                      InkWell(
                                        onTap: () => orderController.add(),
                                        child: Container(
                                          width: 29.r,
                                          height: 29.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/Icon awesome-plus.svg',
                                            color: highlightedText,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              20.verticalSpace,
                              // Container(
                              //   height: 79.h,
                              //   child: ListView.builder(
                              //     shrinkWrap: true,
                              //     physics: const BouncingScrollPhysics(),
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: widget.productData,
                              //     itemBuilder: (context, index) => Container(
                              //       margin: EdgeInsets.only(right: 10.r),
                              //       width: 71.r,
                              //       // height: 83.h,
                              //       decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(15.r),
                              //           image: DecorationImage(
                              //               image:
                              //                   AssetImage(laptopImages[index]),
                              //               fit: BoxFit.fill)),
                              //     ),
                              //   ),
                              // ),
                              30.verticalSpace,
                              button2(Get.width, 59.h, 'Add to cart', () async {
                                /// mechanism for add to cart functionality
                                if (orderController.cartList.isNotEmpty) {
                                  ///for loop
                                  int isPresent = orderController.cartList
                                      .indexWhere((element) =>
                                  element.datum.id ==
                                      orderController
                                          .datumInstance.value.id);

                                  // if(i.datum.)
                                  print("======> isPresent ${isPresent}");
                                  print(
                                      "======> datum ID${orderController
                                          .datumInstance.value.id}");
                                  print("caRT list" +
                                      orderController.cartList.toString());
                                  if (isPresent != -1) {
                                    print("In if");
                                    Get.back();
                                    Utils.showSnack(
                                        "Item already in Cart", context);
                                  } else {
                                    print("In else");
                                    if (orderController
                                        .datumInstance.value.qty! <
                                        orderController.count.value) {
                                      Utils.showFloatingErrorSnack(
                                          "The product is Out of Stock!");
                                    } else {
                                      orderController.cartList.add(CartItem(
                                          datum: orderController
                                              .datumInstance.value,
                                          quantity:
                                          orderController.count.value));
                                      orderController.cartList.refresh();

                                      /// saving the cart list to local storage
                                      LocalStorage.saveJson(
                                          key: LocalStorageKeys.cartList,
                                          value: jsonEncode(
                                              orderController.cartList.value));
                                      // addSuccessfulPopup(context);
                                      Get.back();
                                      addSuccessfulPopup(context);
                                      orderController.count.value = 1;
                                    }

                                    // orderController.cartList.value
                                    //     .forEach((element) {
                                    //
                                    // });
                                    // for (var i in orderController.cartList.value) {
                                    //
                                  }
                                } else {
                                  if (orderController.datumInstance.value.qty! <
                                      orderController.count.value) {
                                    Utils.showFloatingErrorSnack(
                                        "The available quantity is ${orderController
                                            .datumInstance.value.qty}");
                                  } else {

                                    orderController.cartList.add(CartItem(
                                        datum:
                                        orderController.datumInstance.value,
                                        quantity: orderController.count.value));
                                    orderController.cartList.refresh();

                                    // CartItem.
                                    var cartList =
                                        orderController.cartList.value;
                                    log(jsonEncode(cartList));

                                    /// saving the cart list to local storage
                                    LocalStorage.saveJson(
                                        key: LocalStorageKeys.cartList,
                                        value: jsonEncode(cartList));
                                    addSuccessfulPopup(context);

                                    var cart = await LocalStorage.readJson(
                                        key: LocalStorageKeys.cartList);
                                    var list = jsonDecode(cart);
                                    print("===============>cart" +
                                        list.length.toString());
                                  }
                                  // orderController.cartList.addIf(condition, item)
                                  print(
                                      "The cart have ${orderController.cartList
                                          .length} items");
                                  orderController
                                      .totalSumOfCartProductsPrices(0);
                                  print(
                                      orderController.datumInstance.value.name);
                                  // String formattedAmount = widget.productData["price"].replaceAll('\$', '');
                                  // var formattedPrice =
                                  //     int.parse(formattedAmount);
                                  // orderController.totalPrice.value +=
                                  //     formattedPrice;
                                  print(orderController.totalPrice.value);
                                  // dashBoardController.newArrival.value.data?.where((element) => element.id==orderController.datumInstance.value.id);
                                  // orderController.count.value=1;
                                  // var geti = await LocalStorage.readJson(key: LocalStorageKeys.cartList);
                                  // List<dynamic> decodedMap = json.decode(geti);
                                  // print("================> $decodedMap");
                                }
                              })
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }

  void buyNowModalSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r))),
        isDismissible: true,
        enableDrag: true,
        useRootNavigator: true,
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return GetBuilder(
              init: orderController,
              builder: (cont) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: kbtngradient,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(35.r))),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                          top: 20,
                          child: SvgPicture.asset('assets/Rectangle 773.svg')),
                      Positioned(
                          top: 20,
                          right: 20,
                          child: InkWell(
                              onTap: () {
                                print('close');
                                Get.close(1);
                              },
                              child: SvgPicture.asset(
                                'assets/Icon ionic-ios-close.svg',
                                color: Colors.white,
                              ))),
                      20.verticalSpace,
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          30.verticalSpace,
                          ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.r, vertical: 30.r),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 108.r,
                                    height: 97.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      // image: DecorationImage(
                                      //     image: AssetImage(
                                      //         'assets/M2-MacBook-Air-2022-Feature0012.png'),
                                      //     fit: BoxFit.fill),
                                    ),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: widget.productData["image"]
                                          .toString() ==
                                          ""
                                          ?
                                      // "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                                      "NoImage"
                                          :
                                      // ImageUrls.kProduct +
                                      //         // widget
                                      widget.productData["image"]
                                          .toString(),
                                      placeholder: (context, url) =>
                                          Icon(Icons.image),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  20.horizontalSpace,
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.productData["name"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          'Color : MK46 Black',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w100),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Quantity',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20.sp)),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          orderController.minus();
                                        },
                                        child: Container(
                                          width: 28.r,
                                          height: 28.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/Icon awesome-minus.svg',
                                            color: highlightedText,
                                          ),
                                        ),
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        orderController.count.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      10.horizontalSpace,
                                      InkWell(
                                        onTap: () => orderController.add(),
                                        child: Container(
                                          width: 29.r,
                                          height: 29.r,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                          child: SvgPicture.asset(
                                            'assets/Icon awesome-plus.svg',
                                            color: highlightedText,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              20.verticalSpace,
                              // Text(
                              //   'Shipping US \$0.00',
                              //   style: TextStyle(
                              //       fontSize: 22.sp,
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.bold),
                              // ),
                              // 20.verticalSpace,
                              // // Container(
                              // //   height: 79.h,
                              // //   child: ListView.builder(
                              // //     shrinkWrap: true,
                              // //     physics: const BouncingScrollPhysics(),
                              // //     scrollDirection: Axis.horizontal,
                              // //     itemCount: laptopImages.length,
                              // //     itemBuilder: (context, index) => Container(
                              // //       margin: EdgeInsets.only(right: 10.r),
                              // //       width: 71.r,
                              // //       // height: 83.h,
                              // //       decoration: BoxDecoration(
                              // //           borderRadius:
                              // //               BorderRadius.circular(15.r),
                              // //           image: DecorationImage(
                              // //               image:
                              // //                   AssetImage(laptopImages[index]),
                              // //               fit: BoxFit.fill)),
                              // //     ),
                              // //   ),
                              // // ),
                              // 20.verticalSpace,
                              // Text(
                              //   'From China to USA via DHL Standard\nEstimated Delivery 41 - 50 days',
                              //   style: TextStyle(
                              //       color: Colors.white, fontSize: 12.sp),
                              // ),
                              24.verticalSpace,
                              button2(
                                Get.width,
                                59.h,
                                'Proceed To Buy',
                                    () async {
                                  if (orderController.datumInstance.value.qty! <
                                      orderController.count.value) {
                                    Utils.showFloatingErrorSnack(
                                        "The product is Out of Stock!");
                                  } else {
                                    /// mechanism for add to cart functionality
                                    if (orderController.cartList.isNotEmpty) {
                                      ///for loop
                                      orderController.cartList.value
                                          .forEach((element) {
                                        print(
                                            "======> datum ID${element.datum
                                                .id}");
                                        print(
                                            "======> datum ID${orderController
                                                .datumInstance.value.id}");
                                        print("caRT list" +
                                            orderController.cartList
                                                .toString());
                                        if (element.datum.id ==
                                            orderController
                                                .datumInstance.value.id) {
                                          print("In if");
                                          Get.back();
                                          Utils.showSnack(
                                              "Item already in Cart", context);
                                        } else {
                                          print("In else");
                                          orderController.cartList.add(CartItem(
                                              datum: orderController
                                                  .datumInstance.value,
                                              quantity:
                                              orderController.count.value));
                                          // addSuccessfulPopup(context);
                                          Get.to(() => OrderConfirmation());
                                          orderController
                                              .totalSumOfCartProductsPrices(0);
                                        }
                                      });
                                    } else {
                                      orderController.cartList.add(CartItem(
                                          datum: orderController
                                              .datumInstance.value,
                                          quantity:
                                          orderController.count.value));
                                      // CartItem.
                                      var cartList =
                                          orderController.cartList.value;
                                      log(jsonEncode(cartList));

                                      /// saving the cart list to local storage
                                      LocalStorage.saveJson(
                                          key: LocalStorageKeys.cartList,
                                          value: jsonEncode(cartList));
                                      // addSuccessfulPopup(context);
                                      Get.to(() => OrderConfirmation());
                                      var cart = await LocalStorage.readJson(
                                          key: LocalStorageKeys.cartList);
                                      var list = jsonDecode(cart);
                                      print("===============>cart" +
                                          list.length.toString());
                                    }
                                    print(
                                        "The cart have ${orderController
                                            .cartList.length} items");
                                    orderController
                                        .totalSumOfCartProductsPrices(0);
                                    print(orderController
                                        .datumInstance.value.name);
                                    print(orderController.totalPrice.value);
                                  }
                                },
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        });
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9210526, size.height * 0.9999875);
    path_0.lineTo(size.width * 0.07894737, size.height * 0.9999875);
    path_0.arcToPoint(Offset(0, size.height * 0.8124898),
        radius:
        Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(0, size.height * 0.6873914);
    path_0.cubicTo(
        size.width * 0.0008368421,
        size.height * 0.6874914,
        size.width * 0.001721053,
        size.height * 0.6874914,
        size.width * 0.002631579,
        size.height * 0.6874914);
    path_0.arcToPoint(Offset(size.width * 0.002631579, size.height * 0.3249959),
        radius:
        Radius.elliptical(size.width * 0.07631579, size.height * 0.1812477),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.cubicTo(
        size.width * 0.001763158,
        size.height * 0.3249959,
        size.width * 0.0008736842,
        size.height * 0.3249959,
        0,
        size.height * 0.3251084);
    path_0.lineTo(0, size.height * 0.1874977);
    path_0.arcToPoint(Offset(size.width * 0.07894737, 0),
        radius:
        Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.9210526, 0);
    path_0.arcToPoint(Offset(size.width, size.height * 0.1874977),
        radius:
        Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width, size.height * 0.3251084);
    path_0.arcToPoint(Offset(size.width, size.height * 0.6874039),
        radius:
        Radius.elliptical(size.width * 0.07631579, size.height * 0.1812477),
        rotation: 0,
        largeArc: false,
        clockwise: false);
    path_0.lineTo(size.width, size.height * 0.8124898);
    path_0.arcToPoint(Offset(size.width * 0.9210526, size.height * 0.9999875),
        radius:
        Radius.elliptical(size.width * 0.07894737, size.height * 0.1874977),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint_0_fill = Paint()
      ..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
