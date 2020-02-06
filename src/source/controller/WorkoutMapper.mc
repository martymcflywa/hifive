class WorkoutMapper {
  hidden const nameKey = "name";
  hidden const unitSystemKey = "unitSystem";
  hidden const weightKey = "weight";
  hidden const failuresKey = "failures";
  hidden const exercisesKey = "exercises";

  function serialize(workouts) {
    var serialized = [];
    for (var i = 0; i < workouts.size(); i++) {
      var workout = {
        nameKey => workouts[i].getName()
      };
      var exercises = workouts[i].getExercises();
      var values = exercises.values();
      var exArray = [];
      for (var j = 0; j < values.size(); j++) {
        var exMap = {
          nameKey => values[j].getName(),
          unitSystemKey => values[j].getUnitSystem(),
          weightKey => values[j].getWeight(),
          failuresKey => values[j].getFailures()
        };
        exArray.add(exMap);
      }
      workout.put(exercisesKey, exArray);
      serialized.add(workout);
    }
    return serialized;
  }

  function deserialize(workouts) {
    var deserialized = [];
    for (var i = 0; i < workouts.size(); i++) {
      var workoutName = workouts[i].get(nameKey);
      var exArray = workouts[i].get(exercisesKey);
      var exMap = {};
      for (var j = 0; j < exArray.size(); j++) {
        var exerciseName = exArray[j].get(nameKey);
        var unitSystem = exArray[j].get(unitSystemKey);
        var weight = exArray[j].get(weightKey);
        var failures = exArray[j].get(failuresKey);
        var exercise = new Exercise(exerciseName, unitSystem, weight, failures);
        exMap.put(exerciseName, exercise);
      }
      var workout = new Workout(workoutName, exMap);
      deserialized.add(workout);
    }
    return deserialized;
  }
}