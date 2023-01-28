import 'package:dart_api_app/models/user_model.dart';
import 'package:dart_api_app/pj_utils/pj_colors.dart';
import 'package:dart_api_app/screens/dialog_screen/dialog_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'cubit/cb_main_screen.dart';
import 'cubit/st_main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<UsersModel> users = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavigationBar(
          enableFeedback: false,
          elevation: 0,
          selectedItemColor: PjColors.green,
          onTap: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          currentIndex: index,
          selectedFontSize: 16,
          unselectedItemColor: Colors.green,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: PjColors.green,
                ),
                label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: PjColors.green,
                ),
                label: 'Profile'),
          ],
          selectedLabelStyle: TextStyle(color: PjColors.green),
          unselectedLabelStyle: TextStyle(color: Colors.white),
          backgroundColor: Color.fromRGBO(20, 20, 20, 1),
        ),
      ),
      body: BlocConsumer<CbMainScreen, StMainScreen>(
        listener: (context, state) {},
        buildWhen: (oldState, newState) => newState is StMainScreenLoaded,
        builder: (context, state) {
          if (state is StMainScreenLoading) {
            context.read<CbMainScreen>().getData();
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is StMainScreenLoaded) {
            return SafeArea(
              child: Column(
                children: [
                  // StreamBuilder(stream: channel.stream, builder: (context, snapshot) {
                  //   return Text(snapshot.hasData ? '${snapshot.data}' : 'EMPTY', style: TextStyle(color: Colors.white, fontSize: 24),);
                  // })
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => DialogScreen());
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(child: Icon(Icons.person, color: Colors.white, size: 35,), minRadius: 36, backgroundColor: Colors.green,),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Nickname', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),),
                                  SizedBox(height: 20,),
                                  Text('Message', style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }, itemCount: 1, padding: EdgeInsets.only(left: 15),),
                  ),
                ],
              ),
            );
          }
          if (state is StMainScreenError) {
            return Container(color: Colors.red);
          }
          return Container(color: Colors.grey);
        },
      ),
    );
  }
}
