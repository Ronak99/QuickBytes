import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/core/theme/state/theme_cubit.dart';

class ArticleFooterTwo extends StatelessWidget {
  const ArticleFooterTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Color itemBackground = Theme.of(context).colorScheme.secondary;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white12, width: .5),
        borderRadius: BorderRadius.circular(12),
      ),
      height: 80,
      child: Row(
        children: [],
      ),
    );
  }
}
