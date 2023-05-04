import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_note_app/models/note.dart';
import 'package:flutter_riverpod_note_app/screen/home/home_screen.dart';

class EachNote extends ConsumerWidget {
  const EachNote({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Note note = ref.watch(currentNoteProvider);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        //ここのRowはFlexibleを反応させるためにある。
        child: Row(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    note.text,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
