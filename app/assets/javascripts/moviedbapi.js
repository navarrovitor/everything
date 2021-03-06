document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}

let baseURL = 'https://api.themoviedb.org/3/';
let configData = null;
let baseImageURL = null;
let keyWord = document.getElementById("keyword-hidden").innerHTML.trim()
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

    url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', keyWord);
    l(url)

    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
        movieName = data.results[0].original_title
        movieDescription = data.results[0].overview
        moviePoster = data.results[0].poster_path

        //Movie name
        document.getElementsByClassName("movie-name")[0].innerHTML = movieName
        //Pic UR
        document.getElementsByClassName("movie-poster")[0].src = baseImageURL + posterSize + moviePoster
        //Movie description
        document.getElementsByClassName("movie-description")[0].innerHTML = movieDescription
    })
})





});


