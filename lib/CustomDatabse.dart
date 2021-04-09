import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class CustomData extends StatefulWidget {
CustomData({this.app});
final FirebaseApp app;
@override
_CustomDataState createState() => _CustomDataState();
}

class _CustomDataState extends State<CustomData> {
final referenceDatabase = FirebaseDatabase.instance;

final Moviename = 'MovieTitale';
final ActorsName ='ActorsName';

final MovieController = TextEditingController();
final ActorsController =TextEditingController();
DatabaseReference _movieRef,_actorRef;
@override
void initState()
{
final FirebaseDatabase database= FirebaseDatabase(app: widget.app);
_movieRef = database.reference().child('Movies');
_actorRef = database.reference().child('Actors');
super.initState();
}
@override
Widget build(BuildContext context) {
final ref = referenceDatabase.reference();
return Scaffold(
  appBar: AppBar(
    title: Text("Firebase DataBase"),
  ),
  body: SingleChildScrollView(
    child: Column(
      children: [
        Center(
          child: Container(
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Text(
                  Moviename,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: MovieController,
                  textAlign: TextAlign.center,
                ),
                Text(
                  ActorsName,
                  textAlign: TextAlign.center,
                  style:
                  TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: ActorsController,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15,),
                FlatButton(
                  color: Colors.white,
                  onPressed: () {
                    ref
                        .child('Movies')
                        .push()
                        .child(Moviename)
                        .set(MovieController.text)
                        .asStream();
                    MovieController.clear();
                    ActorsController.clear();
                  },
                  child: Text('Save movie'),
                  textColor: Colors.black,
                ),
                Flexible(
                    child: new FirebaseAnimatedList(
                      shrinkWrap: true,
                    query: _movieRef,
                        itemBuilder: (BuildContext context,
                DataSnapshot snapshot,
                Animation<double> animation,
                int index){
                      return new ListTile(
                        trailing: IconButton(icon: Icon(Icons.delete),onPressed: () =>
                          _movieRef.child(snapshot.key).remove(),),
                        title: Text(snapshot.value['MovieTitale']),
                        // subtitle: Text(snapshot.value['ActorsName']),
                      );
                })),
              ],
            ),
          ),
        )
      ],
    ),
  ),
);
}
}
