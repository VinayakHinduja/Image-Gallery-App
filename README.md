
# 5Paisa Assessment (Image Gallery App)

## Overview

Image Gallery is a Flutter app that displays a gallery of images fetched from the Picsum API with pagination, allows the user to zoom the Image when the user taps on an image to view it in full-screen.

## Design Choices and Implementation Overview

**1. API Integration:**
To fetch images, I utilized the https://picsum.photos/v2/list?page={page}&limit={limit} API, which allows dynamic fetching of images in a paginated format. This approach is efficient for displaying a large number of images while preventing initial page load delays. By passing the page and limit parameters, the app fetches images in chunks, ensuring that the user does not experience performance issues with a single large request.

- API Request: A simple HTTP request is made to the API, passing the page and limit parameters.
- Data Parsing: The received JSON response is parsed into a structured data model for easier handling within the app.

**2. Pagination:**
The app implements infinite scrolling, which automatically fetches more images when the user scrolls to the bottom of the screen. This approach creates a smooth, seamless user experience by dynamically loading new images without requiring a page refresh or manual intervention.

- Pagination Mechanism: When the scroll reaches the end, an event is triggered to fetch more images. This behavior is controlled via a ScrollController and listeners for the scroll position.
- Loading Indicator: A loading indicator is displayed at the bottom of the screen while new images are being fetched, providing visual feedback to the user that data is being loaded.

**3. Zoomable Image:**
For a rich user experience, tapping on an image opens it in full-screen mode with zoom and pan functionality. This feature enhances the app by allowing users to focus on specific parts of the image in greater detail.

- Zoom and Pan Implementation: I used a combination of gestures like pinch-to-zoom and drag-to-pan to enable zooming and panning. These gestures are handled via Flutter's InteractiveViewer widget, which provides a highly customizable and efficient solution for zoomable images.
- Full-Screen View: The image is displayed in full-screen when tapped, offering a distraction-free experience to view the image up close.

**4. Design:**
The images are displayed in a grid format using a GridView.builder, which allows for efficient rendering and smooth scrolling. The grid layout is responsive, and the number of columns adjusts according to the screen size to ensure the UI remains user-friendly on various devices.

- Error and Loading States: The app shows appropriate UI feedback in case of loading errors or while waiting for data. During loading, a circular progress indicator is shown, and in the case of an error (such as network failure), an error message is displayed.
- Image Display: Images are shown using the CachedNetworkImage widget to handle caching and efficient loading. This improves the performance by reducing network requests and displaying images from the cache if available.

**5. State Management:** 
To manage the app's state and separate concerns, I used the BLoC (Business Logic Component) pattern. This allows for better handling of data fetching, image loading, and error states without cluttering the UI. The BLoC pattern helps in decoupling the business logic from the UI, making the app more maintainable and testable.

**6. Caching for Performance:**
To improve app performance and reduce network calls, I implemented caching using the cached_network_image package. Cached images are stored locally, so the app doesn't need to fetch the same image repeatedly, reducing data usage and speeding up image loading times.

**I have handled the lower compatability of lower sdk devices with the help of ```device_info_plus``` package.**


https://github.com/user-attachments/assets/0cde9e4a-60e5-4f6d-8d95-dbe75ef3940c


## How to Use 

**For Android Devices:-** Download the apk file from Releases or [Download from here](https://github.com/VinayakHinduja/5Paisa-Assessment-Image-Gallery-App/releases/download/Release/Image-Gallery-release.apk).

**Step 1:**

Download the code and extract it.

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run this app:

```
flutter run
```

If you want a release file, run this command:

```
flutter run --release
```

