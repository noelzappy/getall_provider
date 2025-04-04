import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ondprovider/ui/strings.dart';
import 'theme.dart';

class PolicyScreen extends StatefulWidget {
  final String source;
  const PolicyScreen({Key? key, required this.source}) : super(key: key);

  @override
  _PolicyScreenState createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {

  double windowWidth = 0;
  double windowHeight = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  double _scroller = 20;
  _scrollListener() {
    var _scrollPosition = _scrollController.position.pixels;
    _scroller = 20-(_scrollPosition/(windowHeight*0.1/20));
    if (_scroller < 0)
      _scroller = 0;
    setState(() {
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,
        body: Directionality(
          textDirection: strings.direction,
          child: Stack(
              children: [
                NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                          expandedHeight: windowHeight*0.2,
                          automaticallyImplyLeading: false,
                          pinned: true,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: ClipPath(
                            clipper: ClipPathClass23((_scroller < 5) ? 5 : _scroller),
                            child: Container(
                                color: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
                                child: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.pin,
                                    background: _title(),
                                    titlePadding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                    title: _titleSmall()
                                )),
                          ))
                    ];
                  },
                  body: Container(
                    width: windowWidth,
                    height: windowHeight,
                    child: SingleChildScrollView(child: _body(),),
                  ),
                ),
                appbar1(Colors.transparent, (theme.darkMode) ? Colors.white : Colors.black,
                    "", context, () {goBack();}),

              ]),
        ));
  }

  _title() {
    return Container(
      color: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
      height: windowHeight * 0.3,
      width: windowWidth/2,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Container(
              width: windowWidth*0.3,
              child: Image.asset("assets/getimages/documents.png", fit: BoxFit.cover),
            ),
            margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          ),
        ],
      ),
    );
  }

  _titleSmall(){
    var _text1 = strings.get(82); /// "Privacy Policy",
    var _text2 = strings.get(83); /// "Known our Privacy Policy",
    if (widget.source == "about"){
      _text1 = strings.get(108); /// "About Us",
      _text2 = strings.get(109); /// "Known About Us",
    }
    if (widget.source == "terms"){
      _text1 = strings.get(110); /// "Terms & Conditions",
      _text2 = strings.get(111); /// "Known Terms & Conditions",
    }
    return Container(
        alignment: Alignment.bottomLeft,
        width: windowWidth*0.4,
        padding: EdgeInsets.only(bottom: _scroller, left: 15, right: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(fit: BoxFit.scaleDown, child: Text(_text1, style: theme.style16W800,)),
            SizedBox(height: 3,),
            FittedBox(fit: BoxFit.scaleDown, child: Text(_text2, style: theme.style10W600Grey)),
          ],
        )
    );
  }

  // String _data = "<h2>Lorem ipsum dolor</h2> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et "
  //     "dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
  //     "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
  //     "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  //     "<br><br>"
  //     "<h2>Lorem ipsum dolor</h2> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et "
  //     "dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
  //     "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
  //     "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";

  _body(){
    var _data = "";
    if (widget.source == "policy")
      _data = appSettings.policy;
    if (widget.source == "about")
      _data = appSettings.about;
    if (widget.source == "terms")
      _data = appSettings.terms;

    return Container(
      margin: EdgeInsets.all(15),
      child: Html(
          data: "<body>$_data",
          style: {
            "body": Style(
                backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,
                color: (theme.darkMode) ? Colors.white : Colors.black
            ),
          }
      ),
    );
  }
}

