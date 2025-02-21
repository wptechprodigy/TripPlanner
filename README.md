# **Trip Planner App**

## **Table of Contents**
1. [Introduction](#introduction)
2. [Features](#features)
3. [Installation](#installation)
4. [Dependencies](#dependencies)
5. [Project Structure](#project-structure)
6. [API Integration](#api-integration)
7. [Usage](#usage)
8. [Testing](#testing)
9. [Submission Guidelines](#submission-guidelines)

---

## **Introduction**

The **Trip Planner App** is an iOS application designed to allow users to browse and create trip plans. The app integrates with a RESTful API to fetch and display food items (for demonstration purposes) and allows users to add new trips by filling out a form. The UI is built using both **Programmatic UIKit** and **SwiftUI**, ensuring flexibility and responsiveness across different screen sizes.

This project was developed as part of an iOS Developer Interview Test. It adheres closely to the provided Figma design and integrates with the specified API endpoint.

---

## **Features**

- **Home Screen**:
  - Displays a list of food items fetched from the API.
  - Includes a user profile section, search bar, and category buttons.
  - A Floating Action Button (FAB) navigates to the Trip Details screen.

- **Trip Details Screen**:
  - Allows users to input trip details such as destination, date, and description.
  - Validates user inputs before sending them to the API.
  - Provides feedback on the success or failure of trip creation.

- **API Integration**:
  - Fetches food items from the provided API endpoint.
  - Sends trip details to the API for storage.

- **Responsive Design**:
  - The app is optimized for various screen sizes and orientations.

---

## **Installation**

### **Prerequisites**
- macOS with Xcode installed (version 13 or higher).
- CocoaPods installed (`sudo gem install cocoapods`).

### **Steps to Set Up the Project**

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   ```
2. **Install Dependencies**:
    Navigate to the project directory and install the required dependencies using CocoaPods:
    ```bash
    cd TripPlanner
    pod install
    ```
3. **Open the Workspace**:
    Open the _.xcworkspace_ file in Xcode:
    ```bash
    open TripPlanner.xcworkspace
    ```

4. **Run the App**:
    Select a simulator or connect a physical device.
    Press _Command + R_ to build and run the app.
    
### Dependencies
The following third-party libraries are used in the project:

- Alamofire : Simplifies networking tasks such as API requests.
- SDWebImage : Handles asynchronous image loading and caching.

These dependencies are managed via CocoaPods . Ensure you run _pod install_ after cloning the repository.

### Project Structure
The project is organized into the following folders:

- Views : Contains all UI-related files, including both UIKit and SwiftUI views.
- Models : Defines data models for the API response.
- Network : Handles API requests and responses.
- Utilities : Includes helper functions.
- Extensions: Icludes extensions for added functionalities.
- Assets : Stores images, fonts, and other resources.
- Tests : Unit tests for the app's functionality.

### API Integration
The app integrates with the following API endpoints:

1. Fetch Food Items :
    - Endpoint : https://assessment.vgtechdemo.com/api/foods
    - Method : GET
    - Response : A JSON array of food items with fields like id, title, calories, description, tags, and image_url.

2. Create a Trip :
    - Endpoint : https://documenter.getpostman.com/view/37114545/2sAYXCkeW7/trips
    - Method : POST
    - Request Body : JSON object containing destination, date, and description.
    - Response : The created trip object.
    
### Usage
**Home Screen**
- Displays a list of food items fetched from the API.
- Use the search bar to filter food items (future enhancement).
- Tap on a  food item to navigate to the Trip Details screen.

**Trip Details Screen**
(Not implemennted yet)
- Enter trip details such as destination, date, and description.
- Tap the "Save" button to send the data to the API.
- If successful, the app clears the form and displays a success message. If an error occurs, an alert is shown.

### Testing
**Unit Tests**
The project includes unit tests for key functionalities such as:

- API request handling.
- Data model decoding.
-  UI component behavior.

To run the tests:

- Open the _.xcworkspace_ file in Xcode.
- Press Command + U to execute all tests.

Manual Testing
- Test the app on different simulators and devices to ensure responsiveness.
- Verify that API requests succeed
