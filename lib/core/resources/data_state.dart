abstract class DataState<T> {
  final T? data;
  final String? error;
  const DataState(this.data, this.error);
}

class DateSuccess<T> extends DataState<T> {
  const DateSuccess(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(String? error) : super(null, error);
}
