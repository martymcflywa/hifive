using Toybox.Lang;

class ExerciseTest {

  (:test)
  static function constructSuccess(logger) {
    try {
      var name = Rez.Strings.Squat;
      var unitSystem = Rez.Strings.Kilos;
      var weight = 100.0;
      var failures = 0;
      var sut = new Exercise(name, unitSystem, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return false;
    }
    return true;
  }

  (:test)
  static function constructInvalidWeight(logger) {
    try {
      var name = Rez.Strings.BenchPress;
      var unitSystem = Rez.Strings.Kilos;
      var weight = -1;
      var failures = 1;
      var sut = new Exercise(name, unitSystem, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  (:test)
  static function constructInvalidFailures(logger) {
    try {
      var name = Rez.Strings.BenchPress;
      var unitSystem = Rez.Strings.Kilos;
      var weight = 40;
      var failures = 4;
      var sut = new Exercise(name, unitSystem, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  (:test)
  static function addSetSuccess(logger) {
    var name = Rez.Strings.OverheadPress;
    var unitSystem = Rez.Strings.Kilos;
    var weight = 35.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS;
    var sut = new Exercise(name, unitSystem, weight, failures);
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
    var unitSystem = Rez.Strings.Kilos;
    var weight = 100.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS + 1;
    var sut = new Exercise(name, unitSystem, weight, failures);
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
    var unitSystem = Rez.Strings.Kilos;
    var weight = 98.0;
    var failures = 0;
    var sut = new Exercise(name, unitSystem, weight, failures);
    for (var i = 0; i < Exercise.MAX_SETS; i++) {
      sut.addSet(Exercise.MAX_REPS);
    }
    return sut.isDone();
  }

  (:test)
  static function addSetAlreadyCompleted(logger) {
    var name = Rez.Strings.BenchPress;
    var unitSystem = Rez.Strings.Kilos;
    var weight = 52.5;
    var failures = 0;
    var sut = new Exercise(name, unitSystem, weight, failures);
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
    var unitSystem = Rez.Strings.Kilos;
    var weight = 55.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS - 1;
    var sut = new Exercise(name, unitSystem, weight, failures);
    sut.addSet(reps);
    var expected = 1;
    return expected.equals(sut.getFailures());
  }

  (:test)
  static function twoNewFailedSetsDuringAttempt(logger) {
    var name = Rez.Strings.BarbellRow;
    var unitSystem = Rez.Strings.Kilos;
    var weight = 55.0;
    var failures = 0;
    var reps = Exercise.MAX_REPS - 1;
    var sut = new Exercise(name, unitSystem, weight, failures);
    sut.addSet(reps);
    sut.addSet(reps);
    var expected = 1;
    return expected.equals(sut.getFailures());
  }

  (:test)
  static function twoAdditionalFailedSetsDuringAttempt(logger) {
    var name = Rez.Strings.BarbellRow;
    var unitSystem = Rez.Strings.Kilos;
    var weight = 55.0;
    var failures = 1;
    var reps = Exercise.MAX_REPS - 1;
    var sut = new Exercise(name, unitSystem, weight, failures);
    sut.addSet(reps);
    sut.addSet(reps);
    var expected = 2;
    return expected.equals(sut.getFailures());
  }
}