import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/models/note.dart';
import 'package:flutter_riverpod_note_app/models/note_list.dart';
import 'package:flutter_riverpod_note_app/screen/edit_note/edit_note_screen.dart';
import 'package:flutter_riverpod_note_app/screen/home/components/each_note.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

final currentNoteProvider = Provider<Note>((ref) => throw UnimplementedError());
final currentIdProvider = StateProvider<String>((ref) => '');

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  static const routeName = 'Home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Note> noteList = ref.watch(noteListProvider);
    final noteListNotifier = ref.watch(noteListProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: AnimationLimiter(
        child: MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 1,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            itemCount: noteList.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                  position: index,
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () async {
                          ref.watch(currentIdProvider.notifier).state =
                              noteList[index].id;

                          context.goNamed(EditNoteScreen.routeName);
                        },
                        child: Slidable(
                          dragStartBehavior: DragStartBehavior.start,
                          key: UniqueKey(),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) async {
                                  await noteListNotifier.deleteNote(
                                      id: noteList[index].id);
                                },
                                backgroundColor: Colors.red.shade500,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: ProviderScope(
                            overrides: [
                              currentNoteProvider
                                  .overrideWithValue(noteList[index]),
                            ],
                            child: const EachNote(),
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var id = const Uuid().v4();

          await noteListNotifier.createNote(
            id: id,
          );
          ref.watch(currentIdProvider.notifier).state = id;

          context.goNamed(EditNoteScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
