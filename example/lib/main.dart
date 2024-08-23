import 'package:flutter/material.dart';
import 'package:shape_to_go/shape_to_go.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData.dark(),
      home: const Example()
    );
  }
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            SizedBox(
              width: double.maxFinite,
              height: 357,
              child: Stack(
                children: [
                  Positioned(
                    left: (MediaQuery.of(context).size.width-342)/2,
                    child: ClipPath(
                      clipper: Potter(points: [
                        const TopLeftCorner(),
                        const TopRightCorner(),
                        const PointOnRightSide(divider: 1.5),
                        const BottomCenterCorner(),
                        const PointOnLeftSide(divider: 1.5),
                      ],
                      radius: const Radius.circular(10)
                      ),
                      child: Container(
                        color: Colors.purple,
                        width: 342,
                        height: 200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: (MediaQuery.of(context).size.width-342)/2,
                    bottom: 0,
                    child: ClipPath(
                      clipper: Potter(points: [
                        const TopLeftCorner(radius: Radius.circular(30)),
                        const PointOnRightSide(divider: 2.5),
                        const BottomRightCorner(),
                        const BottomLeftCorner(),
                      ],
                      radius: const Radius.circular(10)
                      ),
                      child: Container(
                        color: Colors.cyan,
                        width: 163,
                        height: 200,
                      ),
                    ),
                  ),
                  Positioned(
                    right: (MediaQuery.of(context).size.width-342)/2,
                    bottom: 0,
                    child: ClipPath(
                      clipper: Potter(points: [
                        const PointOnLeftSide(divider: 2.5),
                        const TopRightCorner(radius: Radius.circular(30)),
                        const BottomRightCorner(),
                        const BottomLeftCorner(),
                      ],
                      radius: const Radius.circular(10)
                      ),
                      child: Container(
                        color: Colors.deepPurple,
                        width: 163,
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            ClipPath( 
              clipper: Potter(points: [
                const TopCenterCorner(),
                const PointOnShap(xDivider: (8/5), yDivider: (8/3)),
                const CenterRightCorner(),
                const PointOnShap(xDivider: (8/5), yDivider: (8/5)),
                const BottomCenterCorner(),
                const PointOnShap(xDivider: (8/3), yDivider: (8/5)),
                const CenterLeftCorner(),
                const PointOnShap(xDivider: (8/3), yDivider: (8/3)),
              ]
              ),
              child: Container(
                color: Colors.blue,
                width: 342,
                height: 357,
              ),
            ),
            const SizedBox(height: 20,),
            ClipPath( 
              clipper: Potter(points: [
                const TopLeftCorner(),
                const CenterPoint(),
                const TopRightCorner(),
                const BottomRightCorner(),
                const BottomLeftCorner(),
              ]
              ),
              child: Container(
                color: Colors.red,
                width: 342,
                height: 357,
              ),
            ),
            const SizedBox(height: 20,),
            ClipPath( 
              clipper: Potter(points: [
                const TopLeftCorner(),
                const PointOnShap(xDivider: 2,yDivider: 3),
                const TopRightCorner(),
                const PointOnShap(xDivider: 3/2,yDivider: 2),
                const BottomRightCorner(),
                const PointOnShap(xDivider: 2,yDivider: 3/2),
                const BottomLeftCorner(),
                const PointOnShap(xDivider: 3,yDivider: 2),
              ]
              ),
              child: Container(
                color: Colors.green,
                width: 342,
                height: 357,
              ),
            ),
            const SizedBox(height: 20,),
            ClipPath( 
              clipper: Potter.messageShapeRight(radius: const Radius.circular(20)),
              child: Container(
                color: Colors.green,
                width: 342,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

