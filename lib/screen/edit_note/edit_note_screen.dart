import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/appLifecycleState.dart';
import 'package:flutter_riverpod_note_app/models/note_list.dart';
import 'package:flutter_riverpod_note_app/screen/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class EditNoteScreen extends ConsumerWidget {
  const EditNoteScreen({
    super.key,
  });
  static const routeName = 'EditNote';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String id = ref.read(currentIdProvider);
    final noteData = ref.watch(
      noteListProvider.select(
        (noteList) => noteList.firstWhere((noteList) => noteList.id == id),
      ),
    );
    TextEditingController title = TextEditingController(text: noteData.title);
    TextEditingController body = TextEditingController(text: noteData.text);

    //アプリのライフサイクルを監視
    ref.listen<AppLifecycleState>(
      appLifecycleProvider,
      // `next` に変更された `AppLifecycleState` が入ってきます。
      // 任意の処理を行いましょう。
      (previous, next) {
        // アプリがアクティブではなくなった時の処理
        if (AppLifecycleState.inactive == AppLifecycleState.inactive) {
          ref.watch(noteListProvider.notifier).updateNote(
                id: id,
                title: title.text,
                text: body.text,
              );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () async {
            FocusScope.of(context).unfocus();

            ref.watch(noteListProvider.notifier).updateNote(
                  id: id,
                  title: title.text,
                  text: body.text,
                );

            context.goNamed(HomeScreen.routeName);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.keyboard_hide),
            onPressed: () async {
              FocusScope.of(context).unfocus();
              ref.watch(noteListProvider.notifier).updateNote(
                    id: id,
                    title: title.text,
                    text: body.text,
                  );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          // コンテンツの高さがScrollViewを超えた時のみスクロールするようにする
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              //おまじない
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                          decoration: const InputDecoration(
                            hintText: "Title",
                            border: InputBorder.none,
                          ),
                          minLines: 1,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          controller: title),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                          decoration: const InputDecoration(
                            hintText: "Write something...",
                            border: InputBorder.none,
                          ),
                          minLines: 20,
                          maxLines: 999,
                          keyboardType: TextInputType.multiline,
                          controller: body,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
