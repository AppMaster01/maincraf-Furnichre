import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:furnicher_demo/image_detail_show.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'json.dart';

Future<void> main() async {
  return runApp(Demo());
}

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

DemoModel demoModel = DemoModel();

var response;

class _DemoState extends State<Demo> {
  @override
  var pagenumber = 2;
  final List<DemoModel> notes = <DemoModel>[];

  void initState() {
    // response = fetchUsers();
    fetchUsers().then((value) {
      setState(() {
        notes.addAll(value);
      });
    });
    super.initState();
  }

// http://owlsup.ru/posts?category=mods&page=$pagenumber&lang=en&sort=downloads&order=desc&apiKey=37b51d194a7513e45b56f6524f2d51f2
  Future fetchUsers() async {
    var url =
        "http://owlsup.ru/posts?category=mods&page=${pagenumber++}&lang=en&sort=downloads&order=desc&apiKey=37b51d194a7513e45b56f6524f2d51f2";
    var response = await http.get(Uri.parse(url));
    var notes = <DemoModel>[];

    if (response.statusCode == 200) {
      var notesjson = json.decode(response.body);
      notes.add(DemoModel.fromJson(notesjson));
    }
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
            elevation: 0,
            title: Text(
              'Demo',
            ),
          ),
          body: notes.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: notes[0].mods!.length,
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisSpacing: 15,
                    //   mainAxisSpacing: 15,
                    //   childAspectRatio: 0.8,
                    //   crossAxisCount: 2,
                    // ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final Dnum = int.parse(notes[0].mods![index].downloads!);
                      final Vnum = int.parse(notes[0].mods![index].views!);
                      final Lnum = int.parse(notes[0].mods![index].likes!);
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => Image_Detail(),
                            arguments: [
                              notes[0].mods![index].title,
                              notes[0].mods![index].id,
                              notes[0].mods![index].downloads,
                              notes[0].mods![index].views,
                              notes[0].mods![index].likes,
                              notes[0].mods![index].description,
                              notes[0].mods![index].files![0].url!,
                              notes[0].mods![index].files![0].fileId!,
                              notes[0].mods![0].screens![index].url!,
                              notes[0].mods![index].screens!,
                              notes[0].mods![0].files,
                              index,
                              NAME.value[index]
                            ],
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              decoration: BoxDecoration(
                                  color: Color(0xffe5e5e5),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'http://owlsup.ru/main_catalog/mods/${notes[0].mods![index].id}/screens/s0.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Center(
                                    child: Image(
                                  image: AssetImage(
                                      'asset/image/download (1).png'),
                                  width: 18,
                                  color: Colors.orange,
                                )),
                                Text(
                                  NumberFormat.compact().format(Dnum),
                                  // _notes[0].mods![index].downloads.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 8),
                                ),
                                SizedBox(width: 5),
                                Center(
                                    child: Image(
                                  image: AssetImage('asset/image/eye.png'),
                                  width: 18,
                                )),
                                Text(
                                  NumberFormat.compact().format(Vnum),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 8),
                                ),
                                SizedBox(width: 5),
                                Center(
                                    child: Image(
                                  image: AssetImage('asset/image/heart.png'),
                                  width: 16,
                                )),
                                Text(
                                  NumberFormat.compact().format(Lnum),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 8),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              notes[0].mods![index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.blueGrey,
                ))),
    );
  }
}

var NAME = [
  "seeds",
  "texture-packs",
  "mods",
  "maps",
  "skins",
  "shaders",
].obs;
