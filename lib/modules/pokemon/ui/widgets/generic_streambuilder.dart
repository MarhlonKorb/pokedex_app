import 'package:flutter/material.dart';
/// StreamBuilder genérico
class GenericStreamBuilder<T> extends StatefulWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext, AsyncSnapshot<T>) builder;

  const GenericStreamBuilder({
    Key? key,
    required this.stream,
    required this.builder,
  }) : super(key: key);

  @override
  GenericStreamBuilderState<T> createState() =>
      GenericStreamBuilderState<T>();
}

class GenericStreamBuilderState<T> extends State<GenericStreamBuilder<T>> {
  late Stream<T> _stream;

  @override
  void initState() {
    super.initState();
    _stream = widget.stream;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: _stream,
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
