/// Enum to define the type of data source used.
enum DataSourceType {
  local,
  network,
  mock,
}

/// Abstract class that acts as a base repository for all repository implementations.
/// It allows defining the default data source type and provides a switch to set the default data source.
///
/// @param <T> The type of data source object used.
abstract class BaseRepository<T> {

  /// Constructor that takes in the default data source type, and data sources,
  BaseRepository({
    required DataSourceType defaultDataSourceType,
    this.localDataSource,
    this.networkDataSource,
    this.mockDataSource,
  }){
    _setDefaultDataSource(defaultDataSourceType);
  }

  /// [defaultDataSourceType] - The type of data source to use by default,
  /// it's just the default, methods are not forced to use this data source.
  /// [localDataSource] - The local data source object.
  /// [networkDataSource] - networkDataSource The network data source object.
  /// [mockDataSource] - The mock data source object.
  late final T? defaultDataSource;
  final T? localDataSource;
  final T? networkDataSource;
  final T? mockDataSource;

  /// Private method to set the default data source based on the provided type.
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
}
