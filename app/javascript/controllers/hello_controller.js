// Import the Controller class from the "@hotwired/stimulus" package
import { Controller } from "@hotwired/stimulus";

// Define and export a Stimulus controller class
export default class extends Controller {
  // Define a connect method that gets called when the controller is connected to an element
  connect() {
    // Set the text content of the connected element to "Hello World!"
    this.element.textContent = "Hello World!";
  }
}