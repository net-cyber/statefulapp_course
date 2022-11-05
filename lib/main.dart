import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String title = 'Tap the screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: GestureDetector(
            onTap: () {},
            child: Center(
              child: TextButton(
                  onPressed: () {
                    //setState is used to redraw the widget
                    //it updates the widget after the data changes
                    // don't use Future returning function in setState
                    setState(() {
                      title = DateTime.now().toIso8601String();
                    });
                    //setState redraws the whole screen when it called
                    //but if you have stateless(not changing widget) 
                    //on your screen it is also redrawn
                    //[inheritedWidget] gives you more controls over redraw
                    //you can compare the previous widget to the current widget
                    //therefore you have the control to redraw or not
                    //gives you more control over how the element tree 
                    //is mapped with widget tree
                  },
                  child: const Text('What time is it?')),
            )));
  }
}
