// Search on enter key event
Keys = {
  Tab: 9,
  Enter: 13,
  Escape: 27,
  Space: 32,
  i: 73,
}

App = {
  search: function(event) {
    if (event.keyCode === Keys.Enter) {
      var val = document.getElementById('search-field').value;
      window.location = 'https://google.com/search?q=' + val;
      document.getElementById('search-field').value = '';
      document.getElementById('search-field').blur();
      document.getElementById('search').style.display = 'none';
    } else {
      App.displayBookmarkSearch()
    }
  },

  handleKeys: function(event) {
    if (event.keyCode === Keys.Enter && ! document.getElementById('search-field').activeElement) {
      // focus search input
      document.getElementById('search').style.display = 'flex';
      document.getElementById('search-field').focus();
      document.getElementById('search-field').value = ''
    } else if (event.keyCode == Keys.Escape) {
      // Esc to close search
      document.getElementById('search-field').value = '';
      document.getElementById('search-field').blur();
      document.getElementById('search').style.display = 'none';
      App.clearPreviousBookmarkSearchResults()
    } else if (event.keyCode === Keys.Tab){
      event.preventDefault()
      let firstResultElem = document.getElementsByClassName('bookmark-search-result')[0]
      window.location = firstResultElem.getAttribute('href')
    }
  },

  filterBookmarkSearch: function(){
    let retval = []
    let elems = document.getElementsByClassName('bookmark')
    let val = document.getElementById('search-field').value
    for (let i=0 ; i<elems.length ; i++){
      let elem = elems[i]
      if (elem.text.toLowerCase().includes(val.toLowerCase())){
        let obj = { text: elem.text, href: elem.href }
        retval.push(obj)
      }
    }
    return retval
  },

  displayBookmarkSearch: function(){
    App.clearPreviousBookmarkSearchResults()
    let searchResultContainerElem = document.getElementById('search-result-container')
    let results = App.filterBookmarkSearch()
    results.forEach((result) => {
      let resultElem = document.createElement('div')
      resultElem.className = 'bookmark-search-result'
      resultElem.setAttribute('href', result.href)
      resultElem.innerHTML = result.text
      searchResultContainerElem.appendChild(resultElem)
    })
  },

  clearPreviousBookmarkSearchResults: function(){
    let elems = document.getElementsByClassName('bookmark-search-result')
    while (elems.length > 0){
      elems[0].remove()
    }
  },

  // Get current time and format
  getTime: function() {
    var date = new Date();
    return date.toLocaleString('en-US', {
      hour: 'numeric',
      minute: 'numeric',
      hour12: true
    });
  },

  getWeatherIcon: function(iconCode) {
    var dayNight = iconCode.slice(2, 3);
    console.log(dayNight);
    var code = iconCode.slice(0, 2);
    if (dayNight == 'd') {
      switch (code) {
        case '01':
          return 'icons/sunny.png';
        case '02':
          return 'icons/partly_cloudy.png';
        case '03':
          return 'icons/cloudy.png';
        case '04':
          return 'icons/cloudy_s_sunny.png';
        case '09':
          return 'icons/rain_s_cloudy.png';
        case '10':
          return 'icons/rain.png';
        case '11':
          return 'icons/thunderstorms.png';
        case '13':
          return 'icons/snow.png';
        case '50':
          return 'icons/mist.png';
        default:
          return null;
      }
    } else {
      switch (code) {
        case '01':
          return 'icons/night.png';
        case '02':
          return 'icons/night_partly_cloudy.png';
        case '03':
          return 'icons/cloudy.png';
        case '04':
          return 'icons/cloudy_night.png';
        case '09':
          return 'icons/rain_night.png';
        case '10':
          return 'icons/rain.png';
        case '11':
          return 'icons/thunderstorms.png';
        case '13':
          return 'icons/night_snow.png';
        case '50':
          return 'icons/mist.png';
        default:
          return null;
      }
    }
  },

  getWeather: function() {
    let xhr = new XMLHttpRequest();
    /* OPEN WEATHER MAP */
    xhr.open(
      'GET',
      'https://api.openweathermap.org/data/2.5/weather?id=2158177&appid=2d33137dd0ae28b599bdcedc827a9560&units=imperial&lat=38.424750&lon=-121.962940'
    );
    xhr.onload = () => {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          let json = JSON.parse(xhr.responseText);
          var temp = json.main.feels_like.toFixed(0) + '&deg;F';
          var weatherDescription = json.weather[0].description;
          var weatherIcon = App.getWeatherIcon(json.weather[0].icon);
          if (weatherIcon) {
            document.getElementById('weather').innerHTML =
              weatherDescription + ', feels like ' + temp;
            document.getElementById('weather-icon').src = weatherIcon;
          } else {
            document.getElementById('weather').innerHTML =
              weatherDescription + '  ' + temp;
          }
        } else {
          console.log('error msg: ' + xhr.status);
        }
      }
    };

    xhr.send();
  },

  init: function() {
    /* CLOCK */
    document.getElementById('clock').innerHTML = App.getTime();
    setInterval(() => {
      document.getElementById('clock').innerHTML = App.getTime();
    }, 30000);

    /* Weather */
    App.getWeather();

    /* EVENT LISTENERS */
    // search when the enter key is pressed
    var searchField = document.getElementById('search-field');
    searchField.addEventListener('keyup', event => {
      return App.search(event);
    });

    // search field shorcut
    document.addEventListener('keyup', event => {
      App.handleKeys(event)
    });
  }
};

window.onload = App.init();
