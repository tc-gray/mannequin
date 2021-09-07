
const fixNavOnScroll = () => {
  const navbar = document.getElementById("navbar");
  const content = document.getElementById("content");
  const brand = document.getElementById("brand");
  const sticky = navbar.offsetTop;

  if (window.pageYOffset > sticky) {
    navbar.classList.add("sticky");
    content.classList.add("pt-5");
    brand.classList.remove("d-none");
  } else {
    navbar.classList.remove("sticky");
    content.classList.remove("pt-5");
    brand.classList.add("d-none");
  }
};


export { fixNavOnScroll };
// export { scrollListner };
