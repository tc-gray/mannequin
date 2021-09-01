// import the jQuery plugin and its JS functionality
import "jquery-bar-rating";
import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initStarRating = () => {
  // TODO
  // the below is the equivalent of doing
  // document.querySelector('#product_review_rating')
  // or document.getElementById('product_review_rating')
  $('#product_review_rating').barrating({
    theme: 'css-stars'
  });
};

export { initStarRating };
