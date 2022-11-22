import 'package:audio_player/second.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<SongModel>> someName() async {
    List<SongModel> something = await _audioQuery.querySongs();
    return something;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Audio List"),),
      body: FutureBuilder(
        future: someName(),
        builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done){
          List<SongModel> songs = snapshot.data as List<SongModel>;
          return ListView.builder(itemCount: songs.length,itemBuilder: (context, index) {
            SongModel s = songs[index];
            return ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return second(songs,index);
                },));
              },
              title: Text("${s.title}"),
              subtitle: Text("${s.isMusic}"),
            );
          },);
        }
        else{
          return Center(child: CircularProgressIndicator(),);
        }
      },),
    );
  }
}
