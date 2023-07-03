import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivedatabase/box/boxes.dart';
import 'package:hivedatabase/models/notes_model.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:

    ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_){
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context,index)
              {
                return Card(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].title.toString()),
                          Spacer(),


                          InkWell(
                              onTap: (){
_editdialog(data[index], data[index].title.toString(), data[index].description.toString());
                              },
                              child: Icon(Icons.edit)),





                          SizedBox(width: 20,),
                          InkWell(
                              onTap: (){
                                delete(data[index]);
                              },
                              child: Icon(Icons.delete,color: Colors.red,)),
                        ],
                      ),
                      Text(data[index].description.toString()),
                    ],),
                ),);
              }
          );
        }
    ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          _showdialog();
        },
        child: Icon(Icons.add),
      ),

    );
  }

/*  Future<void> _showdialog() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)

        {
          return AlertDialog(

            title: Text("Caller Id"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Text("Name: Govind"),
                  SizedBox(height: 20,),
               Text("Phone:  9777887733")
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),
              TextButton(onPressed: (){}, child: Text("Add")),
            ],

          );
        }
    );
  }*/


void delete (NotesModel notesModel)async
{
   await notesModel.delete();
}

  Future<void> _editdialog(NotesModel notesModel,String title,String description) async{

  titlecontroller.text =title;
  descriptioncontroller.text= description;


    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)

        {
          return AlertDialog(

            title: Text("Edit Notes"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titlecontroller,
                    decoration:InputDecoration(
                        hintText:'Enter title',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptioncontroller,
                    decoration:InputDecoration(
                        hintText:'Enter description',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),


              TextButton(onPressed: (){



                notesModel.title=titlecontroller.text.toString();
                notesModel.description=descriptioncontroller.text.toString();
                notesModel.save();
                titlecontroller.clear();
                descriptioncontroller.clear();

                Navigator.pop(context);


              },
                  child: Text("Edit")),
            ],

          );
        }
    );
  }







  Future<void> _showdialog() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)

        {
          return AlertDialog(

            title: Text("Add Notes"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titlecontroller,
                    decoration:InputDecoration(
                        hintText:'Enter title',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptioncontroller,
                    decoration:InputDecoration(
                        hintText:'Enter description',
                        border: OutlineInputBorder()
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel")),


              TextButton(onPressed: (){

                final data = NotesModel(title: titlecontroller.text, description: descriptioncontroller.text);
                final box = Boxes.getData();
                box.add(data);
                print(box.get(0));
                print(box);
                data.save();
                titlecontroller.clear();
                descriptioncontroller.clear();
                Navigator.pop(context);


              },
                  child: Text("Add")),
            ],

          );
        }
    );
  }
}
