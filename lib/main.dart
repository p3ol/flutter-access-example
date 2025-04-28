import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_access/flutter_access.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Flutter Access Basic Example'),
          backgroundColor: const Color.fromARGB(255, 92, 86, 223),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                      create: (ref) => AccessProvider(
                            appId: "155PF-L7Q6Q-EB2GG-04TF8",
                            debug: true,
                          )),
                ],
                child: const Content(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _Content();
}

class _Content extends State<Content> {
  @override
  Widget build(BuildContext context) {
    const appId = "155PF-L7Q6Q-EB2GG-04TF8";
    const config = {
      "debug": true,
      "force_widget": 'gift',
      "cookies_enabled": true,
    };
    const texts = {
      "gift_title": "Custom gift title",
      "gift_desc": "{custom_variable}",
      "gift_button": "Click here!",
    };
    const styles = {
      "skin_color": "#5C56DF",
      "premium_color": "#5C56DF",
      "button_color": "#5C56DF",
    };
    const variables = {
      "custom_variable":
          "This gift widget's description is custom & generared from a custom variable.",
    };
    var events = {
      "onReady": (args) {
        // ignore: avoid_print
        print("onReady with args: $args");
      },
      // Async events
      "onRegister": (args) {
        Future<List?> waitTask() async {
          await Future.delayed(const Duration(seconds: 3));
          // retrieve your field value from args
          var _ = args["event"]["email"];

          // Set your logic here to return an error if needed in this format
          // {"fieldKey": "email", "message": "This email is not allowed"}
          // or return null or nothing if not needed
          return null;
        }

        return waitTask();
      },
    };

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: const Text(
                'Media\'s article title',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: const Text(
                'This is a little preview of the article in order to give you a better idea of what it is about.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),

            // Uncomment the following lines to use the AccessBottomSheet
            // instead of the AccessWrapper method.
            // AccessBottomSheet(
            //   appId: appId,
            //   config: config,
            //   texts: texts,
            //   styles: styles,
            //   events: events,
            //   variables: variables,
            //   releaseOnError: false,
            // ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: AccessWrapper(
                appId: appId,
                children: [
                  Snippet(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: const Text(
                        'Here is the Poool\'s Snippet content. This is displayed as free content and therefore is not locked behind a wall. It will disappear after releasing the wall.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const RestrictedContent(
                      child: Text(
                          'This is the Poool\'s Restricted content. Unlocked after releasing the wall.')),
                  Paywall(
                    pageType: 'premium',
                    config: config,
                    texts: texts,
                    styles: styles,
                    events: events,
                    variables: variables,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
