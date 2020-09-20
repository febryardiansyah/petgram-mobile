import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petgram_mobile_app/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/components/confirm_button.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/user_models/user_profile_model.dart';
import 'package:petgram_mobile_app/screens/edit_profile_screen/form_list/edit_password_form_screen.dart';
import 'package:petgram_mobile_app/screens/edit_profile_screen/form_list/name_form_screen.dart';
import 'package:petgram_mobile_app/screens/edit_profile_screen/form_list/pet_name_form_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final DetailModel userDetail;

  EditProfileScreen({this.userDetail});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _petCtrl = TextEditingController();
  TextEditingController _passCtrl = TextEditingController();

  DetailModel get userDetail => widget.userDetail;

  bool _isShowPassword = false;

  File _image;
  final _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_pickedImage.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    final _pickedImage = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(_pickedImage.path);
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProfileBloc>(context);
    BlocProvider.of<ProfileBloc>(context).add(FetchMyProfile());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: BaseColor.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: BaseColor.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocListener<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileLoading) {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: Row(
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text('Loading...'),
                          )
                        ],
                      ),
                    ));
          }
          if (state is EditProfileSuccess) {
            context.bloc<ProfileBloc>().add(FetchMyProfile());
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Success'),
              ));
            Navigator.pop(context);
          }
          if (state is EditProfileFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: BaseColor.red,
              ));
            Navigator.pop(context);
          }
        },
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: BaseColor.red,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: _image != null
                            ? AssetImage(_image.path)
                            : NetworkImage(userDetail.profilePic),
                        fit: BoxFit.cover)),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    builder: (context) => Container(
                          height: 130.0,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.photo),
                                title: Text('From Gallery'),
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                  });
                                  _pickImageFromGallery();
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.camera_alt),
                                title: Text('From Camera'),
                                onTap: () {
                                  setState(() {
                                    _image = null;
                                  });
                                  _pickImageFromCamera();
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ));
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: size.width * 0.4,
                  child: Center(
                    child: Text(
                      'Change Image',
                      style: TextStyle(
                          color: BaseColor.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: BaseColor.red, width: 1)),
                ),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is MyProfileLoaded) {
                  final DetailModel _user = state.userProfileModel.user.detailModel;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NameFormScreen(name: _user.name,)));
                            },
                            leading: Icon(Icons.person_outline),
                            title: Text(_user.name),
                          ),
                          color: BaseColor.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PetNameFormScreen(petname: _user.petname,)));
                            },
                            leading: Icon(FontAwesomeIcons.cat),
                            title: Text(_user.petname),
                          ),
                          color: BaseColor.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordFormScreen()));
                            },
                            leading: Icon(FontAwesomeIcons.key),
                            title: Text('Change you password'),
                          ),
                          color: BaseColor.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ConfirmButton(
                          width: size.width,
                          height: 50,
                          text: Center(
                              child: Text(
                            'Done',
                            style: TextStyle(
                                color: BaseColor.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          )),
                          onTap: () {
                            context.bloc<EditProfileBloc>().add(EditProfilePicEvent(
                                image: _image,));
                          },
                        ),
                      )
                    ],
                  );
                }
                if (state is ProfileFailure) {
                  return Center(
                    child: Text(state.msg),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
