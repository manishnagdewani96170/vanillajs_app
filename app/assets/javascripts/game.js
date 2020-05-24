function addData(timer_value, image_url) {
  var newRow = document.createElement('tr');
  var timerCell = document.createElement('td');
  var imageUrlCell = document.createElement('td');
  timerCell.innerHTML = timer_value;
  imageUrlCell.innerHTML = "<img name='image' src='"+image_url+"' width='50' height='50'/>";
  newRow.append(timerCell);
  newRow.append(imageUrlCell);
  document.getElementById('tbody').appendChild(newRow);
}

function getInitialData(){
  var images = [];
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      images = JSON.parse(this.responseText);
    }
  };
  xhr.open('GET', '/attachments', true);
  xhr.send();

  var timeleft = 10;
  var downloadTimer = setInterval(function(){
    document.getElementsByTagName('h1')[0].innerHTML = timeleft;
    if(images.length > 0){
      var selected_image = images[10 - timeleft]; 
      document.getElementById('image').src = selected_image;
    }
    if(timeleft == 1){
      timeleft = 10;
    }else{
      timeleft -= 1;
    }    
  }, 1000);
}

var body = document.getElementsByTagName('body')[0];
body.onload = getInitialData();


document.getElementById('play').addEventListener('click', function(){
  var timer_value = document.getElementsByTagName('h1')[0].innerHTML;
  var image_url = document.getElementsByTagName('img')[0].src;
  var xhr = new XMLHttpRequest();
  xhr.onreadystatechange = function() {
    if (xhr.readyState === 4){
      console.log(this.responseText);
      addData(timer_value, image_url);
    }
  };
  xhr.open('POST', '/plays', true);
  xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
  var token = document.getElementsByName('csrf-token')[0].content;
  if (token) xhr.setRequestHeader('X-CSRF-Token', token);
  xhr.send('play[timer_value]='+ timer_value +'&play[image_url]='+ image_url);
});
  