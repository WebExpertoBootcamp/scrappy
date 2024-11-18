// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "channels"

// app/javascript/packs/scrappy.js

document.addEventListener('DOMContentLoaded', () => {
    const scrappy = document.getElementById('scrappy');

    scrappy.addEventListener('click', () => {
        scrappy.style.transition = 'transform 3s';
        scrappy.style.transform = 'rotate(1080deg)';

        setTimeout(() => {
            window.location.href = '/docs';
        }, 2000);
    });
});
