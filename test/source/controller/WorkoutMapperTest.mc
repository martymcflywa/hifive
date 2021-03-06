class WorkoutMapperTest {

  hidden static var unitSystem = Rez.Strings.Kilos;

  (:test)
  static function serializeRoundTrip(logger) {
    var sut = new WorkoutMapper();
    var expected = [
      TestHelper.workoutA(unitSystem),
      TestHelper.workoutB(unitSystem)];
    var serialized = sut.serialize(expected);
    var actual = sut.deserialize(serialized);
    return TestHelper.equals(expected, actual);
  }
}