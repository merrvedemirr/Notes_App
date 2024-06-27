import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_app/View/widgets/note_card.dart';

Padding notes(List<dynamic> values) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: GridView.custom(
      shrinkWrap: true, //içeriği kadar alan kaplar
      physics: const NeverScrollableScrollPhysics(), //scroll olmaz
      gridDelegate: SliverWovenGridDelegate.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        pattern: [
          const WovenGridTile(1),
          const WovenGridTile(
            5 / 7,
            crossAxisRatio: 0.9,
            alignment: AlignmentDirectional.centerEnd,
          ),
        ],
      ),
      //*Notların olduğu bölüm
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: values.length,
        (context, index) => NoteCard(
          values: values[index],
        ),
      ),
    ),
  );
}
