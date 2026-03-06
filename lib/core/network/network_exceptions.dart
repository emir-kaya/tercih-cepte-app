import 'package:dio/dio.dart';
import '../utils/failures.dart';

class NetworkExceptions {
  static Failure getDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return const ServerFailure('Request to API server was cancelled');
            case DioExceptionType.connectionTimeout:
              return const ServerFailure('Connection timeout with API server');
            case DioExceptionType.unknown:
              return const ServerFailure('Connection to API server failed due to internet connection');
            case DioExceptionType.receiveTimeout:
              return const ServerFailure('Receive timeout in connection with API server');
            case DioExceptionType.badResponse:
              final statusCode = error.response?.statusCode;
              if (statusCode != null) {
                switch (statusCode) {
                  case 400:
                    return const ServerFailure('Bad request');
                  case 401:
                    return const ServerFailure('Unauthorized');
                  case 403:
                    return const ServerFailure('Forbidden');
                  case 404:
                    return const ServerFailure('Not found');
                  case 500:
                    return const ServerFailure('Internal server error');
                  case 503:
                    return const ServerFailure('Service unavailable');
                  default:
                    return ServerFailure('Received invalid status code: $statusCode');
                }
              }
              return const ServerFailure('Received invalid response');
            case DioExceptionType.sendTimeout:
              return const ServerFailure('Send timeout in connection with API server');
            case DioExceptionType.badCertificate:
              return const ServerFailure('Bad certificate');
            case DioExceptionType.connectionError:
              return const ServerFailure('Connection error');
          }
        } else {
          return const ServerFailure('Unexpected error occurred');
        }
      } catch (_) {
        return const ServerFailure('Unexpected error occurred');
      }
    } else {
      return error.toString().contains('is not a subtype of') 
          ? const ServerFailure('Unable to process the data')
          : const ServerFailure('Unexpected error occurred');
    }
  }
}
