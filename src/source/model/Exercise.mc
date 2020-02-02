using Toybox.Lang;

class Exercise {
  hidden var name;
  hidden var weight;
  hidden var sets;
  hidden var failures;
  hidden var failedAttempt;

  static const MAX_REPS = 5;
  static const MAX_SETS = 5;
  static const MAX_FAILURES = 3;

  function initialize(name, weight, failures) {
    if (!isValidWeight(weight)) {
      var message = "Weight must be greater than zero";
      throw new Lang.OperationNotAllowedException(message);
    }
    if (!isValidFailures(failures)) {
      var message = failures + " failures must be less than max failures " 
          + MAX_FAILURES;
      throw new Lang.OperationNotAllowedException(message);
    }
    self.name = name;
    self.weight = weight;
    sets = 0;
    self.failures = failures;
    failedAttempt = false;
  }

  function getName() {
    return name;
  }

  function getWeight() {
    return weight;
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

  hidden function isValidWeight(weight) {
    return weight > 0;
  }

  hidden function isValidFailures(failures) {
    return failures < MAX_FAILURES;
  }

  hidden function isValidReps(reps) {
    return reps <= MAX_REPS;
  }
}