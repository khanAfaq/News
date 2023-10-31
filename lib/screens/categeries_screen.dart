import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news/respository/news_respository.dart';
import 'package:intl/intl.dart';

import '../models/categeries_news_model.dart';

class CategeriesScreen extends StatefulWidget {
  const CategeriesScreen({super.key});

  @override
  State<CategeriesScreen> createState() => _CategeriesScreenState();
}

class _CategeriesScreenState extends State<CategeriesScreen> {
  NewsRepository newsRepository = NewsRepository();

  String categoryName = 'General';
  List<String> catogeriesList = [
    'General',
    'Entertaiment',
    'Health',
    'Sports',
    'Buisness',
    'Technology'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final formate = DateFormat('MMMM dd');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/homescreen');
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.grey[800],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              height: 50.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: catogeriesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        categoryName = catogeriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: categoryName == catogeriesList[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Center(
                              child: Text(
                                catogeriesList[index].toString(),
                                style: GoogleFonts.poppins(
                                    fontSize: 14.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: FutureBuilder<CategeriesNewsModel>(
                  future: newsRepository.fetchCategeriesNewsApi(categoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                          size: 60.0,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Container(
                                        child: const SpinKitFadingCircle(
                                          color: Colors.grey,
                                          size: 50.0,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const Spacer(),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15.0,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 50.0,
                                                ),
                                                Text(
                                                  formate.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.blue,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            ),
            // Expanded(
            //   child: FutureBuilder<CategeriesNewsModel>(
            //       future: newsRepository.fetchCategeriesNewsApi(categoryName),
            //       builder: (BuildContext context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return const Center(
            //             child: SpinKitCircle(
            //               color: Colors.blue,
            //               size: 60.0,
            //             ),
            //           );
            //         } else {
            //           return ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: snapshot.data!.articles!.length,
            //               itemBuilder: (context, index) {
            //                 DateTime dateTime = DateTime.parse(snapshot
            //                     .data!.articles![index].publishedAt
            //                     .toString());
            //                 return Padding(
            //                   padding: const EdgeInsets.only(bottom: 15.0),
            //                   child: Row(
            //                     children: [
            //                       ClipRRect(
            //                         borderRadius: BorderRadius.circular(15.0),
            //                         child: CachedNetworkImage(
            //                           imageUrl: snapshot
            //                               .data!.articles![index].urlToImage
            //                               .toString(),
            //                           fit: BoxFit.cover,
            //                           height: height * .18,
            //                           width: width * .3,
            //                           placeholder: (context, url) => Container(
            //                             child: const Center(
            //                               child: SpinKitFadingCircle(
            //                                 color: Colors.grey,
            //                                 size: 50.0,
            //                               ),
            //                             ),
            //                           ),
            //                           errorWidget: (context, url, error) =>
            //                               const Icon(
            //                             Icons.error_outline,
            //                             color: Colors.red,
            //                           ),
            //                         ),
            //                       ),
            //                       Expanded(
            //                         child: Container(
            //                           height: height * .18,
            //                           padding:
            //                               const EdgeInsets.only(left: 15.0),
            //                           child: Column(
            //                             children: [
            //                               Text(
            //                                 snapshot
            //                                     .data!.articles![index].title
            //                                     .toString(),
            //                                 maxLines: 3,
            //                                 style: GoogleFonts.poppins(
            //                                   fontSize: 15.0,
            //                                   color: Colors.black54,
            //                                   fontWeight: FontWeight.w700,
            //                                 ),
            //                               ),
            //                               const Spacer(),
            //                               Row(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.spaceBetween,
            //                                 children: [
            //                                   Text(
            //                                     formate.format(dateTime),
            //                                     semanticsLabel: snapshot
            //                                         .data!
            //                                         .articles![index]
            //                                         .source!
            //                                         .name
            //                                         .toString(),
            //                                     style: GoogleFonts.poppins(
            //                                       fontSize: 15.0,
            //                                       color: Colors.blue,
            //                                       fontWeight: FontWeight.w500,
            //                                     ),
            //                                   ),
            //                                 ],
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               });
            //         }
            //       }),
            // ),
          ],
        ),
      ),
    );
  }
}

/*
else {
                      return ListView.builder(
                          //scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15.0),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].title
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Container(
                                        child: const SpinKitFadingCircle(
                                          color: Colors.grey,
                                          size: 50.0,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
*/