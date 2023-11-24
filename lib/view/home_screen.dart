import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../view_model/home_view_ model.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewViewModel  homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: (){
                userPreference.removeUser().then((value){
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: Center(child: Text('Logout'))),
          SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
            builder: (context, value, _){
              switch(value.moviesList.status){
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(child: Text(value.moviesList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: ListTile(

                            leading: Image.network(

                              value.moviesList.data!.movies![index].posterurl.toString(),
                              errorBuilder: (context, error, stack){
                                return const Icon(Icons.error, color: Colors.red,);
                              },
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                            title: Text(value.moviesList.data!.movies![index].title.toString()),
                            subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                          ),
                        );
                      });
                default:
                  return Container();
              }
            }),
      ) ,
    );
  }
}