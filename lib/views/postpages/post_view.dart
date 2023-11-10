

// post_view.dart

import 'package:flutter/material.dart';
import 'package:bennu_app/viewmodels/post_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:io';
import '../../models/currency.dart';
import 'relay_post_page.dart';

class PostView extends ConsumerWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medias = ref.watch(postViewModelProvider);
    final viewModel = ref.read(postViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text("Add Post", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                TextButton(
                  onPressed: viewModel.captureMediaWithCamera,
                  child: const Text("動画を撮る（推奨）", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: viewModel.pickMediaFromGallery,
                  child: const Text("ライブラリから選択", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RelayPostPage()));
                  },
                  child: const Text("Relayする（複利を得る）", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          ...medias.map((media) => Image.file(File(media!.path))).toList(),
          TextField(
            onChanged: viewModel.setCaption,
            decoration: const InputDecoration(hintText: "Caption..."),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    // ここは価格の変数に結びつける必要があります
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Price",
                    hintText: "Enter price...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Column(
                children: [
                  RadioListTile<Currency>(
                    title: const Text('円'),
                    value: Currency.yen,
                    groupValue: viewModel.selectedCurrency,
                    onChanged: (Currency? value) {
                      viewModel.setSelectedCurrency(value!);
                    },
                  ),
                  RadioListTile<Currency>(
                    title: const Text('berry'),
                    value: Currency.berry,
                    groupValue: viewModel.selectedCurrency,
                    onChanged: (Currency? value) {
                      viewModel.setSelectedCurrency(value!);
                    },
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: viewModel.decreaseStock,
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: '${viewModel.stock}'),
                  onChanged: viewModel.setStock,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Stock",
                    hintText: "Enter stock amount...",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: viewModel.increaseStock,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.uploadMediaAndCaption,
        child: const Icon(Icons.upload),
      ),
    );
  }
}// TODO: #15 最終的な投稿ボタンをwidgetsで作る
