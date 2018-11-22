document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}


function sortTable() {
  var table, rows, switching, i, x, y, shouldSwitch;
  table = document.getElementById("profiletable");
  switching = true;
  while (switching) {
    switching = false;
    rows = table.rows;
    for (i = 0; i < (rows.length - 1); i++) {
      shouldSwitch = false;
      x = rows[i].getElementsByTagName("TD")[3];
      y = rows[i + 1].getElementsByTagName("TD")[3];
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

var percentColors = [
    { pct: 0.0, color: { r: 0xff, g: 0x00, b: 0 } },
    { pct: 0.8, color: { r: 0xff, g: 0xff, b: 0 } },
    { pct: 1.0, color: { r: 0x00, g: 0xff, b: 0 } } ];

var getColorForPercentage = function(pct) {
    for (var i = 1; i < percentColors.length - 1; i++) {
        if (pct <= percentColors[i].pct) {
            break;
        }
    }
    var lower = percentColors[i - 1];
    var upper = percentColors[i];
    var range = upper.pct - lower.pct;
    var rangePct = (pct - lower.pct) / range;
    var pctLower = 1 - rangePct;
    var pctUpper = rangePct;
    var color = {
        r: Math.floor(lower.color.r * pctLower + upper.color.r * pctUpper),
        g: Math.floor(lower.color.g * pctLower + upper.color.g * pctUpper),
        b: Math.floor(lower.color.b * pctLower + upper.color.b * pctUpper)
    };
    return 'rgb(' + [color.r, color.g, color.b].join(',') + ')';
}


allPercentages = document.getElementsByClassName("profile-table-relevance")

relevancePercentageCollection = []

Array.prototype.forEach.call(allPercentages, pct => {
  relevancePercentageCollection.push(parseInt(pct.innerHTML,10)/100)
});

Array.prototype.forEach.call(allPercentages, pct => {
  pct.innerHTML = pct.innerHTML + "<span class='relevance-pct-symbol'>%</span>"
});

Array.prototype.forEach.call(allPercentages, pct => {
  pct.style.color = getColorForPercentage(relevancePercentageCollection[0])
  relevancePercentageCollection.shift()
});



//Profile styling according to position
profileList = document.getElementsByClassName("each-profile")
profileTable = document.getElementById("profiletable")
count = 0;

Array.prototype.forEach.call(profileList, profile => {
  if (count === 0) {
    profile.getElementsByClassName("profile-position")[0].innerHTML = `<span class='profile-position-number'>1</span><span class='profile-position-placer'>st</span>`
  } else if (count === 1) {
    profile.getElementsByClassName("profile-position")[0].innerHTML = `<span class='profile-position-number'>2</span><span class='profile-position-placer'>nd</span>`
  } else if (count === 2) {
    profile.getElementsByClassName("profile-position")[0].innerHTML = `<span class='profile-position-number'>3</span><span class='profile-position-placer'>rd</span>`
  } else {
    profile.getElementsByClassName("profile-position")[0].innerHTML = `<span class='profile-position-number'>${count+1}</span><span class='profile-position-placer'>th</span>`
  }
  count += 1;
});


});
