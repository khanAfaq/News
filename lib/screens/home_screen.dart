import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news/models/news_channels_headlines_model.dart';
import 'package:news/respository/news_respository.dart';

import '../models/categeries_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, routers, cnn, alJazera }

class _HomeScreenState extends State<HomeScreen> {
  NewsRepository newsRepository = NewsRepository();
  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    final formate = DateFormat('MMMM dd');
    String name = 'bbc-news';
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'categeriesscreen');
          },
          icon: const Icon(
            Icons.grid_view,
            size: 30.0,
            color: Colors.black54,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.grey[800],
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onSelected: (FilterList item) {
              if (FilterList.bbcNews.name == item.name) {
                name = 'bbc-news';
              }
              if (FilterList.aryNews.name == item.name) {
                name = 'ary-news';
              }
              if (FilterList.alJazera.name == item.name) {
                name = 'al-jazeera-english';
              }
              if (FilterList.cnn.name == item.name) {
                name = 'cnn';
              }
              setState(() {
                selectedMenu = item;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('ARY News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.cnn,
                child: Text('CNN News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.alJazera,
                child: Text('ALJAZERA News'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
                future: newsRepository.fetchNewsChannelHeadlineApi(name),
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
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * 0.9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
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
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    padding: const EdgeInsets.all(15.0),
                                    height: height * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                ),
                                              ),
                                              // Text formate
                                              Text(
                                                formate.format(dateTime),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'General News',
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<CategeriesNewsModel>(
                future: newsRepository.fetchCategeriesNewsApi('General'),
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
                        shrinkWrap: true,
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
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
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
        ],
      ),
    );
  }
}
