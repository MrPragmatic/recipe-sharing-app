document.addEventListener('DOMContentLoaded', function () {
    var videoContainer = document.getElementById('video-container');
    var recipeVideo = document.getElementById('recipe-video');

    // Check if recipe.video_url is present
    if (recipeVideo.src.startsWith("https://www.youtube.com/embed/[")) {
        videoContainer.style.display = 'none';
    } else {
    }
});