document.addEventListener("turbolinks:load", function(){
	if (document.querySelector("#user_state")){

		var selectedState = document.querySelector("#user_state")
		var displayCities = document.querySelector("#user_city")
		var showCities = document.querySelector("#show-city-user")
		var token = document.getElementsByName("csrf-token")[0].content

		selectedState.addEventListener("change", function(){

			showCities.style.display = "block"
			var request = new XMLHttpRequest();
			request.onreadystatechange = function (response){
				if (request.readyState === XMLHttpRequest.DONE && request.status === 200){
					var cities = JSON.parse(request.responseText).available_cities

						while (displayCities.hasChildNodes()){
							displayCities.removeChild(displayCities.lastChild)
						}

						for (var i = 0; i < cities.length; i++){
							var opt = document.createElement('option')
							opt.value = cities[i]
							opt.innerHTML = cities[i]
							displayCities.appendChild(opt);
						}
				}

			}	
			request.open("POST", "/states/check", true);
			request.setRequestHeader("X-CSRF-Token", token )
			request.setRequestHeader("Content-type", "application/json; charset=utf-8");
			request.send(JSON.stringify({chosenState: selectedState.value}))
		});
	}
})