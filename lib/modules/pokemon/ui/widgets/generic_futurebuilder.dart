import 'package:flutter/material.dart';

/// FutureBuilder genérico
class GenericFutureBuilder<T> extends FutureBuilder<T> {
  const GenericFutureBuilder({
    required Future<T> future,
    required Widget Function(BuildContext, AsyncSnapshot<T>) builder,
    Key? key,
  }) : super(
          future: future,
          builder: builder,
          key: key,
        );
}

class GenericFutureBuilderState<T> extends State<GenericFutureBuilder<T>> {
  late Future<T> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.future!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.hasError) {
          return errorBuilder(context, snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return widget.builder(context, snapshot);
      },
    );
  }

  Widget errorBuilder(BuildContext context, dynamic error) {
    return Center(
      child: Text('Erro ao carregar dados da API: $error'),
    );
  }
}
