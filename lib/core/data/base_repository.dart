



enum DataSourceType {
  local,
  network,
  mock,
}

abstract class BaseRepository<T> {
  BaseRepository({
    this.localDataSource,
    this.networkDataSource,
    this.mockDataSource,
    DataSourceType defaultDataSourceType = DataSourceType.local,
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
