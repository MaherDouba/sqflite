import 'package:ex_sqflite/editnotes.dart';
import 'package:ex_sqflite/sqlite_db.dart';

import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  bool loading = true;
  SqlDb sqlDb = SqlDb();
  List notes = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    loading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('addnotes');
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                await sqlDb.mydeletedatabase();
              },
              child: Text('delet database'),
            ),
            ListView.builder(
                itemCount: notes.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Card(
                    child: ListTile(
                      title: Text('${notes[i]['title']}'),
                      subtitle: Text('${notes[i]['note']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            IconButton(
                          onPressed: () async {
                            int response = await sqlDb.deleteData(
                                "DELETE FROM notes WHERE id = ${notes[i]['id']}");
                            if (response > 0) {
                             notes.removeWhere((element) => element['id'] == notes[i]['id']);
                             setState(() {
                               
                             });
                            }
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                           IconButton(
                          onPressed: () async {
                           Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditNotes(
                              color: notes[i]['color'],
                              note: notes[i]['note'],
                              title: notes[i]['title'],
                              id: notes[i]['id'],
                            ))
                           );
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          )),
                        ],
                      )
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
