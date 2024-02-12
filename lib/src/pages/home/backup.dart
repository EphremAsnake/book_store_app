// import 'package:book_store/src/utils/constants/colors.dart';
// import 'package:book_store/src/utils/constants/urls.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:resize/resize.dart';
// import 'package:skeleton_loader/skeleton_loader.dart';

// import '../../services/apicalls.dart';
// import '../../services/repos/functions.dart';
// import 'logic.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // List<String> categories = [
//   //   'All',
//   //   'New',
//   //   'Novel',
//   //   'Kids',
//   //   'Adventure',
//   //   'Design',
//   //   'Romantic'
//   // ];
//   // int _currentIndex = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getMethod(context, ApiUrls.categories, getCategoriesList);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final HomeLogic controller = Get.find();
//     return Obx(() => DefaultTabController(
//           length: controller.categories.length,
//           child: Scaffold(
//               backgroundColor: Colors.white,
//               body: SingleChildScrollView(
//                   child: Column(
//                 children: [
//                   Container(
//                       decoration: const BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.only(
//                               bottomRight: Radius.circular(50))),
//                       height: MediaQuery.of(context).size.height * 0.35,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: MediaQuery.sizeOf(context).height * 0.1.h,
//                             ),
//                             Text(
//                               'The Best',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 25.h,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text('Books For You!',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25.h,
//                                     fontWeight: FontWeight.bold)),
//                             SizedBox(
//                               height:
//                                   MediaQuery.sizeOf(context).height * 0.02.h,
//                             ),
//                             Text('Search for your favorite books',
//                                 style: TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 20.h,
//                                     fontWeight: FontWeight.w300)),
//                             //!Search Field
//                             Padding(
//                               padding: EdgeInsets.only(right: 20.0, top: 20.h),
//                               child: TextFormField(
//                                 onTap: () {
//                                   // Get.toNamed(
//                                   //     PageRoutes.searchConsultant);
//                                 },
//                                 readOnly: true,
//                                 decoration: InputDecoration(
//                                   contentPadding:
//                                       const EdgeInsetsDirectional.fromSTEB(
//                                           0, 0, 20, 20),
//                                   prefixIcon: const Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(
//                                         Icons.search,
//                                         color: Colors.red,
//                                       )
//                                     ],
//                                   ),
//                                   hintText: "Search here",
//                                   hintStyle: const TextStyle(
//                                       fontSize: 14, color: Color(0xffA3A7AA)),
//                                   fillColor: Colors.white,
//                                   filled: true,
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.transparent)),
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.transparent)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide: const BorderSide(
//                                           color: Colors.white)),
//                                   errorBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15),
//                                       borderSide:
//                                           const BorderSide(color: Colors.red)),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )),
//                   controller.categories.isNotEmpty
//                       ? Column(
//                           children: [
//                             TabBar(
//                               isScrollable: true,
//                               physics: const BouncingScrollPhysics(),
//                               tabs: controller.categories.map((category) {
//                                 return Tab(
//                                   text: category,
//                                 );
//                               }).toList(),
//                               labelColor: Colors.black,
//                               unselectedLabelColor: Colors.grey,
//                               indicatorColor: Colors.red,
//                             ),
//                             // TabBarView
//                             SizedBox(
//                               height: MediaQuery.of(context).size.height,
//                               child: TabBarView(
//                                 children:
//                                     controller.categories.map((category) {
//                                   return Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal:20.0),
//                                     child: GridView.builder(
//                                       //shrinkWrap: true,
//                                       //physics: const NeverScrollableScrollPhysics(),
//                                       gridDelegate:
//                                           const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount:
//                                             2, // Number of columns in the grid
//                                         childAspectRatio:
//                                             0.7, // Width to height ratio of each grid item
//                                         crossAxisSpacing:
//                                             10, // Spacing between columns
//                                         mainAxisSpacing:
//                                             10, // Spacing between rows
//                                       ),
//                                       itemCount: controller.categories
//                                           .length, 
//                                       itemBuilder: (context, index) {
//                                         final book = controller.categories[
//                                             index]; 
                                    
//                                         return Container(
//                                           decoration: BoxDecoration(
//                                             color: AppColors.primaryColor,
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               book[index],
//                                               style: const TextStyle(
//                                                   fontSize: 16.0),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 }).toList(),
//                               ),
//                             )
//                           ],
//                         )
//                       : SkeletonLoader(
//                           period: const Duration(seconds: 2),
//                           highlightColor: Colors.grey,
//                           direction: SkeletonDirection.ltr,
//                           builder: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Padding(
//                                   padding: EdgeInsetsDirectional.fromSTEB(
//                                       20, 10.h, 20, 0),
//                                   child: Container(
//                                     height: 45,
//                                     width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius:
//                                             BorderRadius.circular(8.r)),
//                                   )),
//                               SizedBox(
//                                 height: 25.h,
//                               ),

//                               SizedBox(
//                                 height: 630.h,
//                                 child: ListView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     itemCount: 3,
//                                     itemBuilder: (context, index) {
//                                       return Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 10),
//                                             child: Container(
//                                               height: 180.h,
//                                               width: 150.w,
//                                               decoration: BoxDecoration(
//                                                   color: AppColors.primaryColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 10),
//                                             child: Container(
//                                               height: 180.h,
//                                               width: 150.w,
//                                               decoration: BoxDecoration(
//                                                   color: AppColors.primaryColor,
//                                                   borderRadius:
//                                                       BorderRadius.circular(8)),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                               )
//                               // Center(
//                               //   child: Wrap(

//                               //     children: List.generate(6, (index) {
//                               //       return Padding(
//                               //         padding:
//                               //             EdgeInsets.fromLTRB(0, 0, 11.w, 12.h),
//                               //         child: Container(
//                               //           height: 123.h,
//                               //           width: 106.w,
//                               //           decoration: BoxDecoration(
//                               //               color: AppColors.primaryColor,
//                               //               borderRadius:
//                               //                   BorderRadius.circular(8)),
//                               //         ),
//                               //       );
//                               //     }),
//                               //   ),
//                               // )
//                             ],
//                           ))
//                 ],
//               ))),
//         ));
//   }
// }
