import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petgram_mobile_app/bloc/all_post_bloc/all_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:petgram_mobile_app/components/confirm_button.dart';
import 'package:petgram_mobile_app/components/loading_dialog.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _caption = TextEditingController();
  ScrollController _scrollController = ScrollController();
  File _image;
  bool _isShowClear = false;
  final _picker = ImagePicker();

  Future<void> getImageFromCamera()async{
    final _pickedImage = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(_pickedImage.path);
      _isShowClear = true;
    });
  }

  Future<void> getImageFromGallery()async{
    final _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(_pickedImage.path);
      _isShowClear = true;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreatePostBloc>(context);
    _scrollController.addListener(() {
//      if(_scrollController.position.userScrollDirection == ScrollDirection.forward || _scrollController.position.userScrollDirection == ScrollDirection.reverse){
//        FocusScope.of(context).requestFocus(FocusNode());
//      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: BaseColor.black,),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text('Create Post',style: TextStyle(color: BaseColor.black,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: BlocListener<CreatePostBloc,CreatePostState>(
        listener: (context,state){
          print(state);
          if(state is CreatePostSuccess){
            Navigator.pop(context);
            BlocProvider.of<AllPostBloc>(context).add(UpdateAllPost());
            Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(SnackBar(
              content: Text('Create Post Success'),
            ));
            Navigator.pop(context);
            _image = null;
          }
          if(state is CreatePostLoading){
            LoadingDialog(context: context,msg:'Uploading');
          }
          if(state is CreatePostFailure){
            Navigator.pop(context);
            Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(content: Text(state.msg),)
            );
            context.bloc<CreatePostBloc>().add(ResetCreatePostEvent());
          }
        },
        child: BlocBuilder<CreatePostBloc,CreatePostState>(
          builder:(context,state) => Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ListView(
                controller: _scrollController,
                children: [
                  GestureDetector(
                    onTap: (){
                      showModalBottomSheet(context: context,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          builder: (context)=>Container(
                        height: 130,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('From Camera'),
                              onTap: (){
                                Navigator.pop(context);
                                getImageFromCamera();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.photo_library),
                              title: Text('From Gallery'),
                              onTap: (){
                                Navigator.pop(context);
                                getImageFromGallery();
                              },
                            ),
                          ],
                        ),
                      ));
                    },
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: BaseColor.grey2),
                        color: BaseColor.grey1,
                      ),
                      child: _image != null?Image.file(_image,fit: BoxFit.cover,):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt,color: BaseColor.grey2,),
                          Text('Pick Image',style: TextStyle(color: BaseColor.grey2),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  _isShowClear?Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                          _image = null;
                          _isShowClear = false;
                        });
                      },
                      icon: Icon(Icons.delete,color: BaseColor.red,),
                    ),
                  ):Center(),
                  MyFormField(
                    keyboardType: TextInputType.text,
                    textEditingController: _caption,
                    hintText: 'caption',
                  ),
                  SizedBox(height: 40,),
                  ConfirmButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    text: Center(
                      child: Text('Done',style: TextStyle(color: BaseColor.white,fontWeight: FontWeight.bold,fontSize: 24),),
                    ),
                    onTap: (){
                      context.bloc<CreatePostBloc>().add(CreatePost(
                        image: _image,caption: _caption.text
                      ));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
