import 'dart:developer';

import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/app_url.dart';
import 'package:app_fliplaptop/Apiserrvices/firebaseServices.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Controller/UserController.dart';
import 'package:app_fliplaptop/Controller/chatController.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/orderController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Controller/wishListController.dart';
import 'package:app_fliplaptop/Screens/ProductsListScreen.dart';
import 'package:app_fliplaptop/Screens/StoreProfileScreen.dart';
import 'package:app_fliplaptop/components/moreProductCard.dart';
import 'package:app_fliplaptop/components/newArrivalCard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/global.dart';
import '../models/dashBoardModel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    msgInit();
    // TODO: implement initState
    super.initState();
  }

  msgInit() async {
    await dashBoardController
        .getDashboardData()
        .then((value) => Future.delayed(Duration.zero, () {
              for (var i = 0;
                  i < dashBoardController.newArrival.value.data!.length;
                  i++) {
                log("removed ID" +
                    dashBoardController.newArrival.value.data![i].name!);
                if (dashBoardController.newArrival.value.data?[i].storeId
                        .toString() ==
                    ApiServices.storeId) {
                  dashBoardController.newArrival.value.data?.removeAt(i);
                } else {}

                // moreProduct.value.data!.removeWhere(
                //         (element) => element.id.toString() == newArrival.value.data![i].id.toString());
                // log("index is "+index.toString());
              }
              setState(() {});
            }));
    await FirebaseServices().getUniqueMembers();
    await ApiServices().getUsersData(chatController.listOfUserIDs.value);
  }

  // List brandsImage = [
  TextEditingController _searchBrand = TextEditingController();

  final dashBoardController = Get.put(DashBoardController());

  final orderController = Get.put(OrderController());

  final wishListController = Get.put(WishListController());

  final userController = Get.put(UserController());

  Store storeInstance = Store();

  bool  isRefresh = false;
  // RefreshController refreshController = RefreshController(initialRefresh: true);

  ChatController chatController = Get.put(ChatController());
  List<String> _filters = ['Low-High', 'High-Low', 'A-Z', 'Z-A'];
  String _selectedFilter = 'Low-High';
  String getFilterType() {
    if (_selectedFilter == "Low-High") {
      return "lowToHigh";
    }
    else if (_selectedFilter == "High-Low") {
      return "highToLow";
    } else if (_selectedFilter == "A-Z") {
      return "AToZ";
    } else if (_selectedFilter == "Z-A") {
      return "ZToA";
    }
    else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiServices().myProfileApiFunc();
    dashBoardController.moreProductList.value
        .removeWhere((element) => element.storeId == ApiServices.storeId);
    // // moreProduct.value.data!.removeWhere((element) => element.user!.id==userController.user.id);
    dashBoardController.storeList.value
        .removeWhere((element) => element.id.toString() == ApiServices.storeId);
    //
    dashBoardController.newArrival.value.data?.removeWhere(
        (element) => element.storeId.toString() == ApiServices.storeId);

    // Future.delayed(Duration.zero,(){
    //   setState(() {
    //
    //   });
    // });

    // ApiServices().getUsersData(
    //     chatController.listOfUserIDs);
    // getUserData();

    // userController.getFollowedStores();
    print("text msgs length" + chatController.listOfUsers.length.toString());
    print("text msgs length" + ApiServices.storeId);
    print("new Arrival" + ApiServices.storeId);
    return Scaffold(
      backgroundColor: kPageBgColor,
      body: Obx(
        () {
          return RefreshIndicator(
              color: kprimaryColor,
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: dashBoardController.isLoading.value && !isRefresh
                    ? Center(
                        child: Loader.spinkit,
                      )
                    : SizedBox(
                        // height: 1.5.sh,
                        child: ListView(
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.r, vertical: 20.r),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 311.w,
                                  height: 51.h,
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 25.r),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(35.r)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        opticalSize: 0.9,
                                        Icons.search,
                                        color: Color(0xff1D1E1E),
                                        size: 21,
                                      ),
                                      10.horizontalSpace,
                                      Expanded(
                                          child: InkWell(
                                        onTap: () {
                                          Get.toNamed('/SuggestSearchScreen');
                                        },
                                        child: TextField(
                                          controller: _searchBrand,
                                          // onTap: () {
                                          //   Get.toNamed('/SuggestSearchScreen');
                                          // },
                                          // onEditingComplete: () {
                                          //   Get.toNamed('/SuggestSearchScreen');
                                          // },
                                          style: GoogleFonts.inter(
                                              color: Color(0xff1D1E1E),
                                              fontSize: 15.sp),
                                          cursorColor: Color(0xff1D1E1E),
                                          decoration: InputDecoration(
                                              enabled: false,
                                              isCollapsed: true,
                                              isDense: true,
                                              contentPadding: EdgeInsets.only(
                                                  top: 0, bottom: 3.5.r),
                                              border: InputBorder.none,
                                              hintText: 'Search here',
                                              hintStyle: GoogleFonts.inter(
                                                  color: Color(0xff1D1E1E),
                                                  fontSize: 15.sp,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed('/FilterScreen');
                                  },
                                  child: Container(
                                    height: 51.h,
                                    width: 69.w,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        35.r,
                                      ),
                                    ),
                                    child: SvgPicture.asset(
                                      'assets/Group 4.svg',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            32.verticalSpace,
                            Text(
                              'Brands',
                              style: GoogleFonts.inter(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            14.verticalSpace,
                            brandHorizontalList(),
                            24.verticalSpace,
                            Text(
                              'Store',
                              style: GoogleFonts.inter(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            14.verticalSpace,
                            storeHorizontalList(),
                            24.verticalSpace,
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 0.25.sw,
                                child: DropdownButton<String>(
                                  value: _selectedFilter,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedFilter = newValue!;
                                    });
                                    dashBoardController.getDashBoardFilter(getFilterType());
                                  },
                                  items:
                                  _filters.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            10.h.verticalSpace,

                            // Text( dashBoardController.newArrival.value
                            //     .data![0].productImage.toString(),),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New Arrivals',
                                  style: GoogleFonts.inter(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                4.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Top products incredible price',
                                      style: GoogleFonts.inter(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14.sp),
                                    ),
                                    dashBoardController.newArrival.value.data ==
                                            null
                                        ? Container()
                                        : Visibility(
                                            visible: dashBoardController
                                                    .newArrival
                                                    .value
                                                    .data!
                                                    .length >
                                                2,
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(
                                                  () => ProductListScreen(
                                                    isNewArrival: true,
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'View More',
                                                style: GoogleFonts.inter(
                                                    fontSize: 14.sp,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Color(0xffC20000)
                                                            .withOpacity(0.5),
                                                    color: Color(0xffC20000)
                                                        .withOpacity(0.5)),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                            // Text(dashBoardController
                            //     .newArrival.value.data!.length.toString()),
                            20.verticalSpace,
                            dashBoardController.newArrival.value.data?.length ==
                                    0
                                ? Container(
                                    child: Center(
                                      child: Text(
                                        "No new Arrivals",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ),
                                  )
                                : newArrivalList(),
                            24.verticalSpace,
                            dashBoardController
                                        .moreProduct.value.data!.length ==
                                    0
                                ? Container()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'More Products',
                                        style: GoogleFonts.inter(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      4.verticalSpace,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Top products incredible price',
                                            style: GoogleFonts.inter(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 14.sp),
                                          ),
                                          dashBoardController.moreProduct.value
                                                      .data!.length ==
                                                  0
                                              ? Container()
                                              : Visibility(
                                                  visible: dashBoardController
                                                          .moreProduct
                                                          .value
                                                          .data!
                                                          .length >
                                                      4,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        () => ProductListScreen(
                                                          isNewArrival: false,
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'View More',
                                                      style: GoogleFonts.inter(
                                                          fontSize: 14.sp,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Color(0xffC20000)
                                                                  .withOpacity(
                                                                      0.5),
                                                          color:
                                                              Color(0xffC20000)
                                                                  .withOpacity(
                                                                      0.5)),
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                      10.verticalSpace,
                                      // Text(dashBoardController.completeData.value.data.toSting()),

                                      moreProductGridView()
                                    ],
                                  ),
                          ],
                        ),
                      ),
              ),
              onRefresh: () async {
                setState(() {
                  isRefresh = true;
                });
                await dashBoardController.getDashboardData();
                setState(() {
                  isRefresh = false;
                });
              });
        },
      ),
    );
  }

  // this is the moreProduct gridView
  Widget moreProductGridView() {
    log("more product list is of length" +
        dashBoardController.moreProduct.value.data!.length.toString());
    return dashBoardController.moreProduct.value.data! == 0
        ? Container()
        : SizedBox(
            height: 0.55.sh,
            child: GridView.builder(
              itemCount: dashBoardController.moreProduct.value.data!.length > 4
                  ? 4
                  : dashBoardController.moreProduct.value.data!.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.83),
              itemBuilder: (BuildContext context, int index) {
                var storeIndex = dashBoardController.storeList.indexWhere(
                    (element) =>
                        element.id ==
                        dashBoardController
                            .moreProduct.value.data![index].storeId);
                if (storeIndex != -1) {
                  storeInstance = dashBoardController.storeList[storeIndex];
                  // setState(() {
                  //
                  // });
                }
                // if (dashBoardController.newArrival.value.data!.isNotEmpty &&
                //     dashBoardController.moreProduct.value.data!.isNotEmpty) {
                //   for (var i = 0;
                //   i < dashBoardController.newArrival.value.data!.length;
                //   i++) {
                //     dashBoardController.moreProductList.value.removeWhere((element) =>
                //     element.id == dashBoardController.newArrival.value.data![i].id);
                //     dashBoardController.moreProduct.value.data!.removeWhere(
                //             (element) =>
                //         element.id ==
                //             dashBoardController.newArrival.value.data![i].id);
                //     dashBoardController.moreProductList.value.removeWhere((element) =>
                //     element.id == dashBoardController/newArrival.value.data![i].id);
                //   }
                //
                //   if (dashBoardController.moreProductList.isNotEmpty) {
                //
                //   }
                //   else {
                //     null;
                //   }
                // }
                // Store storeInstance = Store();

                // }
                return dashBoardController.moreProduct.value.data!.isEmpty
                    ? Container()
                    : MoreProductCard(
                        index: index,
                        brand: dashBoardController
                            .moreProduct.value.data![index].name!,
                        rating:
                            '${dashBoardController.moreProduct.value.data![index].avg == "" ? 0 : dashBoardController.moreProduct.value.data![index].avg.toString().substring(0, 3)}',
                        price:
                            '\$ ${dashBoardController.moreProduct.value.data![index].price}',
                        dealPrice:
                            '${dashBoardController.moreProduct.value.data![index].dealItemPrice}',
                        dealItemStartDatetime: dashBoardController.moreProduct
                            .value.data![index].dealItemStartDatetime
                            .toString(),
                        dealItemEndDatetime: dashBoardController
                            .moreProduct.value.data![index].dealItemEndDatetime
                            .toString(),
                        dealItemPercentage: dashBoardController
                            .moreProduct.value.data![index].dealItemPercentage
                            .toString(),
                        img: dashBoardController.moreProduct.value.data![index]
                                .productImage!.isEmpty
                            ? ""
                            : ImageUrls.kProduct +
                                (dashBoardController.moreProduct.value
                                        .data![index].productImage![0].name ??
                                    ""),
                        condition: dashBoardController
                                .moreProduct.value.data![index].conditionType ??
                            "",
                        description: dashBoardController
                                .moreProduct.value.data![index].descriptions ??
                            "",
                        storeImage: dashBoardController
                                .moreProduct.value.data![index].storeImage ??
                            "",
                        storeCompleteData: storeInstance,
                        // Store(
                        //   id: dashBoardController.moreProduct.value.data![index].storeId,
                        //   name: .moreProduct.value.data![index].storeName,
                        //   image:
                        //       dashBoardController.moreProduct.value.data![index].storeImage,
                        // ),
                        storeID: storeInstance.id ?? 0,
                        discount: dashBoardController
                            .moreProduct.value.data![index].discount,
                        postedUserData: dashBoardController
                                .moreProduct.value.data![index].user ??
                            User(),
                        // dealPrice:dashBoardController
                        //   .moreProductList.value[index].dealItemPrice??"",
                      );
              },
            ),
          );
  }

  // this is the list of newArrival product
  Widget newArrivalList() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: dashBoardController.newArrival.value.data!.length > 2
            ? 2
            : dashBoardController.newArrival.value.data!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          orderController.datumInstance.value =
              dashBoardController.newArrival.value.data![index];
          print(
              "=============> images  ${dashBoardController.newArrival.value.data![0].productImage!.isEmpty}");
          print(
              "=============> datum name  ${orderController.datumInstance.value.name}");
          var storeIndex = dashBoardController.storeList.indexWhere((element) =>
              element.id ==
              (dashBoardController.newArrival.value.data![index].storeId));
          // Store storeInstance = Store();
          if (storeIndex != -1) {
            storeInstance = dashBoardController.storeList[storeIndex];
          }
          final productController = Get.put(ProductController());

          // else{
          //    storeInstance = Store();
          // }
          return NewArrivalCard(
            index: index,
            brand: dashBoardController.newArrival.value.data![index].name!,
            rating:
                '${dashBoardController.newArrival.value.data![index].avg == "" ? 0 : dashBoardController.newArrival.value.data![index].avg.toString().substring(0, 3)}',
            price:
                '\$ ${dashBoardController.newArrival.value.data![index].price}',
            dealPrice: dashBoardController
                .newArrival.value.data![index].dealItemPrice
                .toString(),
            dealItemStartDatetime: dashBoardController
                .newArrival.value.data![index].dealItemStartDatetime
                .toString(),
            dealItemEndDatetime: dashBoardController
                .newArrival.value.data![index].dealItemEndDatetime
                .toString(),
            dealItemPercentage: dashBoardController
                .newArrival.value.data![index].dealItemPercentage
                .toString(),
            img: dashBoardController
                    .newArrival.value.data![0].productImage!.isEmpty
                ? ""
                : ImageUrls.kProduct +
                    dashBoardController
                        .newArrival.value.data![index].productImage![0].name
                        .toString(),
            condition: 'New',
            description:
                dashBoardController.newArrival.value.data![index].descriptions!,
            storeImage:
                dashBoardController.newArrival.value.data![index].storeImage!,
            storeCompleteData: storeInstance,
            // Store(
            //   id: dashBoardController.newArrival.value.data![index].storeId,
            //   name: dashBoardController.newArrival.value.data![index].storeName,
            //   image:
            //       dashBoardController.newArrival.value.data![index].storeImage,
            // ),
            storeID: dashBoardController.storeList[index].id!,
            discount:
                dashBoardController.newArrival.value.data![index].discount,
            postedUserData:
                dashBoardController.newArrival.value.data![index].user ??
                    User(),
            isStoreProfile: false,
          );
        });
  }

  // this is horizontal list of the stores
  Widget storeHorizontalList() {
    return Container(
      height: 60.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: dashBoardController.storeList.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  dashBoardController.getDashboardData().then((value) =>   Get.to(
                        () => StoreProfileScreen(
                      storeData: dashBoardController.storeList[index],
                      postedUserData: User(),
                          isStore: true,
                    ),
                  ));

                },
                child: Container(
                  width: 56.r,
                  height: 56.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    // image: DecorationImage(
                    //   image: AssetImage(
                    //     brandsImage[index]['icon'],
                    //   ),
                    // ),
                  ),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10.r),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: dashBoardController.storeList[index].image ==
                                ""
                            ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                            : ImageUrls.kStoreProfile +
                                dashBoardController.storeList[index].image
                                    .toString(),
                        placeholder: (context, url) => Icon(Icons.image),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  // child: Image.asset(
                  //   brandsImage[index],
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
              20.horizontalSpace
            ],
          );
        },
      ),
    );
  }

  // this is horizontal list of the brands
  Widget brandHorizontalList() {
    return Container(
      height: 60.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: dashBoardController.brandList.length,
        itemBuilder: (context, index) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                // dashBoardController.getDashboardData().then((value) =>   );
                Get.to(
                      () => StoreProfileScreen(
                    storeData: dashBoardController.storeList[index],
                    postedUserData: User(),
                    isStore: false,
                    brandData: dashBoardController.brandList[index],
                  ),
                );

              },
              child: Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(10.r),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: dashBoardController.brandList[index].image == ""
                          ? "https://fliplaptop.thesuitchstaging.com/assets/images/store/profile/1689949591213.jpg"
                          : ImageUrls.kCategory +
                              dashBoardController.brandList[index].image
                                  .toString(),
                      placeholder: (context, url) => Icon(Icons.image),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            20.horizontalSpace
          ],
        ),
      ),
    );
  }
}
