import 'package:fpdart/fpdart.dart';
import 'package:news_app_lokal/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;

typedef FutureVoid = FutureEither<void>;
