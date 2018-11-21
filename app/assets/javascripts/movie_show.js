document.addEventListener('DOMContentLoaded', function() {

function l(x) {
  return console.log(x)
}

console.clear()

let baseURL = 'https://api.themoviedb.org/3/';
let configData = null;
let baseImageURL = null;
let keyWord = document.getElementsByClassName("movieshow-title")[0].innerHTML.trim()
let moviePoster = document.getElementsByClassName("movieshow-poster")[0]
let movieDescription = document.getElementsByClassName("movieshow-description")[0]
let apiKey = '9d3a38e6213072912904012a81c6dddc'


keyWord = keyWord.replace(/ /g,"+");

l(keyWord)
l(moviePoster)

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
        poster = data.results[0].poster_path
        moviePoster.src = baseImageURL + posterSize + poster
        description = data.results[0].overview
        movieDescription.innerHTML = description
    })

})

});


