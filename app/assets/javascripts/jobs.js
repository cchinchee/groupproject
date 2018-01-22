// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function(){

	if (document.querySelector("#job_start_date")){
		startDate = document.getElementById("job_start_date")
		startTime = document.getElementById("job_start_time")

		flatpickr(startDate, {altInput:true, minDate: new Date().fp_incr(1), inline: true})
		flatpickr(startTime, {altInput: true, enableTime: true, inline:true, noCalendar: true, dateFormat: "H:i", minDate: "09:00",
    maxDate: "18:00"})

		targetCalendar = document.getElementsByClassName("flatpickr-input")[1]
		targetTime = document.getElementsByClassName("flatpickr-input")[3]

		targetCalendar.style.display = "none"
		targetTime.style.display = "none"
	}

	if (document.querySelector("#job_state")){

		const selectedState = document.querySelector("#job_state")
		const displayCities = document.querySelector("#job_city")
		const showCities = document.querySelector("#show-city-job")
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

	if (document.querySelector(".choose-service")){
			let currentBox = document.querySelector(".choose-service .jobimage.chooseThis")
			let container = document.querySelector(".choose-service")
			let priceInput = document.getElementById("job_price")
			let categoryInput = document.getElementById("job_category")
			
			container.addEventListener("click", function (event){
				fired = true
				let target = event.target
				let currentValue = target.value
				let finalPrice = ""
				let array_of_images = document.getElementsByClassName("jobimage")
				let array_of_descriptions = document.getElementsByClassName("description-price")

				let position = 0
				for (i = 0; i < array_of_images.length; i++){
					if (array_of_images[i] == event.target){
						position = i
						// array_of_descriptions[position].style.setProperty("visibility", "visible", "important")
						array_of_descriptions[position].classList.remove("hide-effect");
					}
					else {
						array_of_descriptions[i].style.visibility = "hidden"
					}
				}

				if (target.classList.contains("jobimage")){
					event.preventDefault();
					if (currentValue == "Catering"){
						finalPrice = 100
						selectedCategory = "Catering"
					}	
					else if (currentValue == "Cleaning"){
						finalPrice = 80
						selectedCategory = "Cleaning"
					}				

					else if (currentValue == "Mover"){
						finalPrice = 70
						selectedCategory = "Mover"
					}

					else if (currentValue == "Plumbing"){
						finalPrice = 60
						selectedCategory = "Plumbing"
					}

					else if (currentValue == "Gadget Repair"){
						finalPrice = 150
						selectedCategory = "Gadget Repair"
					}

					priceInput.value = finalPrice
					categoryInput.value = selectedCategory

					currentBox.classList.remove("chooseThis")
					currentBox = target
					currentValue = target.value
					currentBox.classList.add("chooseThis")
				}

			})
				container.addEventListener("mouseover", function(event) {
					array_of_images = document.getElementsByClassName("jobimage")
					array_of_descriptions = document.getElementsByClassName("description-price")
					let position = 0
					for (i = 0; i < array_of_images.length; i++){
						if (array_of_images[i] == event.target){
							position = i
							array_of_descriptions[position].style.visibility = "visible"
						}
						else {
							array_of_descriptions[i].style.visibility = "hidden"
						}
					}

				})
	}

});