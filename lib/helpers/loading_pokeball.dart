import 'package:flutter/material.dart';

class LoadingPokeball extends StatefulWidget {
  const LoadingPokeball({super.key});

  @override
  State<LoadingPokeball> createState() => _LoadingPokeballState();
}

class _LoadingPokeballState extends State<LoadingPokeball>
    with TickerProviderStateMixin {
  late AnimationController motionController;
  late Animation motionAnimation;
  double size =
      40; //this is the variable that will make the motion -> we change the value of size

  @override
  void initState() {
    super.initState();

    motionController = AnimationController(
      duration: const Duration(
          seconds: 1), //how quicly the effect will be completed and repeat
      vsync: this,
      lowerBound: 0.6,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });
    motionController.addListener(() {
      setState(() {
        size = motionController.value * 180;
      });
    });
  }

  @override
  void dispose() {
    motionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 200,
      child: Column(children: <Widget>[
        Center(
          child: SizedBox(
            height: size,
            child: Image.asset('assets/pokeball.png'),
          ),
        ),
      ]),
    );
  }
}
