using Toybox.Application.Storage;

class WorkoutStore {
  hidden var mapper;
  static const KEY = "Workouts";

  function initialize(mapper) {
    self.mapper = mapper;
  }

  function save(workouts) {
    var value = mapper.serialize(workouts);
    Storage.setValue(KEY, value);
  }

  function load() {
    var workouts = Storage.getValue(KEY);
    return mapper.deserialize(workouts);
  }
}