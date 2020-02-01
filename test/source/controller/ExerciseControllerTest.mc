using Toybox.Lang;

class ExerciseControllerTest {

  (:test)
  static function addSetSuccess(logger) {
    var name = Rez.Strings.OverheadPress;
    var weight = 35.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    try {
      sut.addSet(reps);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return false;
    }
    return true;
  }

  (:test)
  static function addSetInvalidReps(logger) {
    var name = Rez.Strings.Deadlift;
    var weight = 100.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS + 1;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    try {
      sut.addSet(reps);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  (:test)
  static function addSetToCompletion(logger) {
    var name = Rez.Strings.Squat;
    var weight = 98.0;
    var failures = 0;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(Exercise.MAX_REPS);
    }
    return sut.isDone();
  }

  (:test)
  static function addSetAlreadyCompleted(logger) {
    var name = Rez.Strings.BenchPress;
    var weight = 52.5;
    var failures = 0;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(Exercise.MAX_REPS);
    }
    try {
      sut.addSet(Exercise.MAX_REPS);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  (:test)
  static function oneNewFailedSetDuringAttempt(logger) {
    var name = Rez.Strings.BarbellRow;
    var weight = 55.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS - 1;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    sut.addSet(reps);
    var expected = 1;
    return expected.equals(sut.getFailures());
  }

  (:test)
  static function twoNewFailedSetsDuringAttempt(logger) {
    var name = Rez.Strings.BarbellRow;
    var weight = 55.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS - 1;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    sut.addSet(reps);
    sut.addSet(reps);
    var expected = 1;
    return expected.equals(sut.getFailures());
  }

  (:test)
  static function twoAdditionalFailedSetsDuringAttempt(logger) {
    var name = Rez.Strings.BarbellRow;
    var weight = 55.0;
    var failures = 1;
    var reps = Exercise.MAX_REPS - 1;
    var exercise = new Exercise(name, weight, failures);
    var sut = new ExerciseController();
    sut.setExercise(exercise);
    sut.addSet(reps);
    sut.addSet(reps);
    var expected = 2;
    return expected.equals(sut.getFailures());
  }
}