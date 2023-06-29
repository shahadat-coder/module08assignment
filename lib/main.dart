import 'package:flutter/material.dart';
import 'package:module_8/widgets/reuseable_textfield.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.cyan),
      themeMode: ThemeMode.light,
      home: const Todo(),
    );
  }
}

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController _titleEDController = TextEditingController();
  final TextEditingController _descripEDController = TextEditingController();
  final TextEditingController _dayEDController = TextEditingController();

  List<MyTodo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Task App'),
        actions: [
          IconButton(
              onPressed: () {
                todos.clear();
                if (mounted) {
                  setState(() {});
                }
              },
              icon: const Icon(Icons.playlist_remove))
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        "https://scontent.fdac24-2.fna.fbcdn.net/v/t1.15752-9/351006720_223243020504077_9174529426871097671_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=ae9488&_nc_ohc=3dbwLGRacpoAX9XkLAK&_nc_ht=scontent.fdac24-2.fna&oh=03_AdQrlyFG6vEcsg45Jyuvvglv8aw97zL71n461i5PT8YiKA&oe=64C0C9E2"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Md. Shahadat Hossain',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Student of Ostad in Flutter batch 3"),
                  Text("App Development"),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext mContext) {
                        final deleteTask = DeleteTask(todos, todos[index]);

                        return Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  "https://www.pngplay.com/wp-content/uploads/6/Files-Icon-PNG-HD-Quality.png",
                                  height: 40,
                                  width: 40,
                                ),
                                Text(
                                  todos[index].name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(todos[index].description),
                                Text(todos[index].dateline),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      deleteTask.delete();
                                      deleteTask.delete();
                                      todos.clear();
                                      if (mounted) {
                                        setState(() {});
                                      }

                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white),
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.grey.shade200,
                    child: ListTile(
                      isThreeLine: true,
                      leading: todos[index].isDone
                          ? const Icon(Icons.done)
                          : Image.network(
                              "https://www.pngplay.com/wp-content/uploads/6/Files-Icon-PNG-HD-Quality.png",
                              height: 40,
                              width: 40,
                            ),
                      title: Text(
                        todos[index].name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todos[index].description),
                          Text(todos[index].dateline),
                        ],
                      ),
                      trailing: const Icon(Icons.info),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        onPressed: () {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add Task"),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.network(
                          "https://www.pngplay.com/wp-content/uploads/6/Files-Icon-PNG-HD-Quality.png",
                          height: 60,
                          width: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          labelText: "Task",
                          controller: _titleEDController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ReusableTextField(
                          labelText: "Description",
                          controller: _descripEDController,
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          controller: _dayEDController,
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? datePicked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2024));
                                  if (datePicked != null) {
                                    setState(() {
                                      _dayEDController.text =
                                          formatDate(datePicked);
                                    });
                                  }
                                },
                                icon: const Icon(Icons.date_range)),
                            labelText: "Date Line",
                            floatingLabelStyle: const TextStyle(fontSize: 13),
                            labelStyle: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 10),
                            alignLabelWithHint: true,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyan,
                                width: 0.7,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 0.7,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              if (_titleEDController.text.trim().isNotEmpty &&
                                  _descripEDController.text.trim().isNotEmpty &&
                                  _dayEDController.text.trim().isNotEmpty) {
                                todos.add(MyTodo(
                                    _titleEDController.text,
                                    _descripEDController.text,
                                    _dayEDController.text,
                                    false));
                                if (mounted) {
                                  setState(() {});
                                }
                                _titleEDController.clear();
                                _descripEDController.clear();
                                _dayEDController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Save')),
                        const SizedBox(
                          width: 5,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel')),
                      ],
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

String formatDate(DateTime date) {
  final dateFormat = DateFormat('yyyy-MM-dd');
  return dateFormat.format(date);
}

class MyTodo {
  String name, description, dateline;

  bool isDone;

  MyTodo(this.name, this.description, this.dateline, this.isDone);
}

class DeleteTask {
  final List<MyTodo> todos;
  final MyTodo task;

  DeleteTask(this.todos, this.task);

  void delete() {
    todos.remove(task);
  }
}
