import 'package:app_fliplaptop/components/global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import '../Apiserrvices/app_url.dart';

class ImageGallery extends StatefulWidget {
  int ind;
  List data;
  ImageGallery({required this.data, required this.ind});
  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  List<String> imageList = [];

  Future addImage(data) async {
    print("<<<<<<<${data.length}");
    for (int i = 0; i < data.length; i++) {
      print(i);

      print(data[i].name);
      imageList.add(data[i].name.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    addImage(widget.data);
  }

  int _currentIndex = 0;

  // List<String> _images = [
  //   "http://zelektra.com/Admin/images_uploads/2.jpg",
  //   "https://images.unsplash.com/photo-1564754943164-e83c08469116?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8dmVydGljYWx8ZW58MHx8MHx8&w=1000&q=80",
  //   "https://images.unsplash.com/photo-1526512340740-9217d0159da9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmVydGljYWx8ZW58MHx8MHx8&w=1000&q=80",
  //   "http://zelektra.com/Admin/images_uploads/5.jpg"
  // ];

  @override
  Widget build(BuildContext context) {
    print(widget.data);
    final sized = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: Text('Image Gallery'),
      // ),
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child:
               Container(
              padding: const EdgeInsets.all(5),
              margin: EdgeInsets.only(left: 20.r),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, gradient: kbtngradient),
              child: SvgPicture.asset(
                'assets/Path 11.svg',
                width: 20,
              )),
              //  Container(
              //     margin: EdgeInsets.all(15),
              //     child: Image.asset(
              //       back,
              //       height: 25,
              //     )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CarouselSlider(
                  items: imageList.map((imageUrl) {
                    return CachedNetworkImage(
                      imageUrl: ImageUrls.kProduct +
                                      imageUrl,
                      // height: size.height * 0.12,
                      // width: size.height * 0.12,
                      fit: BoxFit.fitWidth,
                      placeholder: (context, url) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child:
                              Icon(Icons.image,color: Colors.black,size: 80,)
                          //      Image.asset(
                          //   building,
                          //   color: Colors.black,
                          //   height: 80,
                          //   width: 80,
                          // )
                          ),
                        ],
                      ),
                    );
                    // Container(
                    //   //  color: Colors.amber,
                    //   width: sized.width * 1,
                    //   // height: sized.height*0.7,
                    //   // margin: EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: ClipRRect(
                    //           // borderRadius: BorderRadius.circular(8.0),
                    //           child:
                    //               Image.network(imageUrl, fit: BoxFit.fitWidth),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: sized.height * 0.9,
                    autoPlay: false,
                    aspectRatio: 1 / 1,
                    // enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    initialPage: widget.ind,
                    onPageChanged: (index, reason) {
                      setState(() {
                        widget.ind = index;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicators(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];

    for (int i = 0; i < imageList.length; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.ind == i ? kprimaryColor : Colors.grey,
          ),
        ),
      );
    }

    return indicators;
  }
}