import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvvm_provider_template/mvvm/view/post/pages/post_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Widget> _pages = [];
  int _currentIndex = 0;

  @override
  void initState() {
    _pages = [
      const PostPage(),
      const PostPage(),
      const PostPage(),
      const PostPage(),
      const PostPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.home),
              label: "HOME"),
          //title: Text(S.of(context).home)),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.search),
              label: "SEARCH"),
          //title: Text(S.of(context).search)),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.plusSquare),
              label: "ADD"),
          //title: Text(S.of(context).add)),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.heart),
              label: "IINE"),
          //title: Text(S.of(context).activities)),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "USER"),
          //title: Text(S.of(context).user)),
        ],
      ),
    );
  }
}