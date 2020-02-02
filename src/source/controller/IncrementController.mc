using Toybox.Lang;

class IncrementController {
  hidden var unitSystem;
  static const INCREMENT_KG = 2.5;
  static const INCREMENT_LB = 5;

  function initialize(unitSystem) {
    if (!isValidUnitSystem(unitSystem)) {
      var message = "Unsupported unit system " + unitSystem;
      throw new Lang.InvalidOptionsException(message);
    }
    self.unitSystem = unitSystem;
  }

  function setWeight(exercise) {
    var fails = exercise.getFailures();
    if (hasMaxFails(fails)) {
      return;
    }
    var increment = isMetric() ? INCREMENT_KG : INCREMENT_LB;
    var weight = exercise.getWeight() + increment;
    exercise.setWeight(weight);
  }

  hidden function isMetric() {
    return Rez.Strings.Kilos.equals(unitSystem);
  }

  hidden function hasMaxFails(fails) {
    return fails >= Exercise.MAX_FAILURES;
  }

  hidden function isValidUnitSystem(unitSystem) {
    return Rez.Strings.Kilos.equals(unitSystem)
        || Rez.Strings.Pounds.equals(unitSystem);
  }
}
