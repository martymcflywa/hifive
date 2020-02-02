using Toybox.Lang;

class WorkoutControllerTest {

  (:test)
  static function addSetNoCompletedExercises(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();

    var workout = new Workout(name, exercises);
    var registry = workoutARegistry();

    var sut = new WorkoutController(workout, registry);
    sut.addSet(5);
    var expected = registry[0];
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetOneCompleteExercise(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();

    var workout = new Workout(name, exercises);
    var registry = workoutARegistry();

    var sut = new WorkoutController(workout, registry);

    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(5);
    }

    var expected = registry[1];
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetTwoCompleteExercises(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();

    var workout = new Workout(name, exercises);
    var registry = workoutARegistry();

    var sut = new WorkoutController(workout, registry);

    for (var i = 0; i < Exercise.MAX_SETS * 2; i++) {
      sut.addSet(5);
    }

    var expected = registry[2];
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetAlreadyComplete(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();

    var workout = new Workout(name, exercises);
    var registry = workoutARegistry();

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
    var registry = workoutARegistry();
    return {
      registry[0] => new Exercise(registry[0], 95, 0),
      registry[1] => new Exercise(registry[1], 50, 0),
      registry[2] => new Exercise(registry[2], 52, 0)
    };
  }
}