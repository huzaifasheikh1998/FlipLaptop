import 'package:app_fliplaptop/Apiserrvices/Services.dart';
import 'package:app_fliplaptop/Apiserrvices/loader.dart';
import 'package:app_fliplaptop/Apiserrvices/localStorage.dart';
import 'package:app_fliplaptop/Screens/StartNavigatorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeConnect extends StatefulWidget {
  const StripeConnect({Key? key}) : super(key: key);
  @override
  _StripeConnectState createState() => _StripeConnectState();
}

class _StripeConnectState extends State<StripeConnect> {
  late String selectedUrl;
  // final paymentCardController = Get.put(PaymentCardController());

  bool _canRedirect = true;
  RxBool _isLoading = true.obs;

  WebViewController? webController;

  @override
  void initState() {
    getStripeUrl();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _exitApp();
  }

  getStripeUrl() async {
    selectedUrl = await ApiServices().stripeConnect();
    webViewInit();
  }

  webViewInit() {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            print("printing urls " + url.toString());
            _redirect(url);
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');

            _isLoading.value = false;

            _redirect(url);
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(selectedUrl)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(selectedUrl))
      ..enableZoom(true);
  }

  Future<dynamic> orderConfirmedDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Material(
              type: MaterialType.transparency,
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.102.sw),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Wrap(
                    children: [
                      Container(
                        height: 0.026.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.done,
                          size: 0.079.sh,
                          color: Color.fromARGB(255, 14, 209, 14),
                        ),
                      ),
                      Container(
                        height: 0.016.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Congratulations!",
                          style: TextStyle(
                              fontSize: 24.spMin,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        height: 0.016.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Your stripe account has been \nconnected",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19.spMin, color: Color(0xff283891)),
                        ),
                      ),
                      Container(
                        height: 0.026.sh,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {
                              // ApiServices.getProfile();
                              Get.offAll(() => StartAppScreen());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff283891)),
                            child: Text(
                              "Done",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                      Container(
                        height: 0.026.sh,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    double res_width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _exitApp(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: res_width,
              child: Obx(
                () => Stack(
                  children: [
                    _isLoading.value
                        ? Loader.spinkit
                        : WebViewWidget(controller: webController!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) async {
    print("redirect url : " + url);
    if (_canRedirect) {
      bool _isSuccess = url.contains('status=true');
      bool _isFailed = url.contains('status=false');
      if (_isSuccess || _isFailed) {
        _canRedirect = false;
      }
      if (_isSuccess) {
        // prefs. memberShip = true;
        print("Success");
        LocalStorage.saveJson(
            key: LocalStorageKeys.stripeConnected, value: "true");

        Navigator.pop(context);
        orderConfirmedDialog(context);
        // Get.to(PaymentRecieved());
        // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'success'));
      } else if (_isFailed) {
        print("Failed");
        Navigator.pop(context);
        // Get.offNamed(RouteHelper.getOrderSuccessRoute(widget.orderModel.id.toString(), 'fail'));
      } else {
        print("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp() async {
    if (await webController!.canGoBack()) {
      webController!.goBack();
      return Future.value(false);
    } else {
      print("app exited");

      return true;
    }
  }
}
