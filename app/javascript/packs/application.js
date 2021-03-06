// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "controllers";
import "bootstrap";
import 'aos/dist/aos.css';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initStarRating } from '../plugins/init_star_rating';
import { initChatroomCable } from '../channels/chatroom_channel';
import { slideOnScroll } from '../plugins/scroll_slide';
import { initSweetalert } from '../plugins/init_sweetalert';
import { initMapbox } from '../plugins/init_mapbox';
import AOS from 'aos';
// import { scrollListner } from '../plugins/fixed_nav';

document.addEventListener('turbolinks:load', () => {
  initStarRating();
  initChatroomCable();
  slideOnScroll();
  initSweetalert('#sweet-alert-demo', {
    title: "Are you sure?",
    text: "This action cannot be reversed",
    icon: "warning"
  }, (value) => {
    if (value) {
      const link = document.querySelector('#delete-link');
      link.click();
    }
  });
  initSweetalert('#sweet-alert-subscribe', {
    title: "Subscribed!",
    text: "We'll be in touch with you by email shortly",
    icon: "success"
  }, (value) => {
    if (value) {
      const link = document.querySelector('#subscribe-link');
      link.click();
    }
  });
  initMapbox();
  AOS.init();
});
