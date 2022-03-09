import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sqlite/database/sqlite.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> _notesData = [];

  void getAllItems() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _notesData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getAllItems();
  }

  addNotes(int? id, String? title, String? des) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    
    if (title != null && des != null) {
      titleController.text = title;
      descriptionController.text = des;
    }

    return showModalBottomSheet(
        context: context,
        elevation: 4,
        isScrollControlled: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        hintText: "Title",
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)),
                        hintText: "Description",
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (id == null) {
                            SQLHelper.insertData(
                                    titleController.text.toString(),
                                    descriptionController.text.toString())
                                .then((value) => {
                                      if (value != -1)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Data inserted successfully"),
                                          ))
                                        }
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text("Failed to insert Data"),
                                          ))
                                        }
                                    });
                          } else {
                            SQLHelper.updateData(
                                id,
                                titleController.text.toString(),
                                descriptionController.text.toString());
                          }

                          Navigator.of(context).pop(context);
                          getAllItems();
                        },
                        child: Text(id == null ? "Add Note" : "Update Note"),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: _notesData.isEmpty
          ? const Center(
              child: Text("No Data Found",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            )
          : ListView.builder(
              itemCount: _notesData.length,
              itemBuilder: (context, position) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(_notesData[position]['title']),
                    subtitle: Text(_notesData[position]['description']),
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        GestureDetector(
                            onTap: () {
                              addNotes(
                                  _notesData[position]["id"],
                                  _notesData[position]["title"],
                                  _notesData[position]["description"]);
                            },
                            child: const Icon(Icons.edit)),
                        GestureDetector(
                            onTap: () {
                              SQLHelper.deleteData(_notesData[position]["id"]);
                              getAllItems();
                            },
                            child: const Icon(Icons.delete)),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addNotes(null, null, null);
        },
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<Map<String, dynamic>> _dataList = [];


//   getAllData() async {
//     var List = await SQLHelper.getAllData();
//     setState(() {
//       _dataList = List;
//     });
//   }
  
//   @override
//   void initState() {
//     super.initState();
//     getAllData();
//   }


//   addItems(int ? id, String ? title, String ? description) {
//     TextEditingController titleController = TextEditingController();
//     TextEditingController desController = TextEditingController();

//     if (title != null && description != null) {
//       titleController.text = title;
//       desController.text = description;
//     }
//     return showModalBottomSheet(
//         backgroundColor: Colors.white70,
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.all(10),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[400],
//                     hintText: "title",
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10.0,
//                 ),
//                 TextField(
//                   textAlign: TextAlign.start,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.all(20),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       borderSide: const BorderSide(
//                         color: Colors.grey,
//                       ),
//                     ),
//                     filled: true,
//                     fillColor: Colors.grey[400],
//                     hintText: "description",
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     var title = titleController.text.toString();
//                     var des = desController.text.toString();

//                     if (id == null) {
//                       SQLHelper.insertNoteData(title, des).then((value) => {
//                             if (value != -1)
//                               {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text(
//                                             "Data inserted Successfully"))),
//                               }
//                             else
//                               {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text("Falied to insert"))),
//                               }
//                           });
//                     } else {
//                       SQLHelper.upDateData(id, title, des);
//                     }

//                     Navigator.of(context).pop(context);
//                     getAllData();
//                   },
//                   child: id == null
//                       ? const Text("Insert Data")
//                       : const Text("update data"),
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getAllData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.1,
//         backgroundColor: Colors.cyan,
//         title: const Text("Notes"),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(
//               Icons.search,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       backgroundColor: Colors.grey,
//       body: _dataList.isNotEmpty
//           ? ListView.builder(
//               itemCount: _dataList.length,
//               itemBuilder: (context, position) {
//                 return InkWell(
//                   onTap: () {},
//                   child: Card(
//                     color: Colors.grey,
//                     child: ListTile(
//                       title: Text(
//                         _dataList[position]["title"].toString(),
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       subtitle:
//                           Text(_dataList[position]["description"].toString()),
//                       iconColor: Colors.black54,
//                       trailing: Wrap(
//                         spacing: 15.0,
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 addItems(
//                                   _dataList[position]["id"],
//                                   _dataList[position]["title"].toString(),
//                                   _dataList[position]["description"].toString(),
//                                 );
//                               },
//                               child: const Icon(Icons.edit)),
//                           GestureDetector(
//                               onTap: () {
//                                 SQLHelper.deleteData(_dataList[position]["id"]);
//                                 getAllData();
//                               },
//                               child: const Icon(Icons.delete)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
//           : const Center(
//               child: Text("No Data found"),
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           addItems(null, null, null);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
