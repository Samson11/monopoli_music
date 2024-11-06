import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:monopoli/providers/spotify.dart';
import 'package:monopoli/screens/albums/index.dart';
import 'package:monopoli/screens/discover/album.dart';
import 'package:monopoli/screens/discover/hot_releases.dart';
import 'package:monopoli/screens/discover/top_music.dart';
import 'package:monopoli/screens/player/music_playing.dart';
import 'package:monopoli/services/spotify.dart';
import 'package:monopoli/theme/colors.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/sheet/player.dart';
import 'package:monopoli/widgets/user/avatar.dart';
import 'package:zap_sizer/zap_sizer.dart';
import '../../../providers/user_provider.dart';

class Discover extends ConsumerStatefulWidget {
  const Discover({super.key});

  @override
  ConsumerState<Discover> createState() => _DiscoverState();
}

class Song {
  final String title;
  final String artist;
  final String duration;
  final String imagePath;

  Song({
    required this.title,
    required this.artist,
    required this.duration,
    required this.imagePath,
  });
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

class _DiscoverState extends ConsumerState<Discover>
    with TickerProviderStateMixin {
  var ids = [
    '6lI21W76LD0S3vC55GrfSS',
    '5Af7bJAiAKBCazSQU8BOsD',
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    var user = ref.watch(userProvider);

    if (user == null) {
      return const SizedBox.shrink();
    }

    var t = ref.watch(spotifyToken);

    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                    'Discover',
                    style: largeText(primaryWhite),
                  ),
                  UserAvatar(
                    user: user,
                  ),
                ],
              ),
              // const FeaturedSongs(),
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    if (t != null) ...[
                      TopMusic(
                        token: t,
                      ),
                    ],
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: height * 0.5,
                      width: width * 0.75,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF475B47), Color(0xff494F51)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hot Releases',
                                    style: mediumSemiBold(primaryWhite),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'view all',
                                      style: mediumBold(primaryWhite),
                                    ),
                                  ),
                                ],
                              ),
                              if (t != null) ...[
                                HotReleases(
                                  token: t,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Trending Album',
                style: mediumSemiBold(primaryWhite),
              ),
              if (t != null) ...[
                Albums(
                  token: t,
                  ids: ids,
                )
              ]
              // AlbumListScreen(),
            ],
          ),
        ),
      ),
    );
  }

  void _showSongDetails(BuildContext context, Song song) {
    showModalBottomSheet(
      backgroundColor: Colors.grey[900],
      context: context,
      shape: const RoundedRectangleBorder(
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
                        ),
                      ),
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
