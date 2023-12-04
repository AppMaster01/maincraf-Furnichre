import 'dart:io';

import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Dio dio = Dio();
String imageUrl =
    "http://owlsup.ru/main_catalog/maps/1933/files/Zombie_apocalypse.mcworl";

class Image_Detail extends StatefulWidget {
  Image_Detail({Key? key}) : super(key: key);

  @override
  State<Image_Detail> createState() => Image_DetailState();
}

class Image_DetailState extends State<Image_Detail> {
  Dio dio = Dio();

  // String imageUrl =
  //     "http://owlsup.ru/main_catalog/maps/1933/files/Zombie_apocalypse.mcworld";
  bool downloading = false;
  String progressString = '';
  String downloadedUrl = '';
  String imageUrl = '';
  bool exits = false;
  double value = 0;

  Future<bool> getStoragePremission() async {
    return await Permission.manageExternalStorage.request().isGranted;
  }

  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future downloadFile(String downloadDireactory) async {
    print('abc$downloadDireactory/Download/${imageUrl.split("/").last}');
    var downloadedImagepath =
        '$downloadDireactory/Download/${imageUrl.split("/").last}';
    try {
      await dio.download(
        imageUrl,
        downloadedImagepath,
        onReceiveProgress: (rec, total) {
          print("Rec:$rec,Total:$total");
          setState(() {
            downloading = true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
            value = (rec / total);
          });
        },
      );
    } catch (e) {
      print(e);
    }
    await Future.delayed(Duration(seconds: 3));
    return downloadedImagepath;
  }

  Future<void> doDownload() async {
    if (await getStoragePremission()) {
      String downloadDirectory = await getDownloadFolderPath();
      await downloadFile(downloadDirectory).then(
        (Url) {
          displayImage(Url);
        },
      );
    }
  }

  void displayImage(String downloadDirectory) {
    setState(() {
      downloading = false;
      progressString = "COMPLETED";
      downloadedUrl = imageUrl;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl =
        "http://owlsup.ru/main_catalog/${abc[12]}/${abc[1]}/files/${abc[6]}";
    Chek();
  }

  var abc = Get.arguments;

  var _openResult = 'Unknown';

  Future<void> openFile() async {
    var filePath =
        '/storage/emulated/0/Download/Download/${imageUrl.split("/").last}';
    final _result = await OpenFile.open(filePath, type: "*/*");
    print(_result.message);

    setState(() {
      _openResult = "type=${_result.type}  message=${_result.message}";
    });
  }

  Chek() async {
    if (await File(
            '/storage/emulated/0/Download/Download/${imageUrl.split("/").last}')
        .exists()) {
      exits = true;
    } else {
      exits = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Device storage/Download/Download/${{imageUrl.split("/").last}}");
    // print("http://owlsup.ru/main_catalog/maps/${abc[7]}/files/${abc[6]}");
    final Dnum = int.parse(abc[2]);
    final Vnum = int.parse(abc[3]);
    final Lnum = int.parse(abc[4]);
    // print('abc${abc}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          abc[0],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'http://owlsup.ru/main_catalog/mods/${abc[1]}/screens/s0.jpg'))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    exits == true
                        ? GestureDetector(
                            onTap: () => openFile(),
                            child: Lottie.network(
                                'https://assets2.lottiefiles.com/packages/lf20_cclcasr5.json'))
                        : downloading
                            ? Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CircularProgressIndicator(
                                            value: value,
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.green),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 13, left: 7),
                                            child: Text(progressString,
                                                style: TextStyle(fontSize: 10)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : downloadedUrl == ""
                                ? GestureDetector(
                                    onTap: () => doDownload(),
                                    child: Center(
                                        child: Image(
                                      image: AssetImage(
                                          'asset/image/download.png'),
                                      width: 30,
                                    )),
                                  )
                                : GestureDetector(
                                    onTap: () => openFile(),
                                    child: Lottie.network(
                                        'https://assets2.lottiefiles.com/packages/lf20_cclcasr5.json',
                                        width: 30)),
                    Text(
                      NumberFormat.compact().format(Dnum),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Center(
                        child: Image(
                      image: AssetImage('asset/image/eye.png'),
                      width: 35,
                    )),
                    Text(
                      NumberFormat.compact().format(Vnum),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 3),
                    Center(
                        child: Image(
                      image: AssetImage('asset/image/heart.png'),
                      width: 30,
                    )),
                    Text(
                      NumberFormat.compact().format(Lnum),
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                abc[5],
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text('More suggestion',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Container(
                child: GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: abc[9].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.9,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://owlsup.ru/main_catalog/mods/${abc[1]}/screens//s$index.jpg'),
                                // ${notes[0].mods![0].screens![index].url!}
                              )),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

shareURL(link) async {
  String url = link;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
