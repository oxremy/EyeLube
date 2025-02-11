# Project Overview

## Goal
Build a macOS Menu Bar application that is simple, energy efficient, and runs locally on the machine. The application will allow the user to fade the screen black when a button is pressed. 

## Core Functionalities

### 1. **Menu Bar Integration**
   - **Menu Item**: The app should reside in the macOS Menu Bar for easy access, with a simple icon (e.g., a button or symbol) that users can click to activate the fade functionality.
   - **Minimal UI**: Upon clicking the icon, it should reveal a minimal menu with one or two options (e.g., "Fade Screen" and "Quit").

### 2. **Screen Fading Functionality**
   - **Smooth Fade**: When the user clicks the "Fade Screen" button, it should gradually darken the screen to black or any level of opacity (depending on user preference).
   - **Toggle Ability**: If clicked again, the screen should gradually fade back to normal, allowing for a toggle-like behavior.
   - **Adjustable Fade Duration**: Users should have the option to control how fast the fade happens (e.g., through a settings menu or slider).

### 3. **Energy Efficiency**
   - **Low System Resource Usage**: The app should be designed to use minimal system resources (e.g., CPU, RAM) and only activate when the user presses the button to fade the screen.
   - **No Background Processes**: Ensure that there are no unnecessary background processes running when the app is idle.

### 4. **Local Operation**
   - **Offline Functionality**: The app should run entirely locally on the user's machine, without requiring an internet connection or external servers.
   - **Local Preferences**: Any settings or configurations (such as fade speed or opacity) should be stored locally, using macOS's standard preferences system.

### 5. **Minimal System Interference**
   - **Low Impact on Other Applications**: The app should not interfere with or block other apps in the foreground. It should ideally create a full-screen black overlay or darken the screen while keeping other UI elements intact.

### 6. **User Preferences**
   - **Settings Panel**: A small settings panel accessible from the Menu Bar where users can adjust the fade speed, opacity, or other preferences.
   - **Launch on Startup**: Option to launch the app automatically when the user logs in to macOS.

### 7. **Exit or Quit Functionality**
   - **Close App Gracefully**: An option in the Menu Bar to quit the app, which should gracefully close and release any resources used.



## Architecture

To design the architecture for the macOS Menu Bar application you described, we'll break it down into logical components that interact in a way that ensures simplicity, energy efficiency, and smooth user experience. Here's an outline for the architecture:

### **1. App Structure**
The overall app will consist of three main components:

1. **User Interface (UI)** – The macOS Menu Bar and any settings windows.
2. **Core Functionality** – The logic behind the screen fading and other essential operations.
3. **System Interactions** – Handling system events like screen overlay, etc.

### **2. Components**

#### **a. Menu Bar Integration**
- **Main Menu Bar App**: A class responsible for managing the app's presence in the macOS Menu Bar. It will handle user interactions (e.g., clicking the icon, showing the menu, etc.).
    - **Components**:
        - **Menu Item**: Represents the button in the Menu Bar.
        - **Menu Options**: Simple options like "Fade Screen" and "Quit" for user actions.
        - **Settings Access**: Option to open the preferences window for fade speed or opacity control.

#### **b. Screen Fading Logic (Core Functionality)**
- **Screen Fader**: A class that controls the fading process. It communicates with macOS’s system frameworks to darken the screen by overlaying a translucent black layer over the entire screen. This layer will use a smooth transition to fade in/out.
    - **Components**:
        - **Fade Method**: Gradually darkens the screen by altering the opacity of the overlay.
        - **Toggle State**: Tracks whether the screen is currently faded in or out and toggles the fade state.
        - **Adjustable Settings**: Fade duration and opacity level, which may be configurable by the user.
        
#### **c. System Interaction Layer**
- **System Event Listener**: A background service that listens for user input and reacts accordingly.
    - **Overlay Management**: A system-wide event listener that activates/deactivates the overlay (fading effect) and ensures it runs smoothly without conflicting with other apps.

#### **d. Preferences Management**
- **Local Settings Storage**: Preferences for fade speed, opacity, and other configurations are stored using macOS's native preference system (e.g., `NSUserDefaults`).
    - **Components**:
        - **Preference Panel**: Allows the user to modify settings (e.g., fade duration or opacity).
        - **Preference Manager**: A singleton responsible for managing and persisting the app settings locally.

### **3. Interaction Flow**

1. **App Launch**:
    - The app starts and initializes the Menu Bar icon.
    - The menu item is clickable, with options like "Fade Screen", "Preferences", and "Quit."

2. **User Interaction**:
    - **Clicking the Menu Icon**:
        - When clicked, the menu appears with options.
        - If "Fade Screen" is pressed, the screen fades to black (or the opacity level set by the user).
        
3. **Screen Fade Action**:
    - The `Screen Fader` class is responsible for handling the fade-in and fade-out actions.
    - The fade effect will use a smooth transition of opacity (e.g., 0% to 100% black) over a defined duration.
    - This will be a non-intrusive overlay, meaning other apps and UI elements remain in place, unaffected by the screen fading.

4. **Preferences**:
    - Users can adjust settings (fade speed, opacity) via a simple settings panel.
    - Preferences are saved locally using `NSUserDefaults`, so they persist across app launches.

5. **App Exit**:
    - The user can quit the app from the Menu Bar.
    - When the app is quit, it should gracefully release any system resources (e.g., stop the screen overlay if it's still active).

### **4. Technology Stack**

- **macOS Frameworks**:
    - **Cocoa**: For building the macOS UI components like the Menu Bar.
    - **AppKit**: To manage the app’s UI and user interactions.
    - **CoreGraphics** (or **Quartz**): For manipulating the screen overlay and controlling the fade effect.
    - **NSUserDefaults**: For saving and loading user preferences.
    
- **Programming Language**: Swift (for native macOS app development).
  
- **Optional**: If additional performance is needed (such as handling screen transitions), you could use **Metal** for GPU acceleration, but for simplicity and energy efficiency, this may not be required.

