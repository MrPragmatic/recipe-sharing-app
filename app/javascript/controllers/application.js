// Import the Application class from the "@hotwired/stimulus" package
import { Application } from "@hotwired/stimulus"

// Start the Stimulus application
const application = Application.start()
// Configure Stimulus development experience by setting debug mode to false
application.debug = false
// Expose the Stimulus application to the global window object
window.Stimulus = application
// Export the Stimulus application for external use
export { application }