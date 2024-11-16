-- Metallium Version 2024.11

-- Title: MessageBox.luau
-- Description: Provides a module for creating MessageBox types. It is very OOP, but readable.
-- Author: Ben Daws (github: @bendaws)
-- Repository: https://github.com/metalliumrbx/messagebox

-- Metallium is closed-source with some freely shared open-source components.
-- Open-source components of Metallium are avaliable at this web site:
--		https://github.com/metalliumrbx

local MessageBoxManager = {}

type MessageBoxButton = {
	Label: string;
	Callback: (nil) -> ...any;
}

type MessageBox = {
	Title: string;
	Content: string;
	Buttons: {MessageBoxButton};
	
	UI: ScreenGui; -- No need to assign this, it will be assigned at MessageBox.Show()
	
	Show: (toPlayer: Player) -> nil;
	Hide: (nil) -> nil;
}

function MessageBoxManager.New(): MessageBox
	local NewMessageBox: MessageBox = {}
	
	function NewMessageBox:Show(toPlayer: Player): nil
		local MessageBoxTitle = NewMessageBox.Title
		local MessageBoxContent = NewMessageBox.Content

		local Buttons = NewMessageBox.Buttons

		local MessageBoxUI = script.MessageBoxUI:Clone()

		-- Property changes
		local Box = MessageBoxUI.Screen.Box

		Box.Title.TitleText.Text = MessageBoxTitle
		Box.Content.Text = MessageBoxContent

		-- Render buttons
		if Buttons ~= nil then
			for button: MessageBoxButton in Buttons do
				local AssignedButton = script.Button:Clone()
				repeat wait(0.01) until AssignedButton ~= nil
				
				local result, err = pcall(function()
					AssignedButton.Text = button.Label
					AssignedButton.MouseButton1Click = button.Callback;

					AssignedButton.Parent = Box.Buttons
				end)
				
				if err then
					warn("Exception occured while creating buttons: " .. err)
				end
			end
		else
			warn("message box shown with no buttons, make sure you hide the message box")
		end
		
		MessageBoxUI.Parent = toPlayer.PlayerGui
	end

	function NewMessageBox:Hide(): nil
		if NewMessageBox.UI then
			NewMessageBox.UI:Destroy()
		end
	end
	
	return NewMessageBox
end

return MessageBoxManager
