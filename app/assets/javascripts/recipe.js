// Execute the following code when the DOM has finished loading
document.addEventListener('DOMContentLoaded', function () {
    // Get the HTML element with the id 'video-container' and store it in the variable 'videoContainer'
    let videoContainer = document.getElementById('video-container');
    // Get the HTML element with the id 'recipe-video' and store it in the variable 'recipeVideo'
    let recipeVideo = document.getElementById('recipe-video');
    // Check if the 'recipeVideo' source starts with "https://www.youtube.com/embed/[" indicating a YouTube video
    if (recipeVideo.src.startsWith("https://www.youtube.com/embed/[")) {
        // If it's a YouTube video, set the 'display' style property of 'videoContainer' to 'none'
        videoContainer.style.display = 'none';
    } else {
        // If it's not a YouTube video, no specific action is taken (empty block)
    }
});