import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/features/home/state/bloc/home_bloc.dart';

class HomeBackActionHandler extends StatefulWidget {
  final Widget child;

  const HomeBackActionHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<HomeBackActionHandler> createState() => _HomeBackActionHandlerState();
}

class _HomeBackActionHandlerState extends State<HomeBackActionHandler> {
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = context.read<HomeBloc>();

    return PopScope(
      canPop: false,
      onPopInvoked: isReady ? (didPop) => homeBloc.onPop(context) : null,
      child: widget.child,
    );
  }
}
