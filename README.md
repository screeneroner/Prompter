# Prompter v1.00

I finally got so lazy writing the same prompts and/or small clarifications for ChatGPT over and over again that I decided to automate the process. I gathered all the prompts into one folder and wrote a little program **Prompter** that **scans the files in subfolders and displays the file structure as a simple context menu invoked by Win+Alt+P**. If you select an item from the menu (which is actually the name of a corresponding file), **the content of that file gets copied to the clipboard and then pasted wherever your cursor is currently positioned in the ChatGPT input field or any other AI chat window**.

## How It Works

1. **Create a `Prompts` Folder**:
   - Place the `Prompts` folder in the same directory as the executable.
   - Add `.txt` files containing your prompts to this folder. You can organize them further into subfolders.

2. **Run the Program**:
   - Launch the `Prompter.exe` file.
   - Press `Win+Alt+P` to open a dynamically created menu representing the folder structure.

3. **Select a Prompt**:
   - Navigate through the menu to select a `.txt` file.
   - The content of the file is instantly inserted at the current cursor position.

4. **System Tray Features**:
   - Hover over the tray icon to see the version and author information.
   - Access the "Help" menu for a quick guide.
   - Use the "Buy me a coffee" option to support the project.

## Requirements

- **Operating System**: Windows (no additional software installation required).

## Installation

1. Download the [Prompter.zip](https://github.com/screeneroner/Prompter/raw/refs/heads/main/Prompter_v1.00.zip) 
2. Extract the archive to a folder of your choice.
3. Create a `Prompts` folder in the same directory as the executable, if it doesn't already exist.
4. Add `.txt` files to the `Prompts` folder to use as prompts. You can use subfolders to organize .txt files.
5. Run the `Prompter.exe` file inside the extracted folder.

## Support

If you find this tool helpful, consider supporting its development:  
[Buy me a coffee](https://www.buymeacoffee.com/screeneroner)

## License

This project is open-source under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html).
