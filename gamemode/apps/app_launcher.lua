if CLIENT then
	surface.CreateFont("AppLabel", {
			font = "Century Gothic",
			size = 20,
			shadow = true,
		}
	)

	local APP = Ethereal.PeelPad.CreateApp("launcher")

	APP.Name = "Launcher"
	APP.Description = "Peelpad's Launcher"
	APP.Icon = Material("materials/ethereal/logo.png","noclamp smooth")
	APP.Visible = false

	function APP:CreateSwitchPanel()
		local Panel = vgui.Create("DPanel", self.PEELPAD.ScreenPanel)
		Panel:SetPos(0, 670)
		Panel:CenterHorizontal()
		Panel.Paint = function () end
		Panel.ButtonX = 0

		function Panel:PerformLayout()
			self:SetSize(self.ButtonX + 20, 20)
			self:CenterHorizontal()
		end

		function Panel.CreateSwitch(Page)
			local Switch = vgui.Create("DButton", Panel)
			Switch.Page = Page
			Switch:SetText("")
			Switch:SetPos(Panel.ButtonX, 0)
			Switch:SetSize(12, 12)

			Panel.ButtonX = Panel.ButtonX + 20

			function Switch.Paint(s, w, h)
				if self.TopPage == Switch.Page then
					draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 255))
				elseif Switch:IsHovered() then
					draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 100))
				else
					draw.RoundedBox(4, 0, 0, w, h, Color(200, 200, 200, 50))
				end
				draw.SimpleText(Switch.Page.Index, "Default", w/2, h/2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			return Switch
		end

		self.SwitchPanel = Panel
	end

	function APP:CreatePage()
		local Page = vgui.Create("DPanel", self.PEELPAD.ScreenPanel)
		Page:SetSize(966, 620)
		Page:SetPos(0, 30)
		Page:Hide()
		Page.Paint = function () end
		Page.IconX = 40
		Page.IconY = 30
		Page.Index = #self.Page + 1
		Page.Switch = self.SwitchPanel.CreateSwitch(Page)

		function Page.Switch.DoClick()
			for Index, Panel in pairs(self.Page) do
				if Panel ~= Page then
					Panel:Hide()
				end
			end
			self.TopPage = Page
			self.TopPage:Show()
			self.TopPage:SetZPos(1)
		end

		function Page:CanAddApp()
			return self.IconY < 660
		end

		function Page:AddApp()
			self.IconX = self.IconX + 130
			if self.IconX > 850 then
				self.IconX = 40
				self.IconY = self.IconY + 150
			end
		end

		self.Page[Page.Index] = Page
		return Page
	end

	function APP:CreateIcons()
		local PAGE = self:CreatePage()

		for ID, Application in SortedPairs(self.PEELPAD.App) do
			if Application.Visible then

				if not PAGE:CanAddApp() then
					PAGE = self:CreatePage()
				end

				local Button = vgui.Create("DButton", PAGE)
				Button:SetText("")
				Button.Hovered = false
				Button.Application = Application
				Button:SetPos(PAGE.IconX, PAGE.IconY)
				Button:SetSize(120, 120)

				function Button:Paint(w, h)
					surface.SetMaterial(Application.Icon)
					

					if(self.Hovered) then
						surface.SetDrawColor(Color(205, 205, 205, 250))
					else
						surface.SetDrawColor(Color(255, 255, 255, 200))
					end

					
					surface.DrawTexturedRect(10, 0, w - 30, h - 30)
					draw.SimpleText(Application.Name, "LogFont", w/2, h, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

				end

				function Button.DoClick()
					Application:Open()
				end

				PAGE:AddApp()
				self.AppIcon[ID] = Button
			end
		end
	end

	function APP:Created()
		self.Page = {}
		self.AppIcon = {}
		self:CreateSwitchPanel()
		self:CreateIcons()

		self.TopPage = self.Page[1]
		self.TopPage:Show()

	end
end
