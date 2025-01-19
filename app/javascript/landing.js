var wrapper = document.getElementById("wrapper"),
	phone = document.getElementById("phone"),
	iframe = document.getElementById("frame");


function updateView(view) {
	phone.className = "phone view_" + view;
}

setTimeout(() => {
	updateView("3")
}, 1000);
