import 'package:dart_api_app/pj_utils/pj_colors.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  _DialogScreenState createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  final List<String> messages = [];
  TextEditingController controller = TextEditingController();
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:8080'));

  @override
  void initState() {
    channel.stream.listen((event) {
      print(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Text(
                messages.isNotEmpty ? messages[index] : '',
                style: TextStyle(color: Colors.white),
              );
            },
            itemCount: messages.length,
          )),
          Padding(
            padding: EdgeInsets.only(bottom: 40, left: 10, right: 10),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 60,
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: PjColors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: PjColors.green)),
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    cursorColor: PjColors.green,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    channel.sink.add('Hello');
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: PjColors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
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
