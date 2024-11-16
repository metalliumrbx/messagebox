# MessageBox
This module lets you manage and display custom message boxes in Roblox Luau. It is type-checked and contains these types:

- ``MessageBox``: for creating and displaying MessageBoxes
- ``MessageBoxButton``: for displaying buttons with functions on a message box.

## Code Sample
Here is some basic usage of the MessageBox type.

```luau
local MessageBoxManager = require(game.ReplicatedStorage.MessageBox)

local NewMessageBox = MessageBoxManager.New() -- creates a new MessageBox
local LocalPlayer = game:GetService("Players").LocalPlayer

NewMessageBox.Title = "Hello world!"
NewMessageBox.Content = "This is my first message box." -- Note: the default box supports rich text

local MessageBoxOKButton: MessageBoxManager.MessageBoxButton = {
	Label = "OK",
	Callback = NewMessageBox.Hide,
}

NewMessageBox.Show(LocalPlayer)
-- The OK button in this example hides the message box, but you can also do this:
-- NewMessageBox.Hide()
```

![Result](https://github.com/user-attachments/assets/d2433104-a567-451a-a40d-78bedc1d1022)
