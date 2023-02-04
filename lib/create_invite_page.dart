import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:share/share.dart';

class CreateInvitePage extends StatefulWidget {
  const CreateInvitePage({super.key});

  @override
  State<CreateInvitePage> createState() => _CreateInvitePageState();
}

class _CreateInvitePageState extends State<CreateInvitePage> {
  String inviteUrl = 'null';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('発行画面')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectableText(inviteUrl),
            ElevatedButton(
                onPressed: (() async {
                  final dynamicLinkParams = DynamicLinkParameters(
                    link: Uri.parse("https://chat777b5.page.link"),
                    uriPrefix: "https://chat777b5.page.link",
                    androidParameters: const AndroidParameters(
                      packageName: "com.example.app.android",
                      minimumVersion: 30,
                    ),
                    iosParameters: const IOSParameters(
                      bundleId: "com.example.app.ios",
                      appStoreId: "123456789",
                      minimumVersion: "1.0.1",
                    ),
                    googleAnalyticsParameters: const GoogleAnalyticsParameters(
                      source: "twitter",
                      medium: "social",
                      campaign: "example-promo",
                    ),
                    socialMetaTagParameters: SocialMetaTagParameters(
                      title: "Example of a Dynamic Link",
                      imageUrl: Uri.parse("https://example.com/image.png"),
                    ),
                  );
                  final dynamicLink = await FirebaseDynamicLinks.instance
                      .buildShortLink(dynamicLinkParams);

                  Share.share(dynamicLink.shortUrl.toString());

                  setState(() {
                    inviteUrl = dynamicLink.shortUrl.toString();
                  });
                }),
                child: Text('リンク発行')),
          ],
        ),
      ),
    );
  }
}
