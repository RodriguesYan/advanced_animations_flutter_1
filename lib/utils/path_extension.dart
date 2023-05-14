import 'package:flutter/material.dart';

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        //Thinking about a container that is going to have the left side of a circle, and we know that flutter initial canvas point is top left,
        //we have to move the initial point to the top right of the container to start drawing our circle
        //So, we need to move it to the maximux width of the container (100) to the right. Y axis keeps 0, because we dont need to move it vertically
        path.moveTo(size.width, 0);
        //Here we're say to offset what area we want to work. So, we've already moved the initial point to the top right,
        //so we to set offset to the same point and tell the end point too
        offset = Offset(size.width, size.height);
        // clockwise is false because we want to draw counterclockwise
        clockwise = false;
        break;
      case CircleSide.right:
        //Here we dont need to move the initial point, because, thinking about a right side container, the initial point is already 0,0 (top left)
        offset = Offset(0, size.height);
        // clockwise is true because we want to draw from top to bottom, left to right (thinking about a circle inside the container)
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offset,
      //Radius is always the the main point that you want to make the curve of a circle, for example
      //So, in this instance, we have a 100x100 container, so, if we want to get the center of if (our z point), we have to take the height and width as divide by 2 (50,50)
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );

    //We need to tell flutter to close the draw. It means that we drew a half circle but the straight line is not drew yet.
    path.close();
    return path;
  }
}
