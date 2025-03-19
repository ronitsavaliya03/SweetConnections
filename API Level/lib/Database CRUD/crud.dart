import 'package:flutter/material.dart';
import 'package:new_flutter_labs/Database%20CRUD/database.dart';

class UIForDatabase extends StatefulWidget {
  const UIForDatabase({super.key});

  @override
  State<UIForDatabase> createState() => _UIForDatabaseState();
}

class _UIForDatabaseState extends State<UIForDatabase> {
  final MyDatabase database= MyDatabase.instance;

  final TextEditingController titleController= TextEditingController();
  final TextEditingController descriptionController= TextEditingController();

  List<Map<String, dynamic>> notes=[];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshNotes();
  }
  
  void _refreshNotes() async {
    final data= await database.readAllNotes();
    setState(() {
      notes=data;
    });
  }
  
  void _addNote() async{
    final note={
      'title': titleController.text.toString(),
      'description': descriptionController.text.toString()
    };
    
    await database.create(note);
    titleController.clear();
    descriptionController.clear();
    _refreshNotes();
  }
  
  void _updateNote(Map<String, dynamic> note) async{
    final updatedNote={
      'id': note['id'],
      'title': titleController.text.toString(),
      'description': descriptionController.text.toString()
    };
    
    await database.update(updatedNote);
    titleController.clear();
    descriptionController.clear();
    _refreshNotes();
  }
  
  void _deleteNote(int id) async{
    await database.delete(id);
    _refreshNotes();
  }
  
  void _showForm(Map<String, dynamic>? note){
    if(note!=null){
      titleController.text=note['title'];
      descriptionController.text=note['description'];
    }else{
      titleController.clear();
      descriptionController.clear();
    }
    
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder:(_)=>Padding(padding:EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Pushes BottomSheet above keyboard
          left: 20,
          right: 20,
          top: 20,
        ), child: Column(
          mainAxisSize: MainAxisSize.min, children: [
          TextField(controller: titleController, decoration:  InputDecoration(labelText: "Title"),),
          TextField(controller: descriptionController, decoration:  InputDecoration(labelText: "Description"),),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            if(note!=null){
              _updateNote(note);
            }
            else{
              _addNote();
            }
            Navigator.of(context).pop();
          }, child: Text(note!=null ? 'Update Note' : 'Add Note'))
        ],),)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite CRUD"),),
      body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index){
            final note=notes[index];
            
            return Card(
              child: ListTile(
                title: Text(note['title']),
                subtitle: Text(note['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()=>_showForm(note), icon: Icon(Icons.edit)),
                    IconButton(onPressed: ()=>_deleteNote(note['id']), icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            );
      }),
      floatingActionButton: FloatingActionButton(onPressed: ()=>_showForm(null), child: Icon(Icons.add),),
    );
  }
}
