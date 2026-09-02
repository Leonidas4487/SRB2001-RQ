import os
import tkinter as tk
from tkinter import messagebox
import logging

PROGRAM_VERSION = "1.0.2"

# Ensure the logs directory exists
log_dir = os.path.join(os.path.dirname(__file__), 'logs')
if not os.path.exists(log_dir):
    os.makedirs(log_dir)

# Set up logging
log_file = os.path.join(log_dir, 'lua_toggler.log')
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler(log_file, mode='w'),
        logging.StreamHandler()
    ]
)

logging.info("Logging initialized, starting the application")

# Paths to Lua folder and init.lua
SCR_FOLDER = "../src/"
LUA_FOLDER = os.path.join(SCR_FOLDER, "Lua/")
INIT_FILE = os.path.join(SCR_FOLDER, "init.lua")


class ScriptTogglerApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Lua Script Toggler")
        self.debug_mode = False  # Initialize debug mode flag
        self.create_menu()

        try:
            self.script_vars = {}
            self.create_gui()
            self.refresh_scripts()  # Load and display scripts on start
        except Exception as e:
            logging.error("Error initializing the ScriptTogglerApp", exc_info=True)
            messagebox.showerror("Error", "Failed to load the application. Check logs for details.")
            self.root.destroy()

    def create_menu(self):
        """Create a menu bar with options for debug mode and about."""
        menu_bar = tk.Menu(self.root)

        # Debug menu
        debug_menu = tk.Menu(menu_bar, tearoff=0)
        debug_menu.add_checkbutton(label="Enable Debug Mode", command=self.toggle_debug_mode)
        menu_bar.add_cascade(label="Debug", menu=debug_menu)

        # About menu
        about_menu = tk.Menu(menu_bar, tearoff=0)
        about_menu.add_command(label="About", command=self.show_about)
        menu_bar.add_cascade(label="Help", menu=about_menu)

        self.root.config(menu=menu_bar)

    def toggle_debug_mode(self):
        """Toggle the debug mode on and off."""
        self.debug_mode = not self.debug_mode
        if self.debug_mode:
            logging.getLogger().setLevel(logging.DEBUG)  # Set logging level to DEBUG
            logging.debug("Debug mode enabled.")
            messagebox.showinfo("Debug Mode", "Debug mode is now enabled. You will see debug logs.")
        else:
            logging.getLogger().setLevel(logging.INFO)  # Set logging level to INFO
            logging.info("Debug mode disabled.")
            messagebox.showinfo("Debug Mode", "Debug mode is now disabled. Only info logs will be shown.")

    def show_about(self):
        """Show information about the application."""
        about_message = f"Lua Script Toggler\n{PROGRAM_VERSION}\n\nCreated by Speed2411\n\nThis application helps manage Lua scripts by enabling or disabling them easily."
        messagebox.showinfo("About", about_message)

    def read_lua_directory(self):
        """Read the Lua directory and return a dictionary with categories (directories) and Lua files."""
        lua_files_by_category = {}

        try:
            for root_dir, dirs, files in os.walk(LUA_FOLDER):
                # Create a category based on the directory structure relative to LUA_FOLDER
                relative_dir = os.path.relpath(root_dir, LUA_FOLDER)
                for lua_file in files:
                    if lua_file.endswith(".lua"):
                        if relative_dir not in lua_files_by_category:
                            lua_files_by_category[relative_dir] = []
                        lua_files_by_category[relative_dir].append(lua_file)
                        logging.debug(f"Found Lua file: {lua_file} in category: {relative_dir}")
        except Exception as e:
            logging.error(f"Error reading Lua directory: {e}")
            messagebox.showerror("Error", f"Failed to read Lua directory: {LUA_FOLDER}")
        
        return lua_files_by_category

    def load_config(self):
        """Load the current script statuses from init.lua."""
        script_status = {}
        current_path = ""
        start_reading = False  # Flag to start reading after "local filelist = {"
        end_reading = False    # Flag to stop reading after the last "}"

        try:
            with open(INIT_FILE, 'r') as f:
                for line in f:
                    line = line.strip()
                
                    # Start reading when "local filelist = {" is found
                    if line.startswith("local filelist = {"):
                        start_reading = True
                        logging.debug("Found 'local filelist = {'. Starting to parse scripts.")
                        continue  # Skip the line that contains "local filelist = {"
                
                    # Stop reading when the final "}" is encountered
                    if line == "}":
                        if start_reading:
                            logging.debug("Found closing '}'. Stopping parsing.")
                            end_reading = True
                        continue  # Ignore any lines after the final '}'
                
                    # Skip lines before the file list or after the end
                    if not start_reading or end_reading:
                        continue

                    # Handle path declaration
                    if line.startswith("path ="):
                        current_path = line.split('"')[1]
                        logging.debug(f"Current path set to: {current_path}")
                    elif line.startswith('"') and line.endswith('",'):
                        script_name = os.path.splitext(os.path.basename(line.split('"')[1]))[0]  # Extract only the script name without .lua extension
                        script_status[script_name] = True
                        logging.debug(f"Script found: {script_name} enabled")
                    elif line.startswith('--"') and line.endswith('",'):
                        script_name = os.path.splitext(os.path.basename(line.split('"')[1]))[0]  # Extract only the script name without .lua extension
                        script_status[script_name] = False
                        logging.debug(f"Script found: {script_name} disabled")
                    else:
                        logging.debug(f"Skipping unrelated or malformed line: {line}")

        except Exception as e:
            logging.error(f"Error loading Lua script configuration: {e}")

        return script_status

    def refresh_scripts(self):
        """Refresh the Lua script list by reloading the directory and config."""
        try:
            self.lua_files_by_category = self.read_lua_directory()  # Read Lua directory with categories
            self.script_status = self.load_config()  # Load init.lua configuration

            # Add check for shuffled files and update init.lua accordingly
            self.sync_scripts_to_init()

            self.update_gui()  # Update the GUI with new script data
        except Exception as e:
            logging.error("Error refreshing scripts", exc_info=True)
            messagebox.showerror("Error", "Failed to refresh scripts. Check logs for details.")

    def sync_scripts_to_init(self):
        """Check if files have been moved and update their paths in init.lua."""
        try:
            with open(INIT_FILE, 'r') as f:
                init_lines = f.readlines()

            updated_lines = []
            existing_scripts = set()

            for line in init_lines:
                # If a Lua script path is found, update its location if it's been moved
                if "lua" in line:
                    script_name = os.path.splitext(os.path.basename(line.split('"')[1]))[0]  # Compare script names without the .lua extension
                    if script_name in self.script_status:
                        existing_scripts.add(script_name)

            # Now, if a script in the Lua directory is missing in init.lua, add it
            for category, scripts in self.lua_files_by_category.items():
                for script in scripts:
                    script_name = os.path.splitext(os.path.basename(script))[0]  # Remove .lua extension for comparison
                    if script_name not in existing_scripts:
                        updated_lines.append(f'path = "{category}/", "{script_name}",\n')

            # Append any new scripts to init.lua
            with open(INIT_FILE, 'w') as f:
                f.writelines(updated_lines)
            logging.info("Synced scripts to init.lua")
        
        except Exception as e:
            logging.error(f"Error syncing scripts to init.lua: {e}")

    def toggle_script(self, script_name, enable):
        """Enable or disable a script in init.lua."""
        try:
            with open(INIT_FILE, 'r') as file:
                lines = file.readlines()

            updated_lines = []
            script_found = False

            for i, line in enumerate(lines):
                # Log the current line for debugging
                logging.debug(f"Processing line {i}: {line.strip()}")

                # Check if the line contains a script reference by checking for quotes
                if '"' in line:
                    # Attempt to split the line by quotes to isolate the script name
                    line_parts = line.split('"')
                    logging.debug(f"Split line into parts: {line_parts}")

                    if len(line_parts) > 1:
                        # Extract the script name from the quoted section
                        script_reference = line_parts[1]  # This should be the script path

                        # Get the base name (without .lua extension)
                        base_script_name = os.path.splitext(os.path.basename(script_reference))[0]
                        logging.debug(f"Extracted base script name: {base_script_name}")

                        if script_name == base_script_name:
                            script_found = True
                            if enable:
                                # Uncomment if script is disabled (commented)
                                if line.strip().startswith('--'):
                                    updated_lines.append(line.replace('--', '', 1))  # Remove the first '--'
                                    logging.debug(f"Enabling script: {script_name}")
                                else:
                                    updated_lines.append(line)
                            else:
                                # Comment the line if script is enabled
                                if not line.strip().startswith('--'):
                                    updated_lines.append('--' + line)
                                    logging.debug(f"Disabling script: {script_name}")
                                else:
                                    updated_lines.append(line)
                        else:
                            updated_lines.append(line)
                    else:
                        # If splitting didn't give the expected parts, log the error and append the original line
                        logging.warning(f"Unexpected line format at line {i}: {line.strip()}")
                        updated_lines.append(line)
                else:
                    updated_lines.append(line)

            # If the script was not found in the file
            if not script_found:
                messagebox.showwarning("Warning", f"Script '{script_name}' was not found in init.lua.")
                logging.warning(f"Script '{script_name}' was not found in the file.")

            # Write the updated lines back to the init.lua file
            with open(INIT_FILE, 'w') as file:
                file.writelines(updated_lines)

        except Exception as e:
            logging.error(f"Error toggling script '{script_name}': {e}")
            messagebox.showerror("Error", f"Failed to toggle script '{script_name}'. Check logs for details.")


    def create_gui(self):
        """Create the GUI components."""
        frame = tk.Frame(self.root)
        frame.pack(pady=10, padx=10)

        self.script_vars = {}  # Store references to checkbutton variables
        self.script_checkbuttons = {}  # Store references to checkbuttons

        self.canvas = tk.Canvas(frame, width=600, height=400)
        self.canvas.pack(side=tk.LEFT)

        scrollbar = tk.Scrollbar(frame, command=self.canvas.yview)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

        self.script_frame = tk.Frame(self.canvas)
        self.canvas.create_window((0, 0), window=self.script_frame, anchor="nw")

        self.canvas.configure(yscrollcommand=scrollbar.set)
        self.script_frame.bind("<Configure>", lambda event: self.canvas.configure(scrollregion=self.canvas.bbox("all")))

        self.refresh_button = tk.Button(self.root, text="Refresh Scripts", command=self.refresh_scripts)
        self.refresh_button.pack(pady=10)

    def update_gui(self):
        """Update the GUI with the current Lua scripts and their status."""
        for widget in self.script_frame.winfo_children():
            widget.destroy()  # Clear the frame for a fresh display

        for category, scripts in self.lua_files_by_category.items():
            category_label = tk.Label(self.script_frame, text=f"Category: {category}", font=("Helvetica", 12, "bold"))
            category_label.pack(anchor="w")

            for script in scripts:
                script_name = os.path.splitext(os.path.basename(script))[0]  # Remove the .lua extension for display
                var = tk.BooleanVar(value=self.script_status.get(script_name, False))  # Set initial value
                checkbutton = tk.Checkbutton(
                    self.script_frame,
                    text=script_name,
                    variable=var,
                    command=lambda sn=script_name, v=var: self.toggle_script(sn, v.get())
                )
                checkbutton.pack(anchor="w")

                self.script_vars[script_name] = var
                self.script_checkbuttons[script_name] = checkbutton


if __name__ == "__main__":
    root = tk.Tk()
    app = ScriptTogglerApp(root)
    root.mainloop()
