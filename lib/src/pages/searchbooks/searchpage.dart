import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../models/book.dart';
import '../../widgets/downloadeditem.dart';
import '../../widgets/downloadsgroup.dart';
import '../bookdetails/bookdetails.dart';
import '../navigations/home/logic.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // final logic = Get.put(SearchConsultantLogic());

  // final state = Get.find<SearchConsultantLogic>().state;

  TextEditingController searchController = TextEditingController();
  final homeController = Get.put(HomeLogic());

  final _filteredBooks = RxList<BookModel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///---search-field
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextFormField(
                        controller: searchController,
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.fromSTEB(
                              25.w, 15.h, 25.w, 15.h),
                          hintText: 'Search Books Here....',
                          hintStyle:
                              TextStyle(fontSize: 16.sp, color: Colors.black),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide:
                                  const BorderSide(color: Colors.transparent)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.grey)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: const BorderSide(color: Colors.red)),
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {}
                        },
                        onChanged: (value) {
                          if (value.isEmpty) {
                            _filteredBooks.clear();
                          } else {
                            _filteredBooks.value = homeController.allBooks
                                .where((book) => book.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),

                    homeController.allcategoriesLoader.value
                        ? SkeletonLoader(
                            period: const Duration(seconds: 2),
                            highlightColor: Colors.grey,
                            direction: SkeletonDirection.ltr,
                            builder: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Wrap(
                                    children: List.generate(6, (index) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.w, 0.h, 15.w, 15.h),
                                        child: Container(
                                          height: 109.h,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: -2,
                                                  blurRadius: 15,
                                                  // offset: Offset(1,5)
                                                )
                                              ]),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ))
                        : SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Wrap(children: [
                                    if (_filteredBooks.isEmpty &&
                                        searchController.text != "")
                                      Center(
                                        child: Text(
                                          "Oops! We couldn't find any books matching your search for ${searchController.text}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ...List.generate(_filteredBooks.length,
                                        (index) {
                                      BookModel book = _filteredBooks[index];
                                      if (book.name.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase())) {
                                        return DownloadsGroup(
                                          items: [
                                            DownloadedItem(
                                              onTap: () {
                                                Get.to(BookDetails(
                                                    bookModel: homeController
                                                        .filteredBooks[index]));
                                              },
                                              title: book.name,
                                              author: book.author,
                                              imageUrl: book.thumbnailUrl,
                                            ),
                                          ],
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    }),
                                  ]),
                                ),
                                SizedBox(
                                  height: 25.h,
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
