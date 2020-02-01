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

  function getExercise(key) {
    return exercises.get(key);
  }
}