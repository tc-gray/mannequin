
const fixNavOnScroll = () => {
  const navbar = document.getElementById("navbar");
  const content = document.getElementById("content");
  const sticky = navbar.offsetTop;

  if (window.pageYOffset > sticky) {
    navbar.classList.add("sticky");
    content.classList.add("pt-5");
  } else {
    navbar.classList.remove("sticky");
    content.classList.remove("pt-5");
  }
};


export { fixNavOnScroll };
// export { scrollListner };
