using Toybox.Lang;

class WorkoutControllerTest {

  hidden static var name = Rez.Strings.WorkoutA;
  hidden static var exercises = workoutAExercises();
  hidden static var registry = Registry.WORKOUTS.get(name);
  hidden static var workout = new Workout(name, exercises);

  (:test)
  static function addSetNoCompletedExercises(logger) {
    var sut = new WorkoutController(workout, registry);
    sut.addSet(5);
    var expected = Rez.Strings.Squat;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetOneCompleteExercise(logger) {
    var sut = new WorkoutController(workout, registry);
    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(5);
    }
    var expected = Rez.Strings.BenchPress;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetTwoCompleteExercises(logger) {
    var sut = new WorkoutController(workout, registry);
    for (var i = 0; i < Exercise.MAX_SETS * 2; i++) {
      sut.addSet(5);
    }
    var expected = Rez.Strings.BarbellRow;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetAlreadyComplete(logger) {
    var sut = new WorkoutController(workout, registry);
    for (var i = 0; i < Exercise.MAX_SETS * 3; i++) {
      sut.addSet(5);
    }
    try {
      sut.addSet(5);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  hidden static function workoutARegistry() {
    return [
      Rez.Strings.Squat,
      Rez.Strings.BenchPress,
      Rez.Strings.BarbellRow
    ];
  }

  hidden static function workoutAExercises() {
    var unitSystem = Rez.Strings.Kilos;
    return {
      Rez.Strings.Squat => new Exercise(Rez.Strings.Squat, unitSystem, 95, 0),
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
  }
}