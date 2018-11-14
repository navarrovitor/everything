document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}

let baseURL = 'https://api.themoviedb.org/3/';
let configData = null;
let baseImageURL = null;
let keyWord1 = document.getElementsByClassName("movie-title")[0].innerHTML.trim()
let keyWord2 = document.getElementsByClassName("movie-title")[1].innerHTML.trim()
let poster1 = document.getElementsByClassName("poster")[0]
let poster2 = document.getElementsByClassName("poster")[1]
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
        poster1.src = baseImageURL + posterSize + moviePoster
    })

    url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', keyWord2);

    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
        moviePoster = data.results[0].poster_path
        poster2.src = baseImageURL + posterSize + moviePoster
    })
})

});


