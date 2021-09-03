import { Controller } from 'stimulus';
import { fixNavOnScroll } from '../plugins/fixed_nav';

export default class extends Controller {
  connect() {
    document.addEventListener("scroll", event => {
      fixNavOnScroll();
    });
  }
};
