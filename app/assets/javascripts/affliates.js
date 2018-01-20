// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function(){
	if (document.querySelector("#affiliate_state")){
		
		const selectedState = document.getElementById("affiliate_state")
		const displayCities = document.getElementById("affiliate_city")
		const showCities = document.getElementById("show-city-affiliate")
		const token = document.getElementsByName("csrf-token")[0].content

		selectedState.addEventListener("change", function(){
			console.log(showCities)
			showCities.style.display = "block"
			let request = new XMLHttpRequest();
			request.onreadystatechange = function (response){
				if (request.readyState === XMLHttpRequest.DONE && request.status === 200){
					let cities = JSON.parse(request.responseText).available_cities

						while (displayCities.hasChildNodes()){
							displayCities.removeChild(displayCities.lastChild)
						}

						for (let i = 0; i < cities.length; i++){
							let opt = document.createElement('option')
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