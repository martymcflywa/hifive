class Workout {
  hidden var name;
  hidden var exercises;

  function initialize(name, exercises) {
    self.name = name;
    self.exercises = exercises;
  }

  function getName() {
    return name;
  }

  function getRegistry() {
    return exercises.keys();
  }

  function getExercise(key) {
    return exercises.get(key);
  }

  function getExercises() {
    return exercises;
  }
}