[![pub package](https://img.shields.io/pub/v/shape_to_go.svg)](https://pub.dartlang.org/packages/shape_to_go)

# shape_to_go

Creating basic shapes is now easy with the shape_to_go package.

## Example

![](assets/pic_1.png)

```
ClipPath(
    clipper: Potter(points: [
        const TopLeftEdge(),
        const PointOnShap(xDivider: 2,yDivider: 3),
        const TopRightEdge(),
        const PointOnShap(xDivider: 3/2,yDivider: 2),
        const BottomRightEdge(),
        const PointOnShap(xDivider: 2,yDivider: 3/2),
        const BottomLeftEdge(),
        const PointOnShap(xDivider: 3,yDivider: 2),
        ]
        ),
        child: Container(
        color: Colors.green,
        width: 342,
        height: 357,
        ),
    ),
```
