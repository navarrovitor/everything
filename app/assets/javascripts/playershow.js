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
    const configData = data.images;
    const posterSizes = data.images.poster_sizes
    const posterSize = posterSizes[3] //pega um tamanho grande de poster dentre as opcoes
    let movie_title = movie_name_divs[i].getElementsByTagName('h3')[0].innerText.split('.')[1].trim();
    let url = ''.concat(baseURL, 'search/movie?api_key=', apiKey, '&query=', movie_title);
    fetch(url)
    .then(result=>result.json())
    .then((data)=>{
      let movie_poster_path = data.results[0].poster_path;
      let img_url = baseImageURL + posterSize + movie_poster_path;
      let background_string = `linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.2)), url("${img_url}")`;
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
