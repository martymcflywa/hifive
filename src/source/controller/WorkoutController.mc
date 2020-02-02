using Toybox.Lang;

class WorkoutController {
  hidden var workout;
  hidden var cursor;

  function initialize(workout) {
    self.workout = workout;
    cursor = 0;
  }

  function addSet(reps) {
    var registry = workout.getRegistry();
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
    var registry = workout.getRegistry();
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
    var registry = workout.getRegistry();
    return cursor >= registry.size();
  }

  hidden function min(a, b) {
    return a < b ? a : b;
  }
}