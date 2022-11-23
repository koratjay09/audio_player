import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class second extends StatefulWidget {
  List<SongModel> songs;

  int index;

  second(this.songs, this.index);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  PageController pc = PageController();
  Color iconcolor = Colors.black;
  bool iconbool = true;
  bool iconchang = true;

  final player = AudioPlayer();

  @override
  void initState() {
    pc = PageController(initialPage: widget.index);
    player.onPositionChanged.listen((Duration p) {
      print('Current position: $p');
    });
  }

  bool play = false;
  double current_time = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pc,
                itemCount: widget.songs.length,
                onPageChanged: (value) {
                  print(value);
                  widget.index = value;
                  setState(() {});
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Container(
                          alignment: Alignment.center,
                          child: Text("${widget.songs[widget.index].title}",
                              style: TextStyle(fontSize: 20)),
                          height: 50,
                          width: 300,
                          color: Colors.transparent,
                        )),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                            child: Container(
                                alignment: Alignment.center,
                                child: Text("${widget.index}",
                                    style: TextStyle(fontSize: 20)),
                                height: 50,
                                width: 300,
                                color: Colors.transparent)),
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Slider(
              value: current_time,
              onChanged: (value) async {
                await player.seek(Duration(milliseconds: value.toInt()));
              },
              max: 0,
              min: widget.songs[widget.index].duration!.toDouble(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GFIconButton(
                    onPressed: () {
                      pc.jumpToPage(widget.index);
                      widget.index--;
                      setState(() {});
                    },
                    color: Colors.transparent,
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      size: 50,
                    ),
                    alignment: Alignment.center,
                  ),
                  GFIconButton(
                    onPressed: () async {
                      if (play) {
                        await player.pause();
                      } else {
                        String local = widget.songs[widget.index].data;
                        await player.play(DeviceFileSource(local));
                      }
                    },
                    color: Colors.transparent,
                    icon: Icon(
                      Icons.play_circle,
                      size: 50,
                    ),
                    alignment: Alignment.center,
                  ),
                  GFIconButton(
                    onPressed: () {
                      pc.jumpToPage(widget.index);
                      widget.index++;
                      setState(() {});
                    },
                    color: Colors.transparent,
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      size: 50,
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
