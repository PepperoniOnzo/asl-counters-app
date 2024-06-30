import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/caching_service.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CachingService>().getCachedImage(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Image.file(snapshot.data!);
        }
        return const SizedBox();
      },
    );
  }
}
