import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu/viewmodels/home_viewmodel.dart';
import 'package:bennu/widgets/bell_tab_widget.dart';
import 'media_item_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaViewModels = ref.watch(mediaViewModelProvider);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: TabBarView(
              controller: _tabController,
              children: [
                MediaReel(viewModels: mediaViewModels),
                MediaReel(viewModels: mediaViewModels),
                const BellTabWidget(),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(text: 'おすすめ'),
                    Tab(text: 'フォロー'),
                    Tab(icon: Icon(Icons.notifications)),
                  ],
              ),
            )
          ),
        ],
      ),
    );
  }
}
