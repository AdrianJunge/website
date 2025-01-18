document.addEventListener("DOMContentLoaded", () => {
    const menuItems = document.querySelectorAll("#menu li");
  
    menuItems.forEach((item) => {
      item.addEventListener("click", () => {
        const target = item.getAttribute("data-target");
        const laptopScreen = document.getElementById("laptop-screen");
  
        // Add zoom-in effect
        laptopScreen.style.transform = "scale(2)";
        laptopScreen.style.transition = "transform 0.5s ease";
  
        // Fetch content dynamically
        fetch(`/${target}`)
          .then((response) => response.text())
          .then((html) => {
            setTimeout(() => {
              laptopScreen.innerHTML = html;
              laptopScreen.style.transform = "scale(1)";
            }, 500);
          });
      });
    });
});
  