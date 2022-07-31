class Ticker{
  const Ticker();
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1),(count) => ticks - count - 1).take(ticks);
  }
}