import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/localNotifications.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Controller/dashBoardController.dart';
import 'package:app_fliplaptop/Controller/productController.dart';
import 'package:app_fliplaptop/Controller/wishListController.dart';
import 'package:app_fliplaptop/Screens/AddProductScreen.dart';
import 'package:app_fliplaptop/Screens/MyCartScreen.dart';
import 'package:app_fliplaptop/Screens/stripeConnect.dart';
import 'package:app_fliplaptop/res/utils/utils.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/drawer.dart';
import '../components/global.dart';
import 'HomeScreen.dart';
import 'MessagesScreen.dart';
import 'ProfileScreen.dart';

class StartAppScreen extends StatefulWidget {
  StartAppScreen({super.key});

  @override
  State<StartAppScreen> createState() => _StartAppScreenState();
}

class _StartAppScreenState extends State<StartAppScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // getData();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // getNotiCount();
    _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      announcement: false,
    );
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description

      importance: Importance.high,
    );

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen"+message.toString());
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createAndDisplayNotification(message);
          Utils.showFloatingSuccessSnack(message.notification!.body.toString());
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data2 ${message.data['_id']}");
        }
      },
    );
    super.initState();
    getStripeStatus();
    LocalNotificationService.requestPermissionForIOS();
    LocalNotificationService.listenForegroundMessage(
        flutterLocalNotificationsPlugin, channel);
  }

  bool keyboardOpen = false;

  final bottomcontroller = Get.put(BottomController());
  final dashBoardController = Get.put(DashBoardController());
  String stripeAvailable = "";
  int pageIndex = 2;

  getStripeStatus() async {
    String stripeStatus =
        await LocalStorage.readJson(key: LocalStorageKeys.stripeConnected).toString();
    stripeAvailable = stripeStatus;
    setState(() {});
    // log("available"+stripeAvailable);
    // return stripeStatus;
  }

//   @override
// void initState() {
//   super.initState();

//   var keyboardVisibilityController = KeyboardVisibilityController();
//   // Query
//   print('Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');

//   // Subscribe
//   keyboardVisibilityController.onChange.listen((bool visible) {
//     print('Keyboard visibility update. Is visible: ${visible}');
//   });
// }

  buildMyNavBar(BuildContext context) {
    return Container(
      height: 120.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 388.w,
                height: 70.h,

                // width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 30,
                      offset: Offset(0, 17), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(35.r),
                  gradient: kgradient,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    bottomItem(pages[0]['title'], pages[0]['icon'], 0),
                    bottomItem(pages[1]['title'], pages[1]['icon'], 1),
                    SizedBox(
                      width: 60.w,
                    ),
                    bottomItem(pages[2]['title'], pages[2]['icon'], 2),
                    bottomItem(pages[3]['title'], pages[3]['icon'], 3),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -4,
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // log("stripe"+stripeStatus);

                          if (ApiServices.storeId.toString() == "") {
                            print(ApiServices.storeId);
                            print("empty");
                            // print(userController.user.store.i)
                            Get.toNamed('/CreateStoreScreen');
                          } else {
                            if (stripeAvailable == "true") {
                              final addProductController =
                                  Get.put(ProductController());
                              addProductController
                                      .addproductApiModel["store_id"] =
                                  ApiServices.storeId.toString();
                              print("not empty");
                              bottomcontroller.navBarChange(0);
                              Get.to(
                                () => AddProductScreen(
                                  storeID: ApiServices.storeId,
                                ),
                              );
                            } else {
                              Utils.showSnack(
                                  "Must Connect Stripe to Add Products",
                                  context);
                              Get.to(() => StripeConnect());
                              // StripeConnect()
                            }
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Container(
                              height: 63.r,
                              width: 63.r,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    color: Colors.white),
                                gradient: kbtngradient,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'POST',
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      // 60.verticalSpace
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  bottomItem(title, icon, index) {
    return InkWell(
      onTap: () => bottomcontroller.navBarChange(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22.5.w,
            height: 22.5.h,
            child: SvgPicture.asset(
              icon,
              color: bottomcontroller.navigationBarIndexValue == index
                  ? Colors.grey
                  : Colors.white,
            ),
          ),
          8.verticalSpace,
          Text(
            title,
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: bottomcontroller.navigationBarIndexValue == index
                    ? Colors.grey
                    : Colors.white),
          )
        ],
      ),
    );
  }

  List pages = [
    {
      'page': HomeScreen(),
      'title': "Home",
      'icon': 'assets/Path 518.svg',
    },
    {'page': MessageScreen(), 'title': "Chat", 'icon': "assets/Group 11.svg"},
    {'page': MyCartScreen(), 'title': "Orders", 'icon': "assets/Path 521.svg"},
    {
      'page': ProfileScreen(),
      'title': "Profile",
      'icon': "assets/Path 523.svg"
    },
  ];
  WishListController wishListController = Get.put(WishListController());

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    return GetBuilder(
        init: bottomcontroller,
        builder: (controller) {
          getStripeStatus();

          return Scaffold(
            drawer: DrawerMenu(context),
            backgroundColor: kPageBgColor,
            appBar: bottomcontroller.navigationBarIndexValue == 0 && !dashBoardController.isLoading.value
                ? AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity(horizontal: -4.0),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          tooltip: MaterialLocalizations.of(context)
                              .openAppDrawerTooltip,
                          icon: SvgPicture.asset(
                            'assets/Group 78.svg',
                          ),
                          iconSize: 10.r,
                        );
                      },
                    ),
                    actions: [
                      // IconButton(
                      //     onPressed: () {},
                      //     icon: SvgPicture.asset('assets/Group 50.svg')),
                      IconButton(
                          onPressed: () {
                            Get.toNamed('/NotificationScreen');
                          },
                          icon: SvgPicture.asset('assets/Group 1049.svg'))
                    ],
                    centerTitle: true,
                    title: Text(
                      "Home",
                      style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  )
                : null,

            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text('Tap back again to leave'),
              ),
              child: pages[bottomcontroller.navigationBarIndexValue]['page'],
            ),
            bottomNavigationBar: GetBuilder<BottomController>(
              builder: (_) => buildMyNavBar(context),
            ),
          );
        });
  }
}
