import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationIconController1;

  late AudioCache audioCache;

  late AudioPlayer audioPlayer;

  Duration _duration = new Duration();

  Duration _position = new Duration();

  Duration _slider = new Duration(seconds: 0);

  double? durationvalue;

  bool issongplaying = false;

  void initState() {
    super.initState();
    _position = _slider;
    _animationIconController1 = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
      reverseDuration: Duration(milliseconds: 750),
    );
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onDurationChanged.listen(
      (d) => setState(
        () {
          _duration = d;
        },
      ),
    );

    audioPlayer.onAudioPositionChanged.listen(
      (p) => setState(
        () {
          _position = p;
        },
      ),
    );
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);

    audioPlayer.seek(newDuration);
    print(
        "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: New duration $newDuration");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(0.55),
          image: DecorationImage(
            image: NetworkImage("https://wallpapercave.com/wp/wp3334914.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              width: (MediaQuery.of(context).size.width),
              height: (MediaQuery.of(context).size.height),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image(
                        image: NetworkImage(
                            "https://wallpapercave.com/wp/wp3334914.png"),
                        width: (MediaQuery.of(context).size.width) - 200,
                        height: (MediaQuery.of(context).size.width) - 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${_position}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Slider(
                          activeColor: Colors.white,
                          inactiveColor: Colors.grey,
                          value: _position.inSeconds.toDouble(),
                          max: _duration.inSeconds.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              seekToSecond(value.toInt());
                              value = value;
                            });
                          },
                        ),
                        Text(
                          "$_duration",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (issongplaying) {
                                audioCache.play("music/music (4).mp3");
                                audioCache.play("music/music (3).mp3");
                                audioCache.play("music/music (2).mp3");
                                audioCache.play("music/music (1).mp3");
                              }
                            });
                          },
                          child: Icon(
                            Icons.navigate_before,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                if (!issongplaying) {
                                  audioCache.play("music/music (1).mp3");
                                  audioCache.play("music/music (2).mp3");
                                  audioCache.play("music/music (3).mp3");
                                  audioCache.play("music/music (4).mp3");
                                } else {
                                  audioPlayer.pause();
                                }
                                issongplaying
                                    ? _animationIconController1.reverse()
                                    : _animationIconController1.forward();
                                issongplaying = !issongplaying;
                              },
                            );
                          },
                          child: ClipOval(
                            child: Container(
                              color: Colors.pink[600],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedIcon(
                                  icon: AnimatedIcons.play_pause,
                                  size: 55,
                                  progress: _animationIconController1,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (issongplaying) {
                                audioCache.play("music/music (1).mp3");
                                audioCache.play("music/music (2).mp3");
                                audioCache.play("music/music (3).mp3");
                                audioCache.play("music/music (4).mp3");
                              }
                            });
                          },
                          child: Icon(
                            Icons.navigate_next,
                            size: 55,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
