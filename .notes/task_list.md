# Task List

### **High Priority Tasks**
1. **Set Up the Project and Basic App Structure**  
   - [x] Create the project structure in Xcode.
   - [x] Set up basic macOS Menu Bar app architecture using `NSStatusBar`
   - [x] Implement the basic app lifecycle (launching, running, quitting)

2. **Menu Bar Integration and Basic UI**  
   - [x] Create the Menu Bar icon with menu
   - [x] Define menu options: "Fade Screen", "Quit"
   - [x] Implement "Quit" functionality

3. **Implement Screen Fading Logic**  
   - [x] Develop core fading logic
   - [x] Create adjustable opacity overlay
   - [x] Implement toggle functionality
   
4. **System Event Listener for Menu Clicks**  
   - [x] Menu click listener implemented
   - [x] Basic keyboard shortcut mechanism

5. **Basic Preferences System**  
   - [x] Core storage with `NSUserDefaults`
   - [x] Preferences window implemented

6. **Test Basic Functionality**  
   - [x] Test fade functionality
   - [x] Test app quitting

---

### **Medium Priority Tasks**
1. **Implement Preferences Window**  
   - [x] Fully implemented with UI controls

2. **Add Fade Speed Controls**  
   - [x] Duration slider in preferences

3. **Handle Keyboard Shortcuts**  
   - [x] Customizable shortcuts with KeyboardShortcuts

4. **Background Event Listener**  
   - [x] Preferences changes observed
   - [ ] Full background event handling

5. **Ensure Energy Efficiency**  
   - [x] App Nap integration
   - [x] No background processes

6. **Test Preferences**  
   - [x] Basic preference persistence
   - [ ] Full test coverage

---

### **Low Priority Tasks**
1. **Add Additional Customization Options**  
   - [x] Allow the user to choose different colors or shades for the fade effect (not just black), providing customization.
   - [x] Add an option to control the opacity level of the fade effect itself (e.g., 20% opaque, 50%, etc.).

2. **Advanced System Preferences Integration**  
   - [x] Integrate with the macOS **System Preferences** so the app can be managed in the system settings for easy access and configuration.
   - [x] Add a system tray or dock icon, if desired, for easier access to settings outside the Menu Bar.

3. **Localization/Internationalization**  
   - [x] If the app is intended for international users, add localization support for different languages.
   
4. **UI Polish and Branding**  
   - [x] Fine-tune the visual design of the Menu Bar icon and any UI elements (such as the preferences window).
   - [x] Create a polished icon for the Menu Bar with smooth animation or transitions (e.g., hover effects).
   
5. **Testing Across macOS Versions**  
   - [x] Ensure compatibility across different versions of macOS (e.g., from macOS Mojave to macOS Ventura) and ensure no compatibility issues arise.
   - [ ] Test the app on various hardware configurations (iMac, MacBook, Mac mini).

6. **Add Help/Documentation**  
   - [x] Write a basic user manual or documentation explaining how to use the app (access Menu Bar, trigger fade, adjust preferences).

---

### **Completed Tasks**
- [x] Create the project structure in Xcode.