using Toybox.Lang;

class WorkoutControllerTest {

  (:test)
  static function addSetNoCompletedExercises(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();
    var workout = new Workout(name, exercises);
    var sut = new WorkoutController(workout);
    sut.addSet(5);
    var expected = Rez.Strings.Squat;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetOneCompleteExercise(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();
    var workout = new Workout(name, exercises);
    var sut = new WorkoutController(workout);
    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(5);
    }
    var expected = Rez.Strings.BenchPress;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetTwoCompleteExercises(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();
    var workout = new Workout(name, exercises);
    var sut = new WorkoutController(workout);
    for (var i = 0; i < Exercise.MAX_SETS * 2; i++) {
      sut.addSet(5);
    }
    var expected = Rez.Strings.BarbellRow;
    return expected.equals(sut.getCurrentExercise());
  }

  (:test)
  static function addSetAlreadyComplete(logger) {
    var name = Rez.Strings.WorkoutA;
    var exercises = workoutAExercises();
    var workout = new Workout(name, exercises);
    var sut = new WorkoutController(workout);
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

  hidden static function workoutAExercises() {
    return {
      Rez.Strings.Squat => new Exercise(Rez.Strings.Squat, 95, 0),
      Rez.Strings.BenchPress => new Exercise(Rez.Strings.BenchPress, 50, 0),
      Rez.Strings.BarbellRow => new Exercise(Rez.Strings.BarbellRow, 52, 0)
    };
  }
}