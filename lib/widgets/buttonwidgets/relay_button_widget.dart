

// relay_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/relay_model.dart';
import '../../viewmodels/widgetsviewmodels/relay_viewmodel.dart';


class RelayWidget extends ConsumerWidget {
  const RelayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(relayViewModelProvider);

    return CustomPaint(
      painter: RelayPainter(viewModel.nodes, viewModel.edges),
      child: GestureDetector(
        onTapUp: (details) {
          final offset = details.localPosition;
          _handleTap(context, offset, viewModel);
        },
      ),
    );
  }

  void _handleTap(BuildContext context, Offset tapPosition, RelayViewModel viewModel) {
    // ノードのタップを確認
    for (int i = 0; i < viewModel.nodeAreas.length; i++) {
      if (viewModel.nodeAreas[i].contains(tapPosition)) {
        _showNodeDataPopup(context, viewModel.nodes[i]);
        return;
      }
    }

    // エッジのタップを確認
    for (int i = 0; i < viewModel.edgeAreas.length; i++) {
      if (viewModel.edgeAreas[i].contains(tapPosition)) {
        _showEdgeDataPopup(context, viewModel.edges[i]);
        return;
      }
    }
  }

  void _showNodeDataPopup(BuildContext context, Node node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Node Data'),
        content: Text('ID: ${node.id}\nStatus: ${node.status}\nPostDataId: ${node.postDataId}'),
      ),
    );
  }

  void _showEdgeDataPopup(BuildContext context, Edge edge) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edge Data'),
        content: Text('Duration: ${edge.duration}\nStartNode: ${edge.startNode.id}\nEndNode: ${edge.endNode.id}'),
      ),
    );
  }
}

// ignore: constant_identifier_names
enum DrawingDirection { Right, DownRight, DownLeft, Left }

class RelayPainter extends CustomPainter {
  final List<Node> nodes;
  final List<Edge> edges;
  final double nodeRadius = 20.0;
  final double edgeLength = 100.0;

  RelayPainter(this.nodes, this.edges);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    final nodePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final activeNodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Offset currentPosition = Offset(nodeRadius * 2, size.height / 2);
    DrawingDirection currentDirection = DrawingDirection.Right;

    for (int i = 0; i < nodes.length; i++) {
      // Draw the node
      canvas.drawCircle(currentPosition, nodeRadius, 
          i == nodes.length - 1 ? activeNodePaint : nodePaint);

      // If there's an edge and a next node, draw the edge
      if (i < edges.length) {
        final edge = edges[i];
        final edgeLength = (edge.data.length * 10.0); 

        Offset nextPosition;
        switch (currentDirection) {
          case DrawingDirection.Right:
            nextPosition = currentPosition + Offset(edgeLength, 0);
            if (nextPosition.dx + nodeRadius * 2 > size.width) {
              currentDirection = DrawingDirection.DownRight;
            }
            break;
          case DrawingDirection.DownRight:
            nextPosition = currentPosition + Offset(0, edgeLength);
            currentDirection = DrawingDirection.Left;
            break;
          case DrawingDirection.DownLeft:
            nextPosition = currentPosition + Offset(0, edgeLength);
            currentDirection = DrawingDirection.Right;
            break;
          case DrawingDirection.Left:
            nextPosition = currentPosition - Offset(edgeLength, 0);
            if (nextPosition.dx - nodeRadius * 2 < 0) {
              currentDirection = DrawingDirection.DownLeft;
            }
            break;
        }

        canvas.drawLine(currentPosition, nextPosition, linePaint);

        // Update current direction
        switch (currentDirection) {
          case DrawingDirection.Right:
            currentDirection = DrawingDirection.DownRight;
            break;
          case DrawingDirection.DownRight:
            currentDirection = DrawingDirection.Left;
            break;
          case DrawingDirection.Left:
            currentDirection = DrawingDirection.DownLeft;
            break;
          case DrawingDirection.DownLeft:
            currentDirection = DrawingDirection.Right;
            break;
        }

        // Update current position
        currentPosition = nextPosition;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
