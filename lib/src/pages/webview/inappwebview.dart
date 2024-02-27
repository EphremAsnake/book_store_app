import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
//  iOS features
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class InAppWebView extends StatefulWidget {
  final String webUrl;
  final String title;
  const InAppWebView({super.key, required this.webUrl, required this.title});

  @override
  State<InAppWebView> createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  late final WebViewController _controller;
  bool loadingpage = false;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              loadingpage = true;
            });
            //checkInternetConnection();
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            loadingpage = true;
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            loadingpage = false;
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
            Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
                      ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.webUrl)) {
              // Navigator.of(context).pushAndRemoveUntil(
              //     MaterialPageRoute(builder: (context) => const WebViewExample()),
              //     (Route<dynamic> route) => false);
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          // onUrlChange: (UrlChange change) {
          //   if (change.url.toString().contains(
          //       widget.webUrl)) {

          //   }
          //   debugPrint('url change to ${change.url}');
          // },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.webUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  Color appBarColor = const Color(0xFF2F749C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //backgroundColor: appBarColor,
        elevation: 0,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: loadingpage
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.primarycolor2,
            ))
          : WebViewWidget(
              controller: _controller,
            ),
    );
  }
}
