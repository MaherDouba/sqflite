import 'package:ex_sqflite/home_page.dart';
import 'package:ex_sqflite/sqlite_db.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: note,
                      decoration: InputDecoration(hintText: "note"),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(hintText: "tiltle"),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: InputDecoration(hintText: "color"),
                    ),
                    Container(height: 10),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        int response = await sqlDb.insertData(
                            '''INSERT INTO notes ('note' , 'title' , 'color')
                               VALUES ("${note.text}" ," ${title.text}" ,"${color.text}")
                        ''');
                        // print("respo=================");
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => home_page()),
                              (route) => false);
                        }
                      },
                      child: Text('Add note'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
