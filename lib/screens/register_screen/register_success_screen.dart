import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/register_bloc/register_bloc.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';

class RegisterSuccessScreen extends StatefulWidget {
  final String msg;

  RegisterSuccessScreen({Key key,this.msg}) : super(key: key);

  @override
  _RegisterSuccessScreenState createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(BaseString.wp3),
                    fit: BoxFit.cover
                )
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.msg,style: TextStyle(fontSize: 30),),
                Container(
                  height: size.height * 0.6,
                  width: size.width * 0.6,
                  child: FlareActor('assets/flares/otp-verification.flr',fit: BoxFit.contain,animation: 'verify-otp',),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/loginScreen');
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('Back to Login',style: TextStyle(color: BaseColor.white),),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(width: 1,color: BaseColor.grey3)
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
