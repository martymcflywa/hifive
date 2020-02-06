class WorkoutMapperTest {

  hidden static var unitSystem = Rez.Strings.Kilos;

  (:test)
  static function serializeRoundTrip(logger) {
    var sut = new WorkoutMapper();
    var expected = [workoutA(), workoutB()];
    var serialized = sut.serialize(expected);
    var actual = sut.deserialize(serialized);
    return equals(expected, actual);
  }

  hidden static function equals(a, b) {
    if (a.size() != b.size()) {
      return false;
    }
    for (var i = 0; i < a.size(); i++) {
      if (a[i].getName() != b[i].getName()) {
        return false;
      }
      var aEx = a[i].getExercises().values();
      var bEx = b[i].getExercises().values();
      for (var j = 0; j < aEx.size(); j++) {
        if (aEx[j].getName() != bEx[j].getName()
            || aEx[j].getUnitSystem() != bEx[j].getUnitSystem()
            || aEx[j].getWeight() != bEx[j].getWeight()
            || aEx[j].getFailures() != bEx[j].getFailures()) {
          return false;
        }
      }
    }
    return true;
  }

  hidden static function workoutA() {
    var exercises = {
      Rez.Strings.Squat => new Exercise(
          Rez.Strings.Squat,
          unitSystem,
          95,
          0),
      Rez.Strings.BenchPress => new Exercise(
          Rez.Strings.BenchPress,
          unitSystem,
          50,
          0),
      Rez.Strings.BarbellRow => new Exercise(
          Rez.Strings.BarbellRow,
          unitSystem,
          52,
          0)
    };
    return new Workout(Rez.Strings.WorkoutA, exercises);
  }

  hidden static function workoutB() {
    var exercises = {
      Rez.Strings.Squat => new Exercise(
          Rez.Strings.Squat,
          unitSystem,
          95,
          0),
      Rez.Strings.OverheadPress => new Exercise(
          Rez.Strings.OverheadPress,
          unitSystem,
          32,
          0),
      Rez.Strings.Deadlift => new Exercise(
          Rez.Strings.Deadlift,
          unitSystem,
          105,
          0)
    };
    return new Workout(Rez.Strings.WorkoutB, exercises);
  }
}