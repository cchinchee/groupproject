// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

document.addEventListener("turbolinks:load", function(){

	if (document.querySelector("#job_start_date")){
		startDate = document.getElementById("job_start_date")
		startTime = document.getElementById("job_start_time")

		flatpickr(startDate, {altInput:true, minDate: new Date().fp_incr(1)})
		flatpickr(startTime, {altInput: true, enableTime: true, noCalendar: true, dateFormat: "H:i", minDate: "09:00",
    maxDate: "18:00"})
	}

	if (document.querySelector("#job_category")){
		const category = document.querySelector("#job_category")
		const priceInput = document.querySelector("#job_price")
		const token = document.getElementsByName("csrf-token")[0].content

		category.addEventListener("change", function(event){
		
			let request = new XMLHttpRequest();
			request.onreadystatechange = function(response){
				if (request.readyState === XMLHttpRequest.DONE && request.status === 200){
					finalPrice = JSON.parse(request.responseText).chosenPrice
					priceInput.value = finalPrice
				}
			}
			request.open("POST", "/jobs/check", true)
			request.setRequestHeader("X-CSRF-Token", token )
			request.setRequestHeader("Content-type", "application/json; charset=utf-8");
			request.send(JSON.stringify({chosenCategory: event.target.value}))

		})
	}

});