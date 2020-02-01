using Toybox.Lang;

class ExerciseTest {

  (:test)
  static function constructSuccess(logger) {
    try {
      var exercise = Rez.Strings.Squat;
      var weight = 100.0;
      var failures = 0;
      var sut = new Exercise(exercise, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return false;
    }
    return true;
  }

  (:test)
  static function constructInvalidWeight(logger) {
    try {
      var exercise = Rez.Strings.BenchPress;
      var weight = -1;
      var failures = 1;
      var sut = new Exercise(exercise, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }

  (:test)
  static function constructInvalidFailures(logger) {
    try {
      var exercise = Rez.Strings.BenchPress;
      var weight = 40;
      var failures = 3;
      var sut = new Exercise(exercise, weight, failures);
    } catch (e instanceof Lang.OperationNotAllowedException) {
      logger.error(e.getErrorMessage());
      return true;
    }
    return false;
  }
}