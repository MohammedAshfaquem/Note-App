import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteapp/themepage.dart';
import 'package:permission_handler/permission_handler.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  File? imagepath;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Stack(children: [
            imagepath == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      child: Image.asset("assets/images/profile.jpg"),
                      radius: 80,
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      radius: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(100),
                        child: Image.file(
                          imagepath!,
                          height: 200,
                          width: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
            Positioned(
              right: 5,
              bottom: 5,
              child: GestureDetector(
                onTap: () async {
                  Map<Permission, PermissionStatus> status =
                      await [Permission.storage, Permission.camera].request();
                  if (status[Permission.storage]!.isGranted &&
                      status[Permission.camera]!.isGranted) {
                    showimagepicker(context);
                  } else {
                    Text("no permission granted");
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 20,
                  child: Icon(
                    Icons.camera_enhance,
                  ),
                ),
              ),
            )
          ]),
          SizedBox(
            height: 10,
          ),

          // optional textbuttton

          /* TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.inversePrimary)),
              onPressed: () async {
                Map<Permission, PermissionStatus> status =
                    await [Permission.storage, Permission.camera].request();
                if (status[Permission.storage]!.isGranted &&
                    status[Permission.camera]!.isGranted) {
                  showimagepicker(context);
                } else {
                  Text("no permission granted");
                }
              },
              child: Text("Take the picture")),*/
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Notes"),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ThemePage(),
            )),
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
          ),
        ],
      ),
    );
  }

  final picker = ImagePicker();
  showimagepicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          child: Container(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Profile Photo",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      IconButton(
                        iconSize: 50,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          imagefromcamera();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          size: 30,
                          Icons.camera_enhance_outlined,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      IconButton(
                        iconSize: 50,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Theme.of(context).colorScheme.primary)),
                        onPressed: () {
                          imagefromgallery();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          size: 30,
                          Icons.photo_album_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  imagefromgallery() async {
    await picker.pickImage(source: ImageSource.gallery).then(
          (value) => setState(() {
            imagepath = File(value!.path);
          }),
        );
  }

  imagefromcamera() async {
    await picker.pickImage(source: ImageSource.camera).then(
          (value) => setState(() {
            imagepath = File(value!.path);
          }),
        );
  }
}
