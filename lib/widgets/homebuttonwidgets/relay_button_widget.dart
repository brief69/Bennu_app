import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/homewidgetmodels/relay_model.dart';
import '/viewmodels/widgetsviewmodels/relay_viewmodel.dart';

// リレーウィジェットを定義します。
class RelayWidget extends ConsumerWidget {
  // コンストラクタを定義します。
  const RelayWidget({Key? key}) : super(key: key);

  // ウィジェットのビルドを定義します。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ビューモデルを取得します。
    final viewModel = ref.watch(relayViewModelProvider);

    // カスタムペイントウィジェットを返します。
    return CustomPaint(
      // ペインターを定義します。
      painter: RelayPainter(viewModel.nodes, viewModel.edges),
      // ジェスチャーディテクターを定義します。
      child: GestureDetector(
        // タップアップイベントを定義します。
        onTapUp: (details) {
          // タップ位置を取得します。
          final offset = details.localPosition;
          // タップイベントを処理します。
          _handleTap(context, offset, viewModel);
        },
      ),
    );
  }

  // タップイベントを処理するメソッドを定義します。
  void _handleTap(BuildContext context, Offset tapPosition, RelayViewModel viewModel) {
    // ノードのタップを確認します。
    for (int i = 0; i < viewModel.nodeAreas.length; i++) {
      if (viewModel.nodeAreas[i].contains(tapPosition)) {
        // ノードデータポップアップを表示します。
        _showNodeDataPopup(context, viewModel.nodes[i]);
        return;
      }
    }

    // エッジのタップを確認します。
    for (int i = 0; i < viewModel.edgeAreas.length; i++) {
      if (viewModel.edgeAreas[i].contains(tapPosition)) {
        // エッジデータポップアップを表示します。
        _showEdgeDataPopup(context, viewModel.edges[i]);
        return;
      }
    }
  }

  // ノードデータポップアップを表示するメソッドを定義します。
  void _showNodeDataPopup(BuildContext context, Node node) {
    // ダイアログを表示します。
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // タイトルを設定します。
        title: const Text('Node Data'),
        // コンテンツを設定します。
        content: Text('ID: ${node.id}\nStatus: ${node.status}\nPostDataId: ${node.postDataId}'),
      ),
    );
  }

  // エッジデータポップアップを表示するメソッドを定義します。
  void _showEdgeDataPopup(BuildContext context, Edge edge) {
    // ダイアログを表示します。
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // タイトルを設定します。
        title: const Text('Edge Data'),
        // コンテンツを設定します。
        content: Text('Duration: ${edge.duration}\nStartNode: ${edge.startNode.id}\nEndNode: ${edge.endNode.id}'),
      ),
    );
  }
}

// 描画方向を定義します。
enum DrawingDirection { Right, DownRight, DownLeft, Left }

// リレーペインターを定義します。
class RelayPainter extends CustomPainter {
  // ノードとエッジを定義します。
  final List<Node> nodes;
  final List<Edge> edges;
  // ノードの半径とエッジの長さを定義します。
  final double nodeRadius = 20.0;
  final double edgeLength = 100.0;

  // コンストラクタを定義します。
  RelayPainter(this.nodes, this.edges);

  // ペイントメソッドを定義します。
  @override
  void paint(Canvas canvas, Size size) {
    // 線のペイントを定義します。
    final linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0;

    // ノードのペイントを定義します。
    final nodePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // アクティブノードのペイントを定義します。
    final activeNodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 現在の位置と方向を定義します。
    Offset currentPosition = Offset(nodeRadius * 2, size.height / 2);
    DrawingDirection currentDirection = DrawingDirection.Right;

    // ノードとエッジを描画します。
    for (int i = 0; i < nodes.length; i++) {
      // ノードを描画します。
      canvas.drawCircle(currentPosition, nodeRadius, 
          i == nodes.length - 1 ? activeNodePaint : nodePaint);

      // エッジと次のノードがある場合、エッジを描画します。
      if (i < edges.length) {
        final edge = edges[i];
        final edgeLength = (edge.data.length * 10.0); 

        // 次の位置を定義します。
        Offset nextPosition;
        // 現在の方向に基づいて次の位置を更新します。
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

        // エッジを描画します。
        canvas.drawLine(currentPosition, nextPosition, linePaint);

        // 現在の方向を更新します。
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

        // 現在の位置を更新します。
        currentPosition = nextPosition;
      }
    }
  }

  // ペイントを再描画するかどうかを定義します。
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
