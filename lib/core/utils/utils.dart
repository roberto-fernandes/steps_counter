///  Async function to add delay.
///  [milliseconds] - Number of milliseconds to delay. Default is 200.
///  returns a future that completes after the specified delay.
Future<void> awaitDelay({int milliseconds = 200}) async {
  return await Future.delayed(Duration(milliseconds: milliseconds));
}
