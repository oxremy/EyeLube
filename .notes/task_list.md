# Task List

### **High Priority Tasks**
1. **Set Up the Project and Basic App Structure**  
   - Create the project structure in Xcode.
   - Set up basic macOS Menu Bar app architecture using `NSStatusBar` (Menu Bar integration).
   - Implement the basic app lifecycle (launching, running, quitting).

2. **Menu Bar Integration and Basic UI**  
   - Create the Menu Bar icon with the ability to display the app’s menu when clicked.
   - Define the menu options: "Fade Screen", "Preferences", and "Quit".
   - Implement "Quit" functionality that closes the app.

3. **Implement Screen Fading Logic**  
   - Develop the core logic for fading the screen to black.
   - Create an overlay with adjustable opacity and a smooth fade transition (use **CoreGraphics** or **Quartz**).
   - Implement the ability to toggle the screen fade (i.e., fade in and fade out).
   
4. **System Event Listener for Menu Clicks**  
   - Implement the listener for when the user clicks the "Fade Screen" option from the Menu Bar.
   - Set up a basic mechanism to handle keyboard shortcuts (if implemented immediately).
   
5. **Basic Preferences System (NSUserDefaults)**  
   - Set up a simple preferences storage system using `NSUserDefaults` for fade speed and opacity settings.
   - Implement a basic preferences window (if feasible at this stage) or just store default settings initially.
   
6. **Test Basic Functionality**  
   - Ensure that clicking the "Fade Screen" button works as expected (screen fades to black and back).
   - Test that quitting the app closes it gracefully.
   
---

### **Medium Priority Tasks**
1. **Implement Preferences Window for User Settings**  
   - Design and implement a basic preferences window where users can adjust fade speed, opacity, and keyboard shortcuts.
   - Save these preferences to `NSUserDefaults` and apply them when the app is used.

2. **Add Fade Speed and Duration Controls**  
   - Allow users to control how fast the screen fades.
   - Make sure these settings are applied dynamically when the fade effect is triggered.

3. **Handle Keyboard Shortcuts for Screen Fading**  
   - Allow users to set (and later change) a customizable keyboard shortcut to trigger the fade action.
   - Implement the logic to listen for the keyboard shortcut and trigger the fade effect when pressed.

4. **Background Event Listener**  
   - Implement an event listener to detect the user clicking the app’s icon in the Menu Bar or opening the preferences window.
   - Ensure the app behaves consistently when the Menu Bar icon is clicked or when the user interacts with the preferences.
   
5. **Ensure Energy Efficiency**  
   - Minimize unnecessary background processes to ensure the app is energy-efficient when idle.
   - Use macOS features like **App Nap** to limit energy consumption when the app is not actively running the fade effect.

6. **Test Preferences and Customization**  
   - Ensure that fade speed and opacity settings are saved and properly applied after restarting the app.
   - Verify that the user preferences (keyboard shortcut, opacity, fade speed) work as expected.

---

### **Low Priority Tasks**
1. **Add Additional Customization Options**  
   - Allow the user to choose different colors or shades for the fade effect (not just black), providing customization.
   - Add an option to control the opacity level of the fade effect itself (e.g., 20% opaque, 50%, etc.).

2. **Advanced System Preferences Integration**  
   - Integrate with the macOS **System Preferences** so the app can be managed in the system settings for easy access and configuration.
   - Add a system tray or dock icon, if desired, for easier access to settings outside the Menu Bar.

3. **Localization/Internationalization**  
   - If the app is intended for international users, add localization support for different languages.
   
4. **UI Polish and Branding**  
   - Fine-tune the visual design of the Menu Bar icon and any UI elements (such as the preferences window).
   - Create a polished icon for the Menu Bar with smooth animation or transitions (e.g., hover effects).
   
5. **Testing Across macOS Versions**  
   - Ensure compatibility across different versions of macOS (e.g., from macOS Mojave to macOS Ventura) and ensure no compatibility issues arise.
   - Test the app on various hardware configurations (iMac, MacBook, Mac mini).

6. **Add Help/Documentation**  
   - Write a basic user manual or documentation explaining how to use the app (access Menu Bar, trigger fade, adjust preferences).
   - Include in-app help or a simple tutorial for first-time users.

---

### **Completed Tasks**
