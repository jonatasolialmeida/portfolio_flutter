import 'package:flutter/material.dart';
import 'slide_tile.dart';

class HtmlCss extends StatefulWidget {

  @override
  _HtmlCssState createState() => _HtmlCssState();
}

class _HtmlCssState extends State<HtmlCss> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;

  var _listSlide = <Map<String, dynamic>>[ /* ****** AQUI******* */
    {'id': 0, 'image': 'assets/images/html.png'},
    {'id': 1, 'image': 'assets/images/html1.png'},
    {'id': 2, 'image': 'assets/images/html2.png'},
    {'id': 3, 'image': 'assets/images/html3.png'},
  ];



  @override
  void initState() {
    _pageController.addListener(() {
     int next = _pageController.page!.round();
     if (_currentPage != next){
       setState(() {
         _currentPage = next;
       });
     }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Image.asset(
          
        // ),
        title: Text(
          'Html && Css',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _listSlide.length,
                itemBuilder: (_ ,currentIndex ){
                  bool activePage = currentIndex == _currentPage;
                  return SlideTile(
                    activePage: activePage,
                    image: _listSlide[currentIndex]['image'],);
                },
              ),
            ),
            _buildBullets()
          ],
        ),
      ),
    );
  }

Widget _buildBullets() {
  return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _listSlide.map((i){
          return  InkWell(
            onTap: (){

              // NÃO ESTA ACEITANDO OBJETO, PRECISA SER UM INTEIRO
              // RESOLVIDO NA LINHA 15
              setState(() {
                _pageController.jumpToPage(i['id']);
                _currentPage = i['id'];
              });
            },
            child: Container(
              margin: EdgeInsets.all(10),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // PORQUE AQUI ACEITOU?
                color: _currentPage == i['id'] ? Colors.red : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
      );
}
}

