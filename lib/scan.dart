import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Data/Clients.dart';

class ScanFood extends StatefulWidget {
  const ScanFood({Key? key, required this.client}) : super(key: key);
  final Clients_info client;

  @override
  State<ScanFood> createState() => _ImageLabellingState();
}

class _ImageLabellingState extends State<ScanFood> {
  late InputImage _inputImage;
  File? _pickedImage;
  String imageState = '';
  final _Namecontroller = TextEditingController();
  final _Typecontroller = TextEditingController();
  final _Carbscontroller = TextEditingController();
  final _Fatscontroller = TextEditingController();
  final _Proteincontroller = TextEditingController();
  final _Kcalcontroller = TextEditingController();
  bool disabled = true;

  static final ImageLabelerOptions _options =
      ImageLabelerOptions(confidenceThreshold: 0.8);

  final imageLabeler = ImageLabeler(options: _options);

  final ImagePicker _imagePicker = ImagePicker();

  String text = "";

  pickImageFromGallery() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    setState(() {
      _pickedImage = File(image.path);
    });
    _inputImage = InputImage.fromFile(_pickedImage!);
    identifyImage(_inputImage);
  }

  Widget textfeild(TextEditingController controller) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 235, 235),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        decoration: InputDecoration(border: InputBorder.none),
        controller: controller,
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget foodData() {
    if (imageState == "Food" || imageState == "Meal") {
      setState(() {
        disabled = false;
      });
      return Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Food Name:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        textfeild(_Namecontroller),
                      ],
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          "Food Type:",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        textfeild(_Typecontroller),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Kcal:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              textfeild(_Kcalcontroller),
              SizedBox(
                height: 10,
              ),
              Text(
                "Carbs:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              textfeild(_Carbscontroller),
              SizedBox(
                height: 10,
              ),
              Text(
                "Proteins:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              textfeild(_Proteincontroller),
              SizedBox(
                height: 10,
              ),
              Text(
                "Fats:",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              textfeild(_Fatscontroller),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }

  void identifyImage(InputImage inputImage) async {
    final List<ImageLabel> image = await imageLabeler.processImage(inputImage);

    if (image.isEmpty) {
      setState(() {
        text = "Cannot identify the image";
      });
      return;
    }

    for (ImageLabel img in image) {
      setState(() {
        imageState = img.label;
      });
    }
    imageLabeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Scaning"),
      ),
      body: Container(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_pickedImage != null)
                  Image.file(
                    _pickedImage!,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                else
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      color: const Color.fromARGB(255, 248, 247, 247),
                    ),
                    height: 300,
                    width: double.infinity,
                  ),
                SingleChildScrollView(child: foodData()),
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: const Text(
                      "Pick Image",
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      pickImageFromGallery();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.blue, // Border color
                        width: 2.0, // Border width
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.orange),
                    ),
                    onPressed: () {
                      if (!disabled) {
                        Meal_Info meal = Meal_Info(
                            carbs: int.parse(_Carbscontroller.text),
                            fats: int.parse(_Fatscontroller.text),
                            kcAl: int.parse(_Kcalcontroller.text),
                            proteins: int.parse(_Proteincontroller.text),
                            meal: _Typecontroller.text,
                            name: _Namecontroller.text);
                        Database database = Database();
                        database.SaveCostomFood(widget.client, meal);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
