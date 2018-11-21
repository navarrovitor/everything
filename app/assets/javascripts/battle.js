document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}

let baseURL = 'https://api.themoviedb.org/3/';
let configData = null;
let baseImageURL = null;
let keyWord1 = document.getElementsByClassName("movie-title")[0].innerHTML.trim()
let keyWord2 = document.getElementsByClassName("movie-title")[1].innerHTML.trim()
let poster1 = document.getElementsByClassName("poster1")[0]
let poster2 = document.getElementsByClassName("poster2")[0]
let apiKey = '9d3a38e6213072912904012a81c6dddc'

url = ''.concat(baseURL, 'configuration?api_key=', apiKey);

fetch(url)
.then((result)=>{
    return result.json();
})
.then((data)=>{
    baseImageURL = data.images.secure_base_url;
    configData = data.images;
    posterSizes = data.images.poster_sizes
    posterSize = posterSizes[5] //pega um tamanho grande de poster dentre as opcoes
    url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', keyWord1);

    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
        moviePoster = data.results[0].poster_path
        let img_url1 = baseImageURL + posterSize + moviePoster
        poster1.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url('${img_url1}')`
        // poster1.src = baseImageURL + posterSize + moviePoster
    })

    url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', keyWord2);

    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
        moviePoster = data.results[0].poster_path
        let img_url2 = baseImageURL + posterSize + moviePoster
        poster2.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url('${img_url2}')`
    })
})

movie1Id1 = document.getElementById("movie1-select1")
movie2Id1 = document.getElementById("movie2-select1")
movie1Id2 = document.getElementById("movie1-select2")
movie2Id2 = document.getElementById("movie2-select2")
movie1Names = document.getElementsByClassName("movie1-titles")
movie2Names = document.getElementsByClassName("movie2-titles")
movie1Years = document.getElementsByClassName("movie1-years")
movie2Years = document.getElementsByClassName("movie2-years")
movie1Ids = document.getElementsByClassName("movie1-ids")
movie2Ids = document.getElementsByClassName("movie2-ids")
movie1Count = document.getElementById("movie1-count")
movie2Count = document.getElementById("movie2-count")
movie1SwitchBtn = document.getElementById("switchmovie1")
movie2SwitchBtn = document.getElementById("switchmovie2")
movie1Name = document.getElementsByClassName("movie-title")[0]
movie2Name = document.getElementsByClassName("movie-title")[1]
movie1Year = document.getElementsByClassName("movie-year")[0]
movie2Year = document.getElementsByClassName("movie-year")[1]
moviesNotSeen = document.getElementById("movies-not-seen")
moviesNotSeenList1 = document.getElementById("movies-not-seen-list1")
moviesNotSeenList2 = document.getElementById("movies-not-seen-list2")

movie1Counter = parseInt(movie1Count.innerHTML,10)
movie2Counter = parseInt(movie2Count.innerHTML,10)

movie1Id1.value = movie1Ids[movie1Counter].innerHTML
movie2Id1.value = movie2Ids[movie2Counter].innerHTML
movie1Id2.value = movie1Ids[movie1Counter].innerHTML
movie2Id2.value = movie2Ids[movie2Counter].innerHTML

movie1SwitchBtn.addEventListener("click", function() {
  moviesNotSeen.innerHTML = moviesNotSeen.innerHTML + movie1Ids[movie1Count.innerHTML].innerHTML
  moviesNotSeenList1.value = moviesNotSeen.innerHTML
  moviesNotSeenList2.value = moviesNotSeen.innerHTML

  movie1Count.innerHTML = (parseInt(movie1Count.innerHTML,10)+1).toString()
  movie1Counter = parseInt(movie1Count.innerHTML,10)

  movie1Id1.value = movie1Ids[movie1Counter].innerHTML
  movie1Id2.value = movie1Ids[movie1Counter].innerHTML
  movie1Name.innerHTML = movie1Names[movie1Counter].innerHTML
  movie1Year.innerHTML = "(" + movie1Years[movie1Counter].innerHTML.trim() + ")"

  url = ''.concat(baseURL, 'configuration?api_key=', apiKey);

  fetch(url)
  .then((result)=>{
      return result.json();
  })
  .then((data)=>{
      baseImageURL = data.images.secure_base_url;
      configData = data.images;
      posterSizes = data.images.poster_sizes
      posterSize = posterSizes[5] //pega um tamanho grande de poster dentre as opcoes
      url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', movie1Name.innerHTML);

      fetch(url)
      .then(result=>result.json())
      .then((data)=>{
          moviePoster = data.results[0].poster_path
          let img_url1 = baseImageURL + posterSize + moviePoster
          poster1.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url('${img_url1}')`
      })
  })
});

movie2SwitchBtn.addEventListener("click", function() {
  moviesNotSeen.innerHTML = moviesNotSeen.innerHTML + " " + movie2Ids[movie2Count.innerHTML].innerHTML
  moviesNotSeenList1.value = moviesNotSeen.innerHTML
  moviesNotSeenList2.value = moviesNotSeen.innerHTML

  movie2Count.innerHTML = (parseInt(movie2Count.innerHTML,10)+1).toString()
  movie2Counter = parseInt(movie2Count.innerHTML,10)

  movie2Id1.value = movie2Ids[movie2Counter].innerHTML
  movie2Id2.value = movie2Ids[movie2Counter].innerHTML
  movie2Name.innerHTML = movie2Names[movie2Counter].innerHTML
  movie2Year.innerHTML = "(" + movie2Years[movie2Counter].innerHTML.trim() + ")"

  url = ''.concat(baseURL, 'configuration?api_key=', apiKey);

  fetch(url)
  .then((result)=>{
      return result.json();
  })
  .then((data)=>{
      baseImageURL = data.images.secure_base_url;
      configData = data.images;
      posterSizes = data.images.poster_sizes
      posterSize = posterSizes[5] //pega um tamanho grande de poster dentre as opcoes
      url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', movie2Name.innerHTML);

      fetch(url)
      .then(result=>result.json())
      .then((data)=>{
          moviePoster = data.results[0].poster_path
          let img_url2 = baseImageURL + posterSize + moviePoster
          poster2.style.backgroundImage = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url('${img_url2}')`
      })
  })
});









});
