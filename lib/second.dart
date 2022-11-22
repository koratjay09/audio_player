import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class second extends StatefulWidget {
  List<SongModel> songs;

  int index;
  second(this.songs,this.index);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {

  PageController pc=PageController();
  @override
  void initState() {
    pc=PageController(initialPage: widget.index);
  }

  Color iconcolor = Colors.black;
  bool iconbool = true;
  bool iconchang = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),
    body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: pc,
            itemCount: widget.songs.length,
            onPageChanged: (value) {
              print(value);
              widget.index=value;
              setState(() {});
            },
            itemBuilder: (context, index) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Container(alignment: Alignment.center,child: Text("${widget.songs[widget.index].title}",style: TextStyle(fontSize: 20)),height: 50,width: 300,color: Colors.transparent,)),
                  SizedBox(height: 5,),
                  Center(child: Container(alignment: Alignment.center,child: Text("${widget.index}",style: TextStyle(fontSize: 20)),height: 50,width: 300,color: Colors.transparent)),
                  SizedBox(height: 200,),
                ],
              ),
            );
          },),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GFIconButton(
                onPressed: (){
                  setState(() {});
                },
                color: Colors.transparent,
                icon: Icon(Icons.keyboard_arrow_left,size: 50,),
                alignment: Alignment.center,

              ),
              GFIconButton(
                onPressed: (){
                  pc.jumpToPage(widget.index);
                  widget.index--;
                  setState(() {});
                },
                color: Colors.transparent,
                icon: Icon(Icons.play_circle,size: 50,),
                alignment: Alignment.center,
              ),
              GFIconButton(
                onPressed: (){
                  pc.jumpToPage(widget.index);
                  widget.index++;
                  setState(() {});
                },
                color: Colors.transparent,
                icon: Icon(Icons.keyboard_arrow_right,size: 50,),
                alignment: Alignment.center,
              ),
            ],
          ),
        )
      ],
    )
    );
  }


}
