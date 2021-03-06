using Toybox.Lang;

class Exercise {
  hidden var name;
  hidden var unitSystem;
  hidden var weight;
  hidden var sets;
  hidden var failures;
  hidden var failedAttempt;

  static const MAX_REPS = 5;
  static const MAX_SETS = 5;
  static const MAX_FAILURES = 3;

  function initialize(name, unitSystem, weight, failures) {
    self.name = name;
    setUnitSystem(unitSystem);
    setWeight(weight);
    sets = 0;
    setFailures(failures);
    failedAttempt = false;
  }

  function getName() {
    return name;
  }

  function getUnitSystem() {
    return unitSystem;
  }

  function getWeight() {
    return weight;
  }

  function setWeight(weight) {
    if (!isValidWeight(weight)) {
      var message = "Weight must be greater than zero";
      throw new Lang.OperationNotAllowedException(message);
    }
    self.weight = weight;
  }

  function addSet(reps) {
    if (!isValidReps(reps)) {
      var message = reps + " reps must be less than or equal to max reps "
          + MAX_REPS;
      throw new Lang.OperationNotAllowedException(message);
    }
    if (isDone()) {
      var message = "Exercise " + name + " is already complete";
      throw new Lang.OperationNotAllowedException(message);
    }
    onFailure(reps);
    sets++;
  }

  function getSets() {
    return sets;
  }

  function isDone() {
    return sets >= MAX_SETS;
  }

  function getFailures() {
    return failures;
  }
  
  function isFailedAttempt() {
    return failedAttempt;
  }

  hidden function onFailure(reps) {
    if (isSetComplete(reps) || isFailedAttempt()) {
      return;
    }
    failedAttempt = true;
    failures++;
  }

  hidden function isSetComplete(reps) {
    return Exercise.MAX_REPS.equals(reps);
  }

  hidden function setUnitSystem(unitSystem) {
    if (!isValidUnitSystem(unitSystem)) {
      var message = "Unsupported unit system " + unitSystem;
      throw new Lang.InvalidOptionsException(message);
    }
    self.unitSystem = unitSystem;
  }

  hidden function isValidUnitSystem(unitSystem) {
    return Rez.Strings.Kilos.equals(unitSystem)
        || Rez.Strings.Pounds.equals(unitSystem);
  }

  hidden function isValidWeight(weight) {
    return weight > 0;
  }

  hidden function setFailures(failures) {
    if (!isValidFailures(failures)) {
      var message = failures
          + " failures must be less than or equal to max failures " 
          + MAX_FAILURES;
      throw new Lang.OperationNotAllowedException(message);
    }
    self.failures = failures;
  }

  hidden function isValidFailures(failures) {
    return failures <= MAX_FAILURES;
  }

  hidden function isValidReps(reps) {
    return reps <= MAX_REPS;
  }
}