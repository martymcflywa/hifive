using Toybox.Lang;

class ExerciseController {
  hidden var exercise;

  function setExercise(exercise) {
    self.exercise = exercise;
  }

  function addSet(reps) {
    if (!isValidReps(reps)) {
      var message = reps + " reps must be less than or equal to max reps "
          + Exercise.MAX_REPS;
      throw new Lang.OperationNotAllowedException(message);
    }
    if (isDone()) {
      var message = "Exercise " + exercise.getName() + " is already complete";
      throw new Lang.OperationNotAllowedException(message);
    }
    onFailure(reps);
    exercise.incrementSets();
  }

  function getSets() {
    return exercise.getSets();
  }

  function isDone() {
    return exercise.getSets() >= Exercise.MAX_SETS;
  }

  function getFailures() {
    return exercise.getFailures();
  }

  hidden function onFailure(reps) {
    if (isSetComplete(reps) || exercise.isFailedAttempt()) {
      return;
    }
    exercise.failAttempt();
    exercise.incrementFailures();
  }

  hidden function isValidReps(reps) {
    return reps <= Exercise.MAX_REPS;
  }

  hidden function isSetComplete(reps) {
    return Exercise.MAX_REPS.equals(reps);
  }
}