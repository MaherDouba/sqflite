import 'package:ex_sqflite/home_page.dart';
import 'package:ex_sqflite/sqlite_db.dart';
import 'package:flutter/material.dart';

class EditNotes extends StatefulWidget {
  EditNotes({Key? key, this.note, this.title, this.id, this.color})
      : super(key: key);
  final note;
  final title;
  final color;
  final id;

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Notes'),
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
                        int response = await sqlDb.updateData('''  
                            UPDATE notes SET 
                             note =    "${note.text}" ,
                            titlel =   "${title.text}" ,
                             color =   "${color.text}"
                             WHERE id = ${widget.id}
                       ''');
                        // print("respo=================");
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => home_page()),
                              (route) => false);
                        }
                      },
                      child: Text('Edite note'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
