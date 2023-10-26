import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_videoplayer/meedu_player.dart';
import 'package:universal_platform/universal_platform.dart';

class BasicExamplePage extends StatefulWidget {
  const BasicExamplePage({Key? key}) : super(key: key);

  @override
  State<BasicExamplePage> createState() => _BasicExamplePageState();
}

class _BasicExamplePageState extends State<BasicExamplePage> {
  final _meeduPlayerController = MeeduPlayerController(
    controlsStyle: ControlsStyle.primary,
    // enabledButtons: const EnabledButtons(pip: true),
    // enabledControls: const EnabledControls(doubleTapToSeek: false),
    // pipEnabled: true,
    // header: header
  );

  StreamSubscription? _playerEventSubs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  void dispose() {
    _playerEventSubs?.cancel();
    _meeduPlayerController.dispose();
    super.dispose();
  }

  _init() async {
    await _meeduPlayerController.setDataSource(
        DataSource(
          type: DataSourceType.network,
          source:
              "https://movietrailers.apple.com/movies/paramount/the-spongebob-movie-sponge-on-the-run/the-spongebob-movie-sponge-on-the-run-big-game_h720p.mov",
        ),
        autoplay: true,
        looping: false);
  }

  Widget get header {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CupertinoButton(
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // close the fullscreen
              Navigator.maybePop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        top: UniversalPlatform.isDesktop ? false : true,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: MeeduVideoPlayer(
            controller: _meeduPlayerController,
            // videoOverlay: (context, controller, responsive) => Container(
            //   color: Colors.red,
            //   child: SizedBox(
            //     height: 50,
            //     width: 50,
            //   ),
            // ),
            header: (context, controller, responsive) => header,
          ),
        ),
      ),
    );
  }
}
