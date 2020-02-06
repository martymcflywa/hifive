class WorkoutStoreTest {

  hidden static var unitSystem = Rez.Strings.Kilos;
  hidden static var mapper = new WorkoutMapper();

  (:test)
  static function saveLoadRoundTrip(logger) {
    var sut = new WorkoutStore(mapper);
    var expected = [
      TestHelper.workoutA(unitSystem),
      TestHelper.workoutB(unitSystem)];
    sut.save(expected);
    var actual = sut.load();
    return TestHelper.equals(expected, actual);
  }
}