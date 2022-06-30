
showMessage();

function showMessage() {
    var el = document.getElementById("message");
    if (el.textContent.trim() === '') {
        return;
    }

    // Make the div visible adding the class show
    el.classList.add("show");

    // Show the toast message for 5 seconds
    setTimeout(function () {
        el.classList.remove("show");
    }, 5000);
}