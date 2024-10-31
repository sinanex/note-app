import 'package:flutter/material.dart';
import 'package:note_app/functions.dart/functions.dart';
import 'package:note_app/model/model.dart';

class EditPage extends StatefulWidget {
  String? title;
  String? note;
  int index;

  EditPage({
    required this.title,
    required this.note,
    required this.index,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}
   TextEditingController titleCtrl =TextEditingController();
   TextEditingController noteCrtl = TextEditingController();
class _EditPageState extends State<EditPage> {
  @override
  void initState(){
    super.initState();
    titleCtrl = TextEditingController(text: widget.title);
    noteCrtl = TextEditingController(text: widget.note);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.add_alert_outlined),
          SizedBox(width: 20,),
          Icon(Icons.archive_outlined),
          SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [ Column(
            children: [
              const SizedBox(height: 30,),
              TextField(
                controller: titleCtrl,
                style: const TextStyle(
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                ),
              ),
              TextField(
                controller: noteCrtl,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                ),
              ),
            ],
          
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  IconButton(onPressed: (){
                   
                  }, icon: const Icon(Icons.add_box_outlined)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.palette_outlined)),
                  const Icon(Icons.format_color_text,color: Colors.grey,),
                  const Spacer(),
                  const Text("Edited just now",style: TextStyle(fontSize: 10),),
                 const SizedBox(width: 100,),
                 IconButton(onPressed: (){
                  submitBtn(context);
                 }, icon: const Icon(Icons.check)),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert)),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
  
  void submitBtn(BuildContext context) {
    final title = titleCtrl.text.trim();
    final note = noteCrtl.text.trim();

    if(title.isEmpty||note.isEmpty){
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Title or Note is Empty")));
    }else{
      final editData = NoteData(
        title: title, note: note);
      editdata(widget.index, editData);
      Navigator.pop(context);
    }
  }

}