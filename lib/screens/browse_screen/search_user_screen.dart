import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/bloc/search_user_bloc/search_user_bloc.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/models/user_models/search_user_model.dart';

class SearchUserScreen extends StatefulWidget {
  @override
  _SearchUserScreenState createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {

  TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchUserBloc>(context).add(FetchSearchUser(query: ''));
  }
  @override
  void dispose() {
    super.dispose();
    _searchCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: MyFormField(
          hintText: 'Search user..',
          autoFocus: true,
          prefixIcon: Icon(Icons.search),
          keyboardType: TextInputType.text,
          textEditingController: _searchCtrl,
          onFieldSubmitted: (value){
            context.read<SearchUserBloc>().add(FetchSearchUser(query: _searchCtrl.text));
          },
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
      body: BlocBuilder<SearchUserBloc,SearchUserState>(
        builder: (context,state){
          if(state is SearchUserLoading){
            return LinearProgressIndicator();
          }
          if (state is SearchUserLoaded) {
            return SearchResultScreen(users: state.searchUserModel.searchResult,);
          }
          return Container();
        },
      ),
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final List<SearchResultModel> users;

  SearchResultScreen({this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,i){
        return ListTile(
          leading: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(users[i].profilePic),fit: BoxFit.cover)
            ),
          ),
          title: Row(
            children: [
              Icon(Icons.person_outline),
              SizedBox(width: 10,),
              Text(users[i].name)
            ],
          ),
          subtitle: Row(
            children: [
              Icon(FontAwesomeIcons.cat),
              SizedBox(width: 10,),
              Text(users[i].petname)
            ],
          ),
          onTap: (){
            Navigator.pushNamed(context, '/userProfile',arguments: users[i].id);
          },
        );
      },
    );
  }
}

