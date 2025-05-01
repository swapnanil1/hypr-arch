# Fixing Dolphin "Open With" & kbuildsycoca6 Error in Hyprland

This guide addresses the issue where Dolphin's "Open With" menu is empty and running `kbuildsycoca6 --noincremental` results in an `"applications.menu" not found` error when using Hyprland alongside KDE/Plasma components.

**Problem:** `kbuildsycoca6` (KDE's configuration cache builder) needs a base `applications.menu` file to run correctly, which Dolphin relies on.

**Solution:** Download the official Plasma menu file into your user configuration directory.

**Steps:**

1.  **Create Directory:**
    Ensure the target directory exists:
    ```bash
    mkdir -p ~/.config/menus/
    ```

2.  **Download Menu File:**
    Download the `plasma-applications.menu` file and save it as `applications.menu`:
    ```bash
    curl -L https://raw.githubusercontent.com/KDE/plasma-workspace/master/menu/desktop/plasma-applications.menu -o ~/.config/menus/applications.menu
    ```

3.  **(Optional) Verify Manually:**
    Run the command to check if the error is gone:
    ```bash
    kbuildsycoca6 --noincremental
    ```

4.  **Update `hyprland.conf`:**
    Ensure `kbuildsycoca6` runs automatically on login. Add/verify the following lines in your `~/.config/hypr/hyprland.conf`:
    ```ini
    # Prefer Plasma menu structure (Recommended with Plasma apps)
    env = XDG_MENU_PREFIX,plasma-

    # Build the KDE service cache on login *after* the menu file is present
    exec-once = kbuildsycoca6 --noincremental

    # Prevent full kded6 from running (dummy service)
    exec-once = printf '[D-BUS Service]\nName=org.kde.kded6\nExec=/bin/false' > $HOME/.local/share/dbus-1/services/org.kde.kded6.service
    # Clean up dummy service on exit
    exec-shutdown = rm $HOME/.local/share/dbus-1/services/org.kde.kded6.service
    ```

5.  **Apply Changes:**
    Save `hyprland.conf` and reload Hyprland (e.g., `SUPER + SHIFT + R`) or reboot.

6.  **Test:**
    Open Dolphin. The "Open With" menu should now correctly list available applications.

---
