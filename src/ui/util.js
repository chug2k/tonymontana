
// List of utility functions for the UI
var util = {

  // date formatting goes to presenter layer, not inside model
  timeformat: function(time) {
    var d = new Date(time);
    return d.getFullYear() + "/" + (d.getMonth() + 1) +  "/" + d.getDate();
  }

};
