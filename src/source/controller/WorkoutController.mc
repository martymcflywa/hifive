using Toybox.Lang;

class WorkoutController {
  hidden var workout;
  hidden var registry;
  hidden var cursor;

  function initialize(workout, registry) {
    self.workout = workout;
    self.registry = registry;
    cursor = 0;
  }

  function addSet(reps) {
    if (isWorkoutDone()) {
      var message = cursor + 1
          + " number of exercises must be less than or equal to "
          + registry.size();
      throw new Lang.OperationNotAllowedException(message);
    }
    var key = registry[cursor];
    var exercise = workout.getExercise(key);
    exercise.addSet(reps);
    if (isExerciseDone(key)) {
      cursor++;
    }
  }

  function getCurrentExercise() {
    var min = min(cursor, registry.size() - 1);
    var key = registry[min];
    var exercise = workout.getExercise(key);
    return exercise.getName();
  }

  hidden function isExerciseDone(key) {
    var exercise = workout.getExercise(key);
    return exercise.isDone();
  }

  hidden function isWorkoutDone() {
    return cursor >= registry.size();
  }

  hidden function min(a, b) {
    return a < b ? a : b;
  }
}