


// relay_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bennu_app/widgets/homebuttonwidgets/relay_button_widget.dart';
import '../../models/widgetmodels/relay_model.dart'; 

final relayViewModelProvider = ChangeNotifierProvider((ref) => RelayViewModel());

class RelayViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Node> nodes = [];
  List<Edge> edges = [];
  
  List<Rect> nodeAreas = [];
  List<Rect> edgeAreas = [];

  RelayViewModel() {
    loadData();
  }

  Future<void> loadData() async {
    // Nodesの取得
    var nodesSnapshots = await _firestore.collection('nodes').get();
    for (var snapshot in nodesSnapshots.docs) {
      nodes.add(Node(
        snapshot.id,
        snapshot.data()['status'] as String,
        snapshot.data()['postDataId'] as String,
      ));
    }

    // Edgesの取得
    var edgesSnapshots = await _firestore.collection('edges').get();
    for (var snapshot in edgesSnapshots.docs) {
      String startNodeId = snapshot.data()['startNodeId'] as String;
      String endNodeId = snapshot.data()['endNodeId'] as String;
      Node startNode = nodes.firstWhere((node) => node.id == startNodeId);
      Node endNode = nodes.firstWhere((node) => node.id == endNodeId);
      edges.add(Edge(startNode, endNode, snapshot.data()['duration'] as int));
    }

    _calculateAreas();
    notifyListeners();
  }

  void _calculateAreas() {
    const nodeRadius = 20.0;
    Offset currentPosition = const Offset(nodeRadius * 2, 300 / 2);
    DrawingDirection currentDirection = DrawingDirection.Right;

    for (int i = 0; i < nodes.length; i++) {
      nodeAreas.add(Rect.fromCircle(center: currentPosition, radius: nodeRadius));

      if (i < edges.length) {
        final edge = edges[i];
        final edgeLength = (edge.data.length * 10.0);

        Offset nextPosition;
        switch (currentDirection) {
          case DrawingDirection.Right:
            nextPosition = currentPosition + Offset(edgeLength, 0);
            if (nextPosition.dx + nodeRadius * 2 > 300) {  // 画面の横幅（300）は適切な値に変更してください
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

        edgeAreas.add(Rect.fromPoints(currentPosition, nextPosition));

        currentPosition = nextPosition;
      }
    }
  }
}
