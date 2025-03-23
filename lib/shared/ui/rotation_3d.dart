import 'dart:math';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

/// Un widget que aplica una transformación de rotación 3D a su hijo.
/// Permite rotar en los ejes X, Y o Z.
class Rotation3d extends StatelessWidget {
  final Widget child;
  final double rotationX;
  final double rotationY;
  final double rotationZ;
  final Offset perspective;

  /// Crea un widget de rotación 3D.
  /// [child] es el widget al que se aplicará la rotación.
  /// [rotationX], [rotationY], [rotationZ] son los ángulos de rotación en grados para cada eje.
  /// [perspective] controla la perspectiva de la transformación 3D.
  const Rotation3d({
    Key? key,
    required this.child,
    this.rotationX = 0,
    this.rotationY = 0,
    this.rotationZ = 0,
    this.perspective = const Offset(0.001, 0.001),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: _createMatrix4(),
      child: child,
    );
  }

  /// Crea la matriz de transformación 3D basada en los ángulos de rotación.
  Matrix4 _createMatrix4() {
    final double rX = rotationX * pi / 180;
    final double rY = rotationY * pi / 180;
    final double rZ = rotationZ * pi / 180;

    Matrix4 matrix =
        Matrix4.identity()
          ..setEntry(3, 2, perspective.dx) // Perspectiva en X
          ..setEntry(3, 1, perspective.dy); // Perspectiva en Y

    // Aplicar rotaciones
    if (rX != 0) {
      matrix.rotateX(rX);
    }
    if (rY != 0) {
      matrix.rotateY(rY);
    }
    if (rZ != 0) {
      matrix.rotateZ(rZ);
    }

    return matrix;
  }
}
