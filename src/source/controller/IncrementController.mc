using Toybox.Lang;

class IncrementController {
  static const INCREMENT_KG = 2.5;
  static const INCREMENT_LB = 5;

  function addWeight(exercise) {
    var fails = exercise.getFailures();
    if (hasMaxFails(fails)) {
      return;
    }
    var unitSystem = exercise.getUnitSystem();
    var increment = isMetric(unitSystem) ? INCREMENT_KG : INCREMENT_LB;
    var weight = exercise.getWeight() + increment;
    exercise.setWeight(weight);
  }

  hidden function isMetric(unitSystem) {
    return Rez.Strings.Kilos.equals(unitSystem);
  }

  hidden function hasMaxFails(fails) {
    return fails >= Exercise.MAX_FAILURES;
  }
}
