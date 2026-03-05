sealed class Result<S, F> {
  const Result();

  B fold<B>(B Function(F f) ifFailure, B Function(S s) ifSuccess);
}

class Success<S, F> extends Result<S, F> {
  final S value;
  const Success(this.value);

  @override
  B fold<B>(B Function(F f) ifFailure, B Function(S s) ifSuccess) => ifSuccess(value);
}

class Error<S, F> extends Result<S, F> {
  final F failure;
  const Error(this.failure);

  @override
  B fold<B>(B Function(F f) ifFailure, B Function(S s) ifSuccess) => ifFailure(failure);
}
