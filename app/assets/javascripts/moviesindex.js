document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}


function sortTable() {
  var table, rows, switching, i, x, y, shouldSwitch;
  table = document.getElementById("tablemovies");
  switching = true;
  while (switching) {
    switching = false;
    rows = table.rows;
    for (i = 0; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[1];
      y = rows[i + 1].getElementsByTagName("TD")[1];
      if (parseFloat(x.innerHTML) < parseFloat(y.innerHTML)) {
        shouldSwitch = true;
        break;
      }
    }
    if (shouldSwitch) {
      rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
      switching = true;
    }
  }
}

sortTable()


});
