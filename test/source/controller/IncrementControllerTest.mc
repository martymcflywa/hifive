using Toybox.Lang;

class IncrementControllerTest {

  (:test)
  static function setWeightIsIncremented(logger) {
    var unitSystem = Rez.Strings.Kilos;
    var weight = 100;
    var exercise = new Exercise(Rez.Strings.Squat, weight, 0);
    var sut = new IncrementController(unitSystem);
    sut.setWeight(exercise);
    var expected = weight + IncrementController.INCREMENT_KG;
    var actual = exercise.getWeight();
    return expected.equals(actual);
  }

  (:test)
  static function setWeightNotIncremented(logger) {
    var unitSystem = Rez.Strings.Kilos;
    var expected = 102.5;
    var exercise = new Exercise(Rez.Strings.Squat, expected, 3);
    var sut = new IncrementController(unitSystem);
    sut.setWeight(exercise);
    var actual = exercise.getWeight();
    return expected.equals(actual);
  }
}