///this class will help us to create clones of
///objects which implements them
abstract class Copyable<T> {
  ///this method is used for shallow cloning
  T? copy();

  ///this method is used for deep cloning
  T? copyWith();
}
