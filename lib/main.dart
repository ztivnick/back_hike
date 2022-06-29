import 'package:flutter/material.dart';
import 'package:back_hike/plan_page.dart';
import 'package:back_hike/lookback_page.dart';
import 'package:rect_getter/rect_getter.dart';

void main() {
  runApp(const BackHikeApp());
}

class BackHikeApp extends StatelessWidget {
  const BackHikeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back Hike',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Duration animationDuration = const Duration(milliseconds: 300);
  final Duration delay = const Duration(milliseconds: 100);
  var planButtonKey = RectGetter.createGlobalKey();
  var lookbackButtonKey = RectGetter.createGlobalKey();
  Color animationColor = Colors.grey;
  Rect? rect;

  void _startTransitionAnimation({
    required Widget destination,
    required Color color,
    required GlobalKey<RectGetterState> globalKey,
  }) {
    setState(() {
      rect = RectGetter.getRectFromKey(globalKey)!;
      animationColor = color;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => rect = rect!.inflate(1.5 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, () {
        Navigator.of(context).push(TransitionBuilder(page: destination)).then((_) => setState(() => rect = null));
      });
    });
  }

  Widget _transitionAnimation() {
    if (rect == null) {
      return const SizedBox.shrink();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      top: rect!.top,
      left: rect!.left,
      right: MediaQuery.of(context).size.width - rect!.right,
      bottom: MediaQuery.of(context).size.height - rect!.bottom,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: animationColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RectGetter(
                  key: planButtonKey,
                  child: IconButton(
                    icon: const Icon(
                      Icons.backpack,
                      color: Colors.greenAccent,
                      size: 60,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => _startTransitionAnimation(
                      destination: const PlanPage(),
                      color: Colors.greenAccent,
                      globalKey: planButtonKey,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 80,
                ),
                RectGetter(
                  key: lookbackButtonKey,
                  child: IconButton(
                    icon: const Icon(
                      Icons.hiking,
                      color: Colors.blueAccent,
                      size: 60,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => _startTransitionAnimation(
                      destination: const PlanPage(),
                      color: Colors.blueAccent,
                      globalKey: lookbackButtonKey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _transitionAnimation(),
      ],
    );
  }
}

class TransitionBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  TransitionBuilder({required this.page})
      : super(
          pageBuilder: (context, anim1, anim2) => page,
          transitionsBuilder: (context, anim1, anim2, child) {
            return FadeTransition(opacity: anim1, child: child);
          },
        );
}
