function log(x) {
  console.log(x);
}

function getPosters(i, api_url, movie_name_divs, baseURL, apiKey, recommendation_image_cards){
  fetch(api_url)
  .then((result)=>{
    return result.json();
  })
  .then((data) => {
    const baseImageURL = data.images.secure_base_url;
    log("-----------------------");
    log("base image url is:")
    log(baseImageURL);
    log("-----------------------");
    const configData = data.images;
    log("config data is:")
    log(configData);
    log("-----------------------");
    const posterSizes = data.images.poster_sizes
    log("poster sizes are:")
    log(posterSizes);
    log("-----------------------");
    const posterSize = posterSizes[3] //pega um tamanho grande de poster dentre as opcoes
    log("smallest poster size is:")
    log(posterSize);
    log("-----------------------");
    let movie_title = movie_name_divs[i].getElementsByTagName('h3')[0].innerText.split('.')[1].trim();
    log(movie_title)
    let url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', movie_title);
    log(url);
    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
      let movie_poster_path = data.results[0].poster_path;
      log("movie_poster_path:");
      log(movie_poster_path);
      let img_url = baseImageURL + posterSize + movie_poster_path;
      log("image url:");
      log(img_url)
      let background_string = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url("${img_url}")`;
      log("background_string:");
      log(background_string);
      recommendation_image_cards[i].style.backgroundImage = background_string;
    });
  })
};

document.addEventListener('DOMContentLoaded', function() {
  let recommendation_image_cards = document.getElementsByClassName('recommendation');
  let movie_name_divs = document.getElementsByClassName('name');
  let baseURL = 'https://api.themoviedb.org/3/';
  let apiKey = '9d3a38e6213072912904012a81c6dddc';
  let api_url = ''.concat(baseURL, 'configuration?api_key=', apiKey);
  for (let i = 0; i < recommendation_image_cards.length; i++){
    getPosters(i, api_url, movie_name_divs, baseURL, apiKey, recommendation_image_cards);
  }
});
