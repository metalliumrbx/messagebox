-- Metallium Version 2024.11

-- Title: MessageBox.luau
-- Description: Provides a module for creating MessageBox types. It is very OOP, but readable.
-- Author: Ben Daws (github: @bendaws)
-- Repository: https://github.com/metalliumrbx/messagebox

-- Metallium is closed-source with some freely shared open-source components.
-- Open-source components of Metallium are avaliable at this web site:
--		https://github.com/metalliumrbx

local MessageBox = {}

type MessageBoxButton = {
	Label: string;
	Callback: (nil) -> ...any;
}

type MessageBox = {
	Title: string;
	Content: string;
	Buttons: {MessageBoxButton};
	
	UI: ScreenGui; -- No need to assign this, it will be assigned at MessageBox.Show()
	
	Show: (toPlayer: player) -> nil;
	Hide: (nil) -> nil;
}

function MessageBox.Show(self, toPlayer: player)
	local MessageBoxTitle = self.Title
	local MessageBoxContent = self.Content
	
	local Buttons = self.Buttons
	
	local MessageBoxUI = script.MessageBoxUI:Clone()
	
	-- Property changes
	local Box = MessageBoxUI.Screen.Box
	
	Box.Title.TitleText.Text = MessageBoxTitle
	Box.Content.Text = MessageBoxContent
	
	-- Render buttons
	for button: MessageBoxButton in pairs(Buttons) do
		local AssignedButton = script.Button:Clone()
		AssignedButton.Text = button.Label
		AssignedButton.MouseButton1Click = button.Callback;
		
		AssignedButton.Parent = Box.Buttons
	end
	
	MessageBoxUI.Parent = toPlayer.PlayerGui
end

function MessageBox.Hide(self)
	if self.UI then
		self.UI:Destroy()
	end
end

return MessageBox
