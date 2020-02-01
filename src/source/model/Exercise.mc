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

  function incrementSets() {
    sets++;
  }

  function getSets() {
    return sets;
  }

  function incrementFailures() {
    failures++;
  }

  function getFailures() {
    return failures;
  }

  function failAttempt() {
    failedAttempt = true;
  }
  
  function isFailedAttempt() {
    return failedAttempt;
  }

  hidden function isValidWeight(weight) {
    return weight > 0;
  }

  hidden function isValidFailures(failures) {
    return failures < MAX_FAILURES;
  }
}