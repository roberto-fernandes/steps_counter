
abstract class BaseRepository<T> {
  T? networkDataSource;
  T? storageDataSource;
  T? mockDataSource;
}