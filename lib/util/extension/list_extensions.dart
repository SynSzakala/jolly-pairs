extension AppListExtensions<T> on List<T> {
  List<T> shuffled() => List.of(this)..shuffle();
}
