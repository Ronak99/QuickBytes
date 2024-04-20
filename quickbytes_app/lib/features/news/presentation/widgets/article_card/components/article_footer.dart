import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/core/theme/state/theme_cubit.dart';

class ArticleFooter extends StatelessWidget {
  const ArticleFooter({super.key});

  @override
  Widget build(BuildContext context) {
    Color itemBackground = Theme.of(context).colorScheme.secondary;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: itemBackground,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(right: 5),
              ),
              Text(
                'Relevancy',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => context.read<ThemeCubit>().toggleTheme(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: itemBackground,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
