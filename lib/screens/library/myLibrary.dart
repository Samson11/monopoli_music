import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:zap_sizer/zap_sizer.dart';

import '../../providers/user_provider.dart';
import '../../theme/text_style.dart';
import '../../widgets/user/avatar.dart';
import '../player/music_playing.dart';

class Mylibrary extends ConsumerStatefulWidget {
  const Mylibrary({super.key});

  @override
  ConsumerState<Mylibrary> createState() => _MylibraryState();
}

class Song {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  Song(
      {required this.title,
      required this.artist,
      required this.duration,
      required this.imagePath});
}

final List<Song> songs = [
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/burna.png',
  ),
  Song(
    title: 'Feel',
    artist: 'Davido',
    duration: '4:12',
    imagePath: 'assets/davido.png',
  ),
  Song(
    title: 'Wave',
    artist: 'Asake',
    duration: '2:58',
    imagePath: 'assets/asake.png',
  ),
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/city.png',
  ),
  Song(
    title: 'Wildest dream',
    artist: '21 Savage',
    duration: '4:12',
    imagePath: 'assets/savage.png',
  ),
  Song(
    title: 'Juju',
    artist: 'Asake',
    duration: '2:58',
    imagePath: 'assets/album1.png',
  ),
  Song(
    title: 'Higher',
    artist: 'Burna',
    duration: '3:45',
    imagePath: 'assets/album2.png',
  ),
  Song(
    title: 'Feel',
    artist: 'Davido',
    duration: '4:12',
    imagePath: 'assets/album3.png',
  ),
];

class _MylibraryState extends ConsumerState<Mylibrary> {
  String selectedText = 'Playlist';
  final List<String> items = [
    'Playlist',
    'Liked Songs ',
    'Downloaded',
    'Shared'
  ];

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Library',
                  style: largeText(primaryWhite),
                ),
                UserAvatar(
                  user: user!,
                )
              ],
            ),
            SizedBox(
              width: 95.w,
              height: 10.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: 3.w,
                ),
                itemBuilder: (context, index) {
                  bool isSelected = items[index] == selectedText;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedText = items[index];
                      });
                    },
                    child: Chip(
                      backgroundColor: isSelected ? primaryWhite : primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      label: Text(
                        items[index],
                        style: mediumBold(
                            isSelected ? primaryBlack : primaryWhite),
                      ),
                    ),
                  );
                },
              ),
            ),
            GradientText(
              selectedText,
              style: TextStyle(
                fontSize: 25.0,
              ),
              colors: [purple, primaryWhite],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final song = songs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => MusicPlayerPage(
                            //       imagePath: 'assets/burnaplay.png',
                            //       musicTitle: 'Higher',
                            //       artistName: 'Burna Boy',
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        song.imagePath,
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          song.title,
                                          style: mediumBold(primaryWhite),
                                        ),
                                        Text(
                                          song.artist,
                                          style: smallText(grey),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      _showSongDetails(context, song);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.ellipsis,
                                      color: primaryWhite,
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSongDetails(BuildContext context, Song song) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          height: height * 0.6,
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              song.imagePath,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                style: mediumBold(primaryWhite),
                              ),
                              Text(
                                song.artist,
                                style: smallText(grey),
                              )
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: primaryWhite,
                          ))
                    ],
                  ),
                  Divider(
                    color: grey,
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.playlist_add,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Add to playlist',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Remove from library',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.download_for_offline_outlined,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Download',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.ios_share,
                          color: primaryWhite,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Share',
                          style: mediumBold(primaryWhite),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
