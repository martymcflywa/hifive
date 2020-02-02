using Toybox.Lang;

class IncrementControllerTest {

  hidden static var unitSystem = Rez.Strings.Kilos;

  (:test)
  static function addWeightIsIncremented(logger) {
    var weight = 100;
    var exercise = new Exercise(Rez.Strings.Squat, unitSystem, weight, 0);
    var sut = new IncrementController();
    sut.addWeight(exercise);
    var expected = weight + IncrementController.INCREMENT_KG;
    var actual = exercise.getWeight();
    return expected.equals(actual);
  }

  (:test)
  static function addWeightNotIncremented(logger) {
    var expected = 102.5;
    var exercise = new Exercise(Rez.Strings.Squat, unitSystem, expected, 3);
    var sut = new IncrementController();
    sut.addWeight(exercise);
    var actual = exercise.getWeight();
    return expected.equals(actual);
  }
}