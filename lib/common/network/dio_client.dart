import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract final class DioClient {
  static const String baseUrl =
      'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(_RequestSpacingInterceptor());

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          logPrint: (line) => debugPrint('[dio] $line'),
        ),
      );
    }

    return dio;
  }
}

final class _RequestSpacingInterceptor extends QueuedInterceptor {
  static const Duration _interval = Duration(seconds: 1);

  final Stopwatch _clock = Stopwatch()..start();

  Duration? _lastStart;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final lastStart = _lastStart;

    if (lastStart != null) {
      final elapsed = _clock.elapsed - lastStart;
      final delay = _interval - elapsed;

      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
    }

    _lastStart = _clock.elapsed;
    handler.next(options);
  }
}
