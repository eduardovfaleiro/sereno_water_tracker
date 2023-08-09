part of core;

Future getResult(Future<Result> result) async {
  return await result.then(
    (value) => value.fold((failure) => failure, (success) => success),
  );
}
