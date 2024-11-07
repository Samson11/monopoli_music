import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monopoli/services/auth.dart';
import 'package:monopoli/services/user.dart';
import 'package:monopoli/theme/text_style.dart';
import 'package:monopoli/widgets/lists/music_tile.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import '../../models/audio/index.dart';
import '../../models/audio/track.dart';

class Liked extends ConsumerWidget {
  const Liked({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    var user = AuthService.getUser();

    return PaginateFirestore(
      onEmpty: Center(
        child: Column(
          children: [
            Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('assets/empty.png'))),
            Text(
              'No song has been added to the playlist',
              style: smallText(Colors.grey),
            ),
          ],
        ),
      ),
      itemBuilderType: PaginateBuilderType.listView,
      query: UserService.getLikedSong(user!.uid),
      isLive: true,
      shrinkWrap: true,
      itemBuilder: (context, snapshots, index) {
        var snap = snapshots[index];
        var a = snap.get('audio');
        var t = snap.get('track');

        var track = Track.fromJson(t);
        var res = AudioApiResponse.fromJson(a);

        return MusicTile(
          audio: res,
          track: track,
          userId: user.uid,
          isDownloaded: snap.get('downloaded'),
          isShared: snap.get('shared'),
        );
      },
    );
  }
}
