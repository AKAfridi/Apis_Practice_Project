import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;
  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print('No Image has been selected');
    }
  }
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var strem =new http.ByteStream(image!.openRead());
    strem.cast();

    var length = await image!.length();
    
    var uri = Uri.parse('https://fakestoreapi.com/products');
    
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";
    var  multipart = new http.MultipartFile('image', strem, length);
    request.files.add(multipart);
    var response = await request.send();
    if(response.statusCode == 200){
      print('File Uploaded');
      setState(() {
        showSpinner = false;
      });
    }
    else{
      print('failed');
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                  child: image == null
                      ? const Center(
                          child: Text('Pick an Image'),
                        )
                      : Container(
                          child: Center(
                            child: Image.file(
                              image!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  color: Colors.teal,
                  child: Center(child: Text('Upload Image')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
