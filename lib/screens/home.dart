import 'package:flutter/material.dart';
import 'package:note_app/functions.dart/functions.dart';
import 'package:note_app/model/model.dart';
import 'package:note_app/screens/add.dart';
import 'package:note_app/screens/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search = '';
  List<NoteData> searchList = [];

  void searchUpdate() {
    searchList = dataNotifier.value
        .where((serchdata) =>
            serchdata.title!.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(height: 50),
            icontext(icon: const Icon(Icons.bubble_chart), text: 'Notes'),
            icontext(
                text: 'Reminders',
                icon: const Icon(Icons.notifications_outlined)),
            icontext(text: 'Create new label', icon: const Icon(Icons.add)),
            icontext(text: 'Archive', icon: const Icon(Icons.archive_outlined)),
            icontext(
                text: 'Deleted',
                icon: const Icon(Icons.delete_forever_outlined)),
            icontext(
                text: 'Settings', icon: const Icon(Icons.settings_outlined)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPage()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        flexibleSpace: Column(
          children: [
            const SizedBox(height: 52),
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 230,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          search = value;
                          searchUpdate();
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search your notes',
                          hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w300)),
                    ),
                  ),
                  const Icon(
                    Icons.view_agenda_outlined,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 20),
                  const CircleAvatar(child: Icon(Icons.account_circle_outlined,size: 35,),),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: [
      
        ValueListenableBuilder(
          valueListenable: dataNotifier,
          builder: (context, value, child) {
            var displayList = search.isNotEmpty ? searchList : value;

            if (displayList.isEmpty) {
              return const Center(child: Text('No notes available'));
            }

            return ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
              final data = value[index];
              return ListTile(
                trailing: IconButton(onPressed: (){
                  deteteBtn(index);
                }, icon: Icon(Icons.delete)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage(title: data.title, note: data.note, index: index)));
                },
                title: Text(data.title!),
              subtitle: Text(data.note!),);
              

            },);

          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: 60,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.check_box_outlined, color: Colors.black),
                Icon(Icons.brush_outlined, color: Colors.black),
                Icon(Icons.mic_outlined, color: Colors.black),
                Icon(Icons.image_outlined, color: Colors.black),
                SizedBox(width: 200),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void deteteBtn(int index) {
    deleteData(index);
  }
}

Widget icontext({required String text, required Widget icon}) {
  return ListTile(
    title: Text(text),
    leading: icon,
  );
}
