import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './pages/bootstrap_page.dart';
import 'pages/metas_pessoais_page.dart';
import './pages/html_css_page.dart';
import './pages/javascript_page.dart';
import './pages/reactnative_page.dart';
import 'package:ionicons/ionicons.dart';

const _url =
    'https://api.whatsapp.com/send?phone=5521976707086&text=Ol%C3%A1%2C%20eu%20vi%20seu%20portf%C3%B3lio%20e%20gostaria%20de%20contrat%C3%A1-lo!';
const _url2 = 'https://github.com/jonatasolialmeida';
const _url3 = 'https://www.gitshowcase.com/jonatasolialmeida';
const _url4 =
    'https://www.linkedin.com/in/jonatas-oliveira-de-almeida-24933a26/';

void main() {
  runApp(
    const MaterialApp(
      home: const MenuAnimado(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MenuAnimado extends StatefulWidget {
  const MenuAnimado({
    Key? key,
  }) : super(key: key);

  @override
  _MenuAnimadoState createState() => _MenuAnimadoState();
}

class _MenuAnimadoState extends State<MenuAnimado>
    with SingleTickerProviderStateMixin {
  late AnimationController _drawerSlideController;

  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerOpen() {
    return _drawerSlideController.value == 1.0;
  }

  bool _isDrawerOpening() {
    return _drawerSlideController.status == AnimationStatus.forward;
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void _toggleDrawer() {
    if (_isDrawerOpen() || _isDrawerOpening()) {
      _drawerSlideController.reverse();
    } else {
      _drawerSlideController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Center(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/jonatassoul.png')),
                      )),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: IconButton(
                          onPressed: abrirGmail,
                          icon: Icon(
                            Ionicons.mail_open_outline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: IconButton(
                            onPressed: _launchURL2,
                            icon: Icon(Ionicons.logo_github)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: IconButton(
                            onPressed: _launchURL3,
                            icon: Icon(Ionicons.link_outline)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: IconButton(
                            onPressed: _launchURL4,
                            icon: Icon(Ionicons.logo_linkedin)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _buildContent(),
          _buildDrawer(),
        ],
      ),
    );
  }

  void _launchURL2() async => await canLaunch(_url2)
      ? await launch(_url2)
      : throw 'Could not launch $_url2';

  void _launchURL3() async => await canLaunch(_url3)
      ? await launch(_url3)
      : throw 'Could not launch $_url3';

  void _launchURL4() async => await canLaunch(_url4)
      ? await launch(_url4)
      : throw 'Could not launch $_url4';

  abrirGmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'jonatas.olialmeida@gmail.com',
      query: 'subject=Reportar&body=Olá Jônatas, vi seu Portfólio ',
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Menu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.blue,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      actions: [
        AnimatedBuilder(
          animation: _drawerSlideController,
          builder: (context, child) {
            return IconButton(
              onPressed: _toggleDrawer,
              icon: _isDrawerOpen() || _isDrawerOpening()
                  ? const Icon(
                      Icons.clear,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContent() {
    // Put page content here.
    return const SizedBox();
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed() ? const SizedBox() : Menu(),
        );
      },
    );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    'Html && Css',
    'JavaScript',
    'Bootstrap',
    'React Native',
    'Metas Pessoais',
  ];

  // void _menuTitlesToFunc (List<String> titulo) {
  //   return titulo[_menuTitles]
  // }

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];
  late Interval _buttonInterval;

  @override
  void initState() {
    super.initState();

    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }

    final buttonStartTime =
        Duration(milliseconds: (_menuTitles.length * 50)) + _buttonDelayTime;
    final buttonEndTime = buttonStartTime + _buttonTime;
    _buttonInterval = Interval(
      buttonStartTime.inMilliseconds / _animationDuration.inMilliseconds,
      buttonEndTime.inMilliseconds / _animationDuration.inMilliseconds,
    );
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ..._buildListItems(),
        const Spacer(),
        _buildGetStartedButton(),
      ],
    );
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < _menuTitles.length; ++i) {
      listItems.add(
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[i].transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                offset: Offset(slideDistance, 0),
                child: child,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),

            // USEI OS TITULOS DA LISTA PARA DAR NOME AOS BOTÕES
            child: TextButton(
              child: Text(
                _menuTitles[i],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.left,
              ),
              onPressed: () {
                //  Se na lista tiver o item da lista
                if (_menuTitles.contains(_menuTitles[i])) {
                  // ir para pagina
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    // UTILIZEI OS NOMES DA LISTA NO IF PARA RETORNO DAS PAGES
                    if (_menuTitles[i] == 'Html && Css') {
                      return HtmlCss();
                    }
                    if (_menuTitles[i] == 'JavaScript') {
                      return JavaScript();
                    }
                    if (_menuTitles[i] == 'Bootstrap') {
                      return Bootstrap();
                    }
                    if (_menuTitles[i] == 'Metas Pessoais') {
                      return MetasPessoais();
                    } else {
                      return ReactNative();
                    }
                  }));
                }
              },
            ),
          ),
        ),
      );
    }
    return listItems;
  }

  Widget _buildGetStartedButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            final animationPercent = Curves.elasticOut.transform(
                _buttonInterval.transform(_staggeredController.value));
            final opacity = animationPercent.clamp(0.0, 1.0);
            final scale = (animationPercent * 0.5) + 0.5;

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: child,
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: _launchURL,
                child: Icon(Ionicons.logo_whatsapp, color: Colors.white, size: 30,),
                    style: OutlinedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(25),
                            backgroundColor: Colors.green),
                ),
            ],
          ),
          ),
        ),
      );
    
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
