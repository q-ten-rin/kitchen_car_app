// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"
import "./map";
import "./styles/custom.css"
import Raty from "./raty";

window.addEventListener("turbo:load", () => {
  // ★ 投稿フォーム用の星
  const formStar = document.getElementById('post_raty');
  if (formStar && !formStar.dataset.ratyInitialized) {
    const hidden = document.getElementById('post_star');
    const initialScore = parseInt(hidden.value) || 0;  // 数値に変換、空なら0
    new Raty(formStar, {
      score: initialScore,
      starOn: "/images/star-on.png",
      starOff: "/images/star-off.png",
      starHalf: "/images/star-half.png",
      click: (score) => { hidden.value = score; }
    }).init();
    formStar.dataset.ratyInitialized = "true";
  }

  // ★ 詳細ページ用の読み取り専用星
  document.querySelectorAll('.post-show-star').forEach((el) => {
    if (!el.dataset.ratyInitialized) {
      new Raty(el, {
        readOnly: true,
        score: parseInt(el.dataset.score) || 0,
        starOn: "/images/star-on.png",
        starOff: "/images/star-off.png",
        starHalf: "/images/star-half.png"
      }).init();
      el.dataset.ratyInitialized = "true";
    }
  });
});  