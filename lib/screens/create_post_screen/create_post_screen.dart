import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petgram_mobile_app/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:petgram_mobile_app/components/confirm_button.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  TextEditingController _caption = TextEditingController();
  File _image;
  bool _isShowClear = false;
  final _picker = ImagePicker();

  Future<void> getImage()async{
    final _pickedImage = await _picker.getImage(source: ImageSource.gallery);
    print(_pickedImage.path);
    setState(() {
      _image = File(_pickedImage.path);
      _isShowClear = true;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CreatePostBloc>(context);
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
            Scaffold.of(context)..hideCurrentSnackBar();
            Navigator.pop(context);
            _image = null;
          }
          if(state is CreatePostLoading){
            Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
              SnackBar(content: Text('Uploading...'),)
            );
          }
          if(state is CreatePostFailure){
            print(state.msg ?? 'Failed Create Post');
            Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(content: Text(state.msg ?? 'Failed Create Post'),)
            );
            context.bloc<CreatePostBloc>().add(ResetCreatePostEvent());
          }
        },
        child: BlocBuilder<CreatePostBloc,CreatePostState>(
          builder:(context,state) => Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: (){
                    getImage();
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
    );
  }
}
