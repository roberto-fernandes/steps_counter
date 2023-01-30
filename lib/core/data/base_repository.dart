



enum DataSourceType {
  local,
  network,
  mock,
}

abstract class BaseRepository<T> {
  BaseRepository({
    required DataSourceType defaultDataSourceType,
    this.localDataSource,
    this.networkDataSource,
    this.mockDataSource,
  }){
    _setDefaultDataSource(defaultDataSourceType);
  }

  void _setDefaultDataSource(DataSourceType type) {
    switch(type)  {
      case DataSourceType.local:
        defaultDataSource = localDataSource;
        break;
      case DataSourceType.network:
        defaultDataSource = networkDataSource;
        break;
      case DataSourceType.mock:
        defaultDataSource = mockDataSource;
        break;
    }
  }

  final T? localDataSource;
  final T? networkDataSource;
  final T? mockDataSource;
  late final T? defaultDataSource;
}
