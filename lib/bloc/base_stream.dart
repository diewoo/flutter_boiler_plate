import 'package:rxdart/rxdart.dart';

import '../api_service/base_http_exception.dart';
import 'base_repository.dart';

class BaseStream<T> extends BaseRepository {
  BehaviorSubject<T> _controller;
  BaseStream([T initialData]) {
    _controller = BehaviorSubject<T>();
    if (initialData != null) {
      this.addData(initialData);
    }
  }

  BehaviorSubject<T> get stream => _controller.stream;

  bool get hasData => _controller.hasValue;

  void addData(T data) {
    if (!_controller.isClosed) _controller.add(data);
  }

  Future<T> asyncOperation(
    Future<T> Function() doingOperation, {
    bool loadingOnRefresh = false,
  }) async {
    try {
      if (loadingOnRefresh) this.addData(null);
      T data = await doingOperation();
      this.addData(data);
      return data;
    } on TypeError catch (_) {
      this.addError("Something went wrong!");
      return null;
    } on BaseHttpException catch (exception) {
      this.addError(exception.toString());
      return null;
    }
  }

  void addError(String error) {
    if (!_controller.isClosed) _controller.addError(error);
  }

  void dispose() async {
    _controller.close();
  }
}