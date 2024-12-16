import 'dart:io';

import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Screens/MyOrderTypeScreen.dart';
import 'package:app_fliplaptop/Screens/MyStoreProfileScreen.dart';
import 'package:app_fliplaptop/Screens/OrderConfirmation.dart';
import 'package:app_fliplaptop/Screens/ProductsListScreen.dart';
import 'package:app_fliplaptop/Screens/SettingScreen.dart';
import 'package:app_fliplaptop/Screens/SplashScreen.dart';
import 'package:app_fliplaptop/Screens/myGivenReviews.dart';
import 'package:app_fliplaptop/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'Screens/AddDescriptionScreen.dart';
import 'Screens/AddNewAddressScreen.dart';
import 'Screens/AddProductPriceScreen.dart';
import 'Screens/AddTextScreen.dart';
import 'Screens/AppleScreen.dart';
import 'Screens/CreatePasswordScreen.dart';
import 'Screens/CreateStoreScreen.dart';
import 'Screens/DellScreen.dart';
import 'Screens/DraftedProductScreen.dart';
import 'Screens/EditProfileScreen.dart';
import 'Screens/FaqScreen.dart';
import 'Screens/FilterScreen.dart';
import 'Screens/FollowerScreen.dart';
import 'Screens/FollowingStoriesScreen.dart';
import 'Screens/ForgotScreen.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/MessagesScreen.dart';
import 'Screens/MyCartScreen.dart';
import 'Screens/MyOrderScreen.dart';
import 'Screens/MyReviewScreen.dart';
import 'Screens/NotificationScreen.dart';
import 'Screens/OrderDetailScreen.dart';
import 'Screens/PersonalPostedItem.dart';
import 'Screens/PrivacynPolicyScreen.dart';
import 'Screens/ProfileScreen.dart';
import 'Screens/SelectPackageScreen.dart';
import 'Screens/SelectPaymentMethod.dart';
import 'Screens/SelectTemplate.dart';
import 'Screens/ShippingAddress.dart';
import 'Screens/SignUpScreen.dart';
import 'Screens/StartNavigatorScreen.dart';
import 'Screens/StoreProfileScreen.dart';
import 'Screens/SuggestSearchScreen.dart';
import 'Screens/TermsnConditionScreen.dart';
import 'Screens/ToshibaScreen.dart';
import 'Screens/TrackingDetailScreen.dart';
import 'Screens/VerificationScreen.dart';
import 'Screens/WhistListScreen.dart';
import 'models/dashBoardModel.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?  await Firebase.initializeApp(
        // name: "FlipLaptop",
    options: DefaultFirebaseOptions.currentPlatform,
  ):
  await Firebase.initializeApp(
        name: "FlipLaptop",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  // runApp(const MyApp());
  if (Platform.isAndroid) {
    await Firebase.initializeApp();
     } else if (Platform.isIOS) {
    LocalStorage.saveJson(
      key: LocalStorageKeys.deviceType,
      value: "apple",
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return RefreshConfiguration(
            footerTriggerDistance: 15,
            dragSpeedRatio: 0.91,
            headerBuilder: () => MaterialClassicHeader(),
            footerBuilder: () => ClassicFooter(),
            enableLoadingWhenNoData: false,
            enableRefreshVibrate: false,
            enableLoadMoreVibrate: false,
            shouldFooterFollowWhenNotFull: (state) {
              // If you want load more with noMoreData state ,may be you should return false
              return false;
            },
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/SplashScreen',
              getPages: [
                GetPage(
                    name: '/PrivacynPolicyScreen',
                    page: () => PrivacynPolicyScreen()),
                GetPage(name: '/LoginScreen', page: () => LoginScreen()),
                GetPage(
                    name: '/TermsnConditionsScreen',
                    page: () => TermsnConditionsScreen()),
                GetPage(
                    name: '/FollowerUserScreen',
                    page: () => FollowerUserScreen()),
                GetPage(name: '/MyReviewScreen', page: () => MyReviewScreen()),
                GetPage(
                    name: '/PersonalPostedProductScreen',
                    page: () => PersonalPostedProductScreen(
                          storeID: "",
                        )),
                GetPage(
                    name: '/ListOfDraftedProductScreen',
                    page: () => ListOfDraftedProductScreen()),
                GetPage(
                    name: '/MyGivenReviewScreen',
                    page: () => MyGivenReviewScreen()),
                // GetPage(
                //     name: '/ListOfProductScreen',
                //     page: () => ListOfProductScreen()),
                GetPage(
                    name: '/MyOrderTypeScreen',
                    page: () => MyOrderTypeScreen()),
                GetPage(
                    name: '/TrackingDetailScreen',
                    page: () => TrackingDetailScreen()),
                GetPage(
                    name: '/TrackingDetailScreen',
                    page: () => TrackingDetailScreen()),
                GetPage(name: '/SettingScreen', page: () => SettingScreen()),
                GetPage(
                    name: '/SelectPaymentMethod',
                    page: () => SelectPaymentMethod(
                          fromProfile: false,
                        )),
                GetPage(
                    name: '/OrderConfirmationScreen',
                    page: () => OrderConfirmation()),
                // GetPage(
                //     name: '/ReviewProductScreen',
                //     page: () => ReviewProductScreen()),
                GetPage(name: '/FilterScreen', page: () => FilterScreen()),
                GetPage(name: '/ProfileScreen', page: () => ProfileScreen()),
                GetPage(
                    name: '/OrderDetailScreen',
                    page: () => OrderDetailScreen()),
                GetPage(
                    name: '/SuggestSearchScreen',
                    page: () => SuggestSearchScreen()),
                GetPage(
                    name: '/ShippingAddressScreen',
                    page: () => ShippingAddressScreen()),
                GetPage(
                    name: '/AddNewAddressScreen',
                    page: () => AddNewAddressScreen()),
                GetPage(
                    name: '/CreateStoreScreen',
                    page: () => CreateStoreScreen()),
                // GetPage(
                //     name: '/EditStoreProfileScreen',
                //     page: () => EditStoreProfileScreen()),
                GetPage(
                    name: '/EditProfileScreen',
                    page: () => EditProfileScreen()),
                GetPage(
                    name: '/AddProductPriceScreen',
                    page: () => AddProductPriceScreen()),
                GetPage(
                    name: '/AddDescriptionScreen',
                    page: () => AddDescriptionScreen()),
                // GetPage(name: '/AddProductScreen', page: () => AddProductScreen()),
                GetPage(
                    name: '/NotificationScreen',
                    page: () => NotificationScreen()),
                GetPage(name: '/FaqScreen', page: () => FaqScreen()),
                GetPage(
                    name: '/SelectPackageScreen',
                    page: () => SelectPackageScreen()),
                GetPage(name: '/AddTextScreen', page: () => AddTextScreen()),
                GetPage(
                    name: '/SelectTemplateScreen',
                    page: () => SelectTemplateScreen()),
                GetPage(name: '/AppleScreen', page: () => AppleScreen()),
                GetPage(name: '/ToshibaScreen', page: () => ToshibaScreen()),
                GetPage(name: '/DellScreen', page: () => DellScreen()),
                GetPage(
                    name: '/MyStoreProfileScreen',
                    page: () => MyStoreProfileScreen()),
                GetPage(
                    name: '/MyOrderScreen',
                    page: () => MyOrderScreen(
                          isSeller: false,
                        )),
                GetPage(
                    name: '/StoreProfileScreen',
                    page: () => StoreProfileScreen(
                          postedUserData: User(),
                      isStore: true,

                    )),
                GetPage(
                    name: '/FollowingStoriesScreen',
                    page: () => FollowingStoriesScreen()),
                GetPage(
                    name: '/MyWhistListScreen', page: () => MyWishlistScreen()),
                GetPage(name: '/MyCartScreen', page: () => MyCartScreen()),
                GetPage(
                    name: '/ProductListScreen',
                    page: () => ProductListScreen()),
                // GetPage(name: '/ChatScreen', page: () => ChatScreen(senderData: UserModel(), conversationID: '',)),
                GetPage(name: '/MessageScreen', page: () => MessageScreen()),
                GetPage(name: '/HomeScreen', page: () => HomeScreen()),
                GetPage(name: '/StartAppScreen', page: () => StartAppScreen()),
                GetPage(
                    name: '/CreatePasswordScreen',
                    page: () => CreatePasswordScreen()),
                GetPage(
                    name: '/ForgotPasswordScreen',
                    page: () => ForgotPasswordScreen()),
                GetPage(
                    name: '/VerificationScreen',
                    page: () => VerificationScreen()),
                GetPage(name: '/SignUpScreen', page: () => SignUpScreen()),
                GetPage(name: '/LoginScreen', page: () => LoginScreen()),
                GetPage(name: '/SplashScreen', page: () => SplashScreen()),
                GetPage(
                    name: '/VerificationScreen',
                    page: () => VerificationScreen()),
              ],
              theme: ThemeData(
                textTheme: Theme.of(context).textTheme.apply(
                      fontFamily: GoogleFonts.inter(fontWeight: FontWeight.w500)
                          .fontFamily,
                      fontSizeFactor: 1.0,
                    ),
              ),
            ));
      },
    );
  }
}
