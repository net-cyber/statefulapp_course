// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: ApiProvider(
        api: Api(),
        child: HomePage(),
      ),
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
  ValueKey _textKey = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ApiProvider.of(context).api.dateAndTime ?? ''),
        ),
        body: GestureDetector(
            onTap: () {},
            child: Center(
              child: TextButton(
                  onPressed: () async {
                    final api = ApiProvider.of(context).api;
                    final timeAndDate = await api.getDateAndTime();
                    //as soon as we get date and time we will update the [_textKey]
                    setState(() {
                      //set new value to textKey
                      _textKey = ValueKey(timeAndDate);
                    });
                    //this will redraw any widget that is dependent on 
                    //[_textKey] which is our [DateTimeWidget]
                    //////////////////////////////////////////////////////////
                    //setState is used to redraw the widget
                    //it updates the widget after the data changes
                    // don't use Future returning function in setState
                    // setState(() {
                    //   title = DateTime.now().toIso8601String();
                    // });
                    //setState redraws the whole screen when it called
                    //but if you have stateless(not changing widget)
                    //on your screen it is also redrawn
                    //[inheritedWidget] gives you more controls over redraw
                    //you can compare the previous widget to the current widget
                    //therefore you have the control to redraw or not
                    //gives you more control over how the element tree
                    //is mapped with widget tree
                  },
                  child: DateTimeWidget(key: _textKey,)),
            )));
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'tap to see time');
  }
}

class Api {
  String? dateAndTime;
  Future<String> getDateAndTime() {
    return Future.delayed(
      const Duration(seconds: 1),
      () => DateTime.now().toIso8601String(),
    ).then((value) => dateAndTime = value);
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;
  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : uuid = const Uuid().v4(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    //this is where you decide to redraw or not
    return uuid != oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
}
//! inheritedWidget is Immutable
//so inheritedWidget is immutable how can i replace it?
//? wrap inheritedWidget inside a StatefulWidget
//!notice inheritedWidget redraws all child