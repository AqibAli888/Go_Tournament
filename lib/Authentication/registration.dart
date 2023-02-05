import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:shared_preferences/shared_preferences.dart';
import '../Global/global.dart';
import '../main_screens/home_screen.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import '../widgets/text_form_field.dart';
import 'package:geolocator/geolocator.dart';
import "package:firebase_storage/firebase_storage.dart" as fstorage;
class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var currentuser;
  // name of textfield
  TextEditingController namecontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  TextEditingController phonecontroller=TextEditingController();
  TextEditingController locationcontroller=TextEditingController();
  final GlobalKey<FormState>_formkey=GlobalKey<FormState>();
  XFile? imagexfile;
  final  ImagePicker imagePicker=ImagePicker();
  Position?position;
// sign up... upload profile image...upload data to firestore
  void sign_up_with_email_and_password()async{
    // Sign up to the user account
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim()).then((auth) async {
        currentuser = auth.user;
        String filename = DateTime
            .now()
            .millisecondsSinceEpoch
            .toString();
        fstorage.Reference reference = fstorage.FirebaseStorage.instance.ref().
        child("Users").child(filename);
        fstorage.UploadTask uploadTask = reference.putFile(
            File(imagexfile!.path));
        fstorage.TaskSnapshot taskSnapshot = await uploadTask
            .whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url) {
          userimageurl = url;
          if (currentuser != null) {
            savedatatofirestore(currentuser).then((value) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home_screen()),
              );
            });
          }
        });
      });
    }catch(err){
      Navigator.pop(context);
      print(err.toString()+"heeee");
      showDialog(context: context, builder: (c) {
        return Error_Dialog(message: err.toString());
      });

    }
  }
// save data to firestore and local system
  Future savedatatofirestore(User currentuser)async{
    //save data to firestore
    FirebaseFirestore.instance.collection("Users").doc(currentuser.uid).set({
      "Userid":currentuser.uid,
      "useremail":currentuser.email,
      "Name":namecontroller.text.trim(),
      "Phone":phonecontroller.text.trim(),
      "address":locationcontroller.text.trim(),
      "imageurl":userimageurl
    });


    // save data to local system
    sharedpreference=await SharedPreferences.getInstance();
    await sharedpreference!.setString("uid", currentuser.uid);
    await sharedpreference!.setString("uid", currentuser.email.toString());
    await sharedpreference!.setString("name", namecontroller.text.trim());
    await sharedpreference!.setString("imageurl", userimageurl);

  }

// get image from the camera
  Future<void>_getImage()async
  {
    imagexfile=await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagexfile;
    });
  }
String userimageurl="";
  // getuser location latitude and longitude
  Future<void>getlocation()async{
    position=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
    position!.latitude;
    double latitude=position!.longitude;
    double longitude=position!.latitude;
    String address='${latitude},${longitude}';
    locationcontroller.text=address;
  }
  // check validation of the fields enter by the user
  Future<void>Formvalidation()async{
    if(imagexfile==null){
      showDialog(context: context, builder: (c){
        return Error_Dialog(message: "please Take an Image to continue",);
      });
    }
    else  if(emailcontroller.text.isEmpty||passwordcontroller.text.isEmpty || confirmpasswordcontroller.text.isEmpty
        || phonecontroller.text.isEmpty || locationcontroller.text.isEmpty ||namecontroller.text.isEmpty){
      showDialog(context: context, builder: (c){
        return Error_Dialog(message: "Please Enter the All text Fields",);
      });

    }
    else {
      if(emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty&& confirmpasswordcontroller.text.isNotEmpty
        && phonecontroller.text.isNotEmpty&& locationcontroller.text.isNotEmpty&& namecontroller.text.isNotEmpty) {
        if(passwordcontroller.text!=confirmpasswordcontroller.text){
          showDialog(context: context, builder: (c){
            return Error_Dialog(message: "Password not Matched",);
          });
        }
        else {
          showDialog(context: context, builder: (c) {
            return Loading_Dialog(message: 'Registring ',);
          });
          sign_up_with_email_and_password();

          // uploading image into firestore

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                _getImage();
              },
              child: CircleAvatar(
                radius:MediaQuery.of(context).size.width*0.20,
                backgroundColor: CupertinoColors.white,
                backgroundImage: imagexfile==null?null:FileImage(File(imagexfile!.path)),
                child: imagexfile==null?Icon(Icons.add,size:MediaQuery.of(context).size.width*0.20 ,):null,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.002,
            ),
            Form(
              key: _formkey,
                child:Column(
                  children: [
                    Text_form_field(controller: namecontroller,
                        texthint:"Enter Your name",
                        data: Icons.person),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller: phonecontroller,
                        texthint:"Enter Your Phone Number",
                        data: Icons.phone),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller: emailcontroller,
                        texthint:"Enter Your Email",
                        data: Icons.mail),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller: passwordcontroller,
                        texthint:"Enter Your password",
                        data: Icons.lock_clock_outlined,obscure: true,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller: confirmpasswordcontroller,
                        texthint:"Enter Your confirm password",
                        data: Icons.lock_clock_outlined,obscure: true,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    Text_form_field(controller:locationcontroller,
                      texthint:"Address",
                      data: Icons.my_location,enabled:false),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.002,
                    ),
                    GestureDetector(
                      onTap: (){
                        getlocation();
                      },
                      child: Container(
                        height:MediaQuery.of(context).size.height*0.07 ,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.location_on),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.002,
                              ),
                              Center(child: Text("Get Location")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.02,
                    ),
                    GestureDetector(
                      onTap: (){
                        Formvalidation();

                      },
                      child: Container(
                        padding: EdgeInsets.all(0.8),
                        margin: EdgeInsets.all(0.8),
                        height:MediaQuery.of(context).size.height*0.07 ,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.app_registration),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.03,
                              ),
                              Center(child: Text("Sign up")),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ))

          ],
        ),
      ),
    );
  }
}
