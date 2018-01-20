// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require underscore
//= require gmaps/google
//= require flatpickr
//= require_tree .

// Place all the behaviors and hooks related to the matching controller here.
// All this logaic will automatically be available in application.js.
document.addEventListener("turbolinks:load", function(){

	if (document.querySelector("#user_state") || document.querySelector("#affiliate_state") || document.querySelector("#job_state")){

		const selectedState = document.querySelector("#user_state") || document.querySelector("#affiliate_state") || document.querySelector("#job_state")
		const displayCities = document.querySelector("#user_city") || document.querySelector("#affiliate_city") || document.querySelector("#job_city")
		const showCities = document.querySelector("#show-city")

		const token = document.getElementsByName("csrf-token")[0].content
		
		selectedState.addEventListener("change", function(){

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