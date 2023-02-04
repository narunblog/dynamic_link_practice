import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'create_invite_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Get any initial links
  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  runApp(MyApp(initialLink: initialLink));
}

class MyApp extends StatelessWidget {
  final PendingDynamicLinkData? initialLink;
  MyApp({Key? key, required this.initialLink}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (initialLink != null) {
      final Uri deepLink = initialLink!.link;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title:
              initialLink != null ? initialLink!.link.path.toString() : 'test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _deepLink = "null";

  @override
  void initState() {
    // 1. Dynamic Linkを受け取ったのかについて確認
    _initDynamicLinks();
    super.initState();
  }

  void _initDynamicLinks() async {
    print('start');
    // 2. FirebaseDynamicLinksのpackageで提供されているメソッド
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      //print(dynamicLinkData.link.toString());
      print(dynamicLinkData.link.queryParameters['test']);
      setState(() {
        _deepLink = dynamicLinkData.link.toString();
      });
    }).onError((error) {
      // Handle errors
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              _deepLink,
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateInvitePage()),
                  );
                }),
                child: Text('発行画面'))
          ],
        ),
      ),
    );
  }
}
