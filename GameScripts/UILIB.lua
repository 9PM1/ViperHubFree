
--// ห้ามดัดแปลง/นำไปใช้โดยเด็ดขาด 
--// เตือนแล้วนะ
    local function draggable(obj)
        local UserInputService = game:GetService("UserInputService")
    
        local gui = obj
    
        local dragging
        local dragInput
        local dragStart
        local startPos
    
        local function update(input)
            local delta = input.Position - dragStart
    
    
            local EndPos =
                UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            --	gui.Position = EndPos
            local Tween = game:GetService('TweenService'):Create(gui, TweenInfo.new(0.2,Enum.EasingStyle.Quad), {Position = EndPos})
            Tween:Play()
            wait(1)
        end
    
        gui.InputBegan:Connect(
            function(input)
                if   input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = gui.Position
    
                    input.Changed:Connect(
                        function()
                            if input.UserInputState == Enum.UserInputState.End then
                                dragging = false
                            end
                        end
                    )
                end
            end
        )
    
        gui.InputChanged:Connect(
            function(input)
                if
                    input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
                then
                    dragInput = input
                end
            end
        )
    
        UserInputService.InputChanged:Connect(
            function(input)
                if input == dragInput and dragging  then
                    update(input)
                end
            end
        )
    end
    
	function getSaveableColor3(color)
		return {r = color.r, g = color.g, b = color.b}
	end
	for i, v in pairs(game.CoreGui:GetChildren()) do 
		if v.Name == 'UILIB' or v.Name =='Float' then
			v:Destroy()
		end 
	end 

	function toInteger(color)
		return math.floor(color.r*255)*256^2+math.floor(color.g*255)*256+math.floor(color.b*255)
	end


	function toHex(color)
		local int = toInteger(color)

		local current = int
		local final = ""

		local hexChar = {
			"A", "B", "C", "D", "E", "F"
		}

		repeat local remainder = current % 16
			local char = tostring(remainder)

			if remainder >= 10 then
				char = hexChar[1 + remainder - 10]
			end

			current = math.floor(current/16)
			final = final..char
		until current <= 0

		return "#"..string.reverse(final)
	end
	local themes = {
		['Default'] = {
			['Gradient'] = false ;
			['Transparency'] =0;
			['Round'] = 0;
			['Color'] = {
				Color3.fromRGB(41, 255, 215);
				Color3.fromRGB(66, 175, 252);
			};
			['Pattern'] = {
				'rbxassetid://2151782136';
				1;
			};
			['TextColor'] = Color3.fromRGB(255,255,255);
			['OppositeColor'] = Color3.fromRGB(252, 66, 66);
			['Logo'] = '9353677086';
			['Background'] = {
				Color3.fromRGB(30,30,30);
				--"8981329842";
				"";
				Color3.fromRGB(50,50,50);

			}; 
			['Element'] = {
				['Background'] = {
					Color3.fromRGB(40,40,40);
					8
				};
				['Toggle'] = {
					['Text'] = {
						Color3.fromRGB(255,255,255);
						Color3.fromRGB(200,200,200);
					};
					['Dot'] = {
						['On'] = Color3.fromRGB(40,40,40);
						['Off'] = Color3.fromRGB(255,255,255);
					};
					['DotBg'] = {
						['On'] = Color3.fromRGB(41, 255, 215);
						['Off'] = Color3.fromRGB(252, 66, 66);
					};


				};
				['Button'] = {
					['Text'] = {
						Color3.fromRGB(0,0,0);
						Color3.fromRGB(0,0,0);
					};
					['Background'] =  	{
						Color3.fromRGB(41, 255, 215);
						Color3.fromRGB(71, 201, 177);

					};

				};
				['Label'] = {
					Color3.fromRGB(255,255,255);
					24 
				};
				['Dropdown'] = {
					['Text'] = {
						Color3.fromRGB(255,255,255);
					};
					['Selected'] = {
						Color3.fromRGB(41, 255, 215);
					};
					['Switch'] = {

					};
					['Background'] =  	{
						Color3.fromRGB(41, 255, 215);
						Color3.fromRGB(255,255,255);

					};


				}


			}


		}
	}

	local library = {
		['Theme'] = 'Default'; 
		['currentpage'] = '';
		['sliding'] = false ;
		['drag'] = false ;
		['modal'] = false;
	}

	local function gettheme()
		return _G.themes or  themes[library.Theme] 
	end

	local function fixlink(input)
		local a = tostring(input)
		if not  a:find('rbxassetid://') then
			return 'rbxassetid://'..a 
		else 
			return a 
		end 
	end 


	local function MouseEvent(a,b,pass)

		a.MouseButton1Click:Connect(function()
			if not library.modal or pass then 
				b()
			end
		end)

	end 
	local function MouseState(a,b,c)

		a.MouseEnter:Connect(b)
		a.MouseLeave:Connect(c)

	end

	local function CreateInstance(cls, props, child)
		local child = child or {}
		local inst = Instance.new(cls)

		for i, v in pairs(props) do
			inst[i] = v
		end

		for i, v in pairs(child) do 
			if typeof(v) == 'Instance' then
				v.Parent = inst 
			end 
		end 
		return inst
	end




	--// New Stuff 
	local Utils = {}
	function Utils:UIPadding(Par, options)

		local Top = options.Top and UDim.new(0, options.Top) or UDim.new(0, 0)
		local Bottom = options.Bottom and UDim.new(0, options.Bottom) or UDim.new(0, 0)
		local Left = options.Left and UDim.new(0, options.Left) or UDim.new(0, 0)
		local Right = options.Right and UDim.new(0, options.Right) or UDim.new(0, 0)

		local Padding = CreateInstance('UIPadding', {
			Parent = Par;
			PaddingTop = Top; 
			PaddingBottom = Bottom; 
			PaddingLeft = Left; 
			PaddingRight = Right; 
		})
		return Padding 
	end 
	function Utils:UICorner(Par, round) 
		local Cornor = CreateInstance('UICorner', {
			Parent = Par;
			CornerRadius = UDim.new(0, round or 0); 
		})
		return Cornor 
	end 
	function Utils:UIStroke(Par, Thickness, Color, NotBorder,middle)
		local Cololrs = Color or Color3.fromRGB(0, 0, 0)
		local Thicknesss = Thickness or 1 
		local Type = NotBorder and Enum.ApplyStrokeMode.Contextual or Enum.ApplyStrokeMode.Border
		local Stroke = CreateInstance('UIStroke', {
			Parent = Par;
			ApplyStrokeMode = Type; 
			Color = Cololrs; 
			Thickness = Thicknesss; 
		})
		return Stroke 

	end 
	local tweenservice = game:GetService('TweenService')
	function Utils:Tween(obj, t, easingstyle, easingdirection, goal, cb)
		--// Argument Handling
		local callback = typeof(cb) == 'function' and cb or function()
		end;
		local style = typeof(easingstyle) == "EnumItem" and easingstyle or Enum.EasingStyle[easingstyle]
		local direction = typeof(easingdirection) == "EnumItem" and easingdirection or Enum.EasingDirection[easingdirection]
		--// Tween 
		local tween = tweenservice:Create(obj, TweenInfo.new(t, style, direction), goal)
		tween:Play()
		tween.Completed:Connect(function()
			callback()
		end)
		return tween 
	end 


	local function Splash(obj)
		spawn(function()
			local Mouse = game.Players.LocalPlayer:GetMouse()
			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = obj
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.ZIndex = 10
			Circle.Image = "rbxassetid://266543268"
			Circle.ImageColor3 = Color3.fromRGB(255, 255, 255)
			Circle.ImageTransparency = 0.4
			local NewX, NewY = Mouse.X - Circle.AbsolutePosition.X, Mouse.Y - Circle.AbsolutePosition.Y
			Circle.Position = UDim2.new(0, NewX, 0, NewY)
			local Size = 0
			if obj.AbsoluteSize.X > obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			elseif obj.AbsoluteSize.X < obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.Y * 1.5
			elseif obj.AbsoluteSize.X == obj.AbsoluteSize.Y then
				Size = obj.AbsoluteSize.X * 1.5
			end
			Utils:Tween(Circle,0.4,'Quad','Out',{
				Size = UDim2.new(0, Size, 0, Size);
				Position = UDim2.new(0.5, -Size / 2, 0.5, -Size / 2);
				ImageTransparency = 1;
			},function()
				Circle:Destroy()
			end)


		end)
	end


	function library:NewWindow(name,hub,des)

		local Scheme = gettheme();
		local UILIB = CreateInstance('ScreenGui', {
			DisplayOrder = 0,
			Enabled = true,
			ResetOnSpawn = true,
			Name = 'UILIB',
			Parent = game.CoreGui
		})
		local Shadow = CreateInstance('ImageLabel', {
			Image = 'rbxassetid://394176316',
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0.4,
			ScaleType = Enum.ScaleType.Stretch,
			SliceCenter = Rect.new(0, 0, 0, 0),

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			ClipsDescendants = true;
			Position = UDim2.new(0.5, 0, 0.50431031, 0),


			Size = UDim2.new(0, 552, 0, 338),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'Shadow',
			Parent = UILIB
		},{
			Utils:UICorner(nil,Scheme.Round)
		})

		local Main = CreateInstance('Frame', {


			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Scheme.Element.Background[1],
			BackgroundTransparency = Scheme.Transparency,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = true,

			Position = UDim2.new(0.5, 0, 0.5, 0),


			Size = UDim2.new(0, 521, 0, 318),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 0.5,
			Name = 'Main',
			Parent = Shadow
		},{
			Utils:UIStroke(Frame,1,Scheme.Background[3]);

			Utils:UICorner(nil,5)
		})
		--draggable(Main)
		draggable(Shadow)
		local Pattern = CreateInstance('ImageLabel', {
			Image = Scheme.Pattern[1],
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = Scheme.Pattern[2],

			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.new(0,30,0,50);
			SliceCenter = Rect.new(0, 256, 0, 256),

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.5, 0, 0.5, 0),


			Size = UDim2.new(0, 521, 0, 318),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 0,
			Name = 'Pattern',
			Parent = Main
		})

		local SectionButtonHolder = CreateInstance('Frame', {
			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Scheme.Background[1],
			BackgroundTransparency = 0.20000000298023224,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			Position = UDim2.new(0.0191938579, 0, 0.15408805, 0),


			Size = UDim2.new(0, 124, 0, 206),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'SectionButton',
			Parent = Main
		},{
			Utils:UIStroke(Frame,1,Scheme.Background[3]);

			Utils:UICorner(nil,5);
		})

		local SectionButton = CreateInstance('ScrollingFrame', {
			BottomImage = 'rbxasset://textures/ui/Scroll/scroll-bottom.png',
			CanvasPosition = Vector2.new(0, 0),
			CanvasSize = UDim2.new(0, 0, 1, 100),
			MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
			ScrollBarThickness = 1,
			ScrollingEnabled = true,
			TopImage = 'rbxasset://textures/ui/Scroll/scroll-top.png',

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Scheme.Background[1],
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = true,

			Position = UDim2.new(0.5, 0, 0.5, 0),


			Size = UDim2.new(1, 0, 1, 0),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 10,
			Name = 'SectionButton',
			Parent = SectionButtonHolder
		},{
			Utils:UIPadding(nil,{
				Top = 5, 
				Bottom = 5,
				Left = 5,
				Right = 5,
			}),
		})
		local UIListLayout1 = CreateInstance('UIListLayout', {
			Padding = UDim.new(0, 2),
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			Name = 'UIListLayout',
			Parent = SectionButton
		})


		UIListLayout1:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			local ContentSize = UIListLayout1.AbsoluteContentSize.Y
			--	Content.Size = UDim2.new(Content.Size.X,0,ContentSize+5)
			SectionButton.CanvasSize = UDim2.fromOffset(0, ContentSize+20)
			--	Content.CanvasPosition = Vector2.new(0, ContentSize)
		end)

		local Logo = CreateInstance('ImageLabel', {
			Image = 'rbxassetid://'.. Scheme.Logo ,
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0,
			ScaleType = Enum.ScaleType.Crop,
			SliceCenter = Rect.new(0, 0, 0, 0),
			Active = false,
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			Draggable = false,
			Position = UDim2.new(0.0470249653, 0, 0.0748427659, 0),
			Rotation = 0,
			Selectable = false,
			Size = UDim2.new(0, 30, 0, 30),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,
			Visible = true,
			ZIndex = 2,
			Name = 'Logo',
			Parent = Main
		},{
			Utils:UICorner(nil,5)
		})
		local Colora = Scheme.Color[1]

		local T = name and string.format('%s<font color= "%s" >%s </font>',name,toHex(Colora),hub) or 'UI library' 

		local HubName = CreateInstance('TextLabel', {
			Font = Enum.Font.Gotham,

			Text = T,
			TextColor3 = Scheme.TextColor,
			TextScaled = true,
			TextSize = 14,

			TextStrokeColor3 = Color3.new(0, 0, 0),
			TextStrokeTransparency = 1,
			TextTransparency = 0,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,

			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.101727448, 0, 0.0440251566, 0),


			Size = UDim2.new(0, 200, 0, 20),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'HubName',
			RichText = true;
			Parent = Main
		})
		local WaifuImg = CreateInstance('ImageLabel', {
			Image = fixlink(Scheme.Background[2]),
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Crop,
			SliceCenter = Rect.new(0, 0, 0, 0),

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.5, 0,0.5, 0),


			Size = UDim2.new(1, 0, 1, 0),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 0.5,
			Name = 'WaifuImg',
			Parent = Main
		})
		local Close = CreateInstance('ImageButton', {
			Image = 'http://www.roblox.com/asset/?id=6031094678',
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0,
			ScaleType = Enum.ScaleType.Stretch,
			SliceCenter = Rect.new(0, 0, 0, 0),

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 0.270588, 0.270588),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,
			AutoButtonColor = false;

			Position = UDim2.new(0.953934729, 0, 0.0628930852, 0),


			Size = UDim2.new(0, 20, 0, 20),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'Close',
			Parent = Main
		},{
			Utils:UICorner(nil,5)
		})
		MouseState(Close,function()
			Utils:Tween(
				Close,
				0.2,'Sine','In',{
					ImageColor3 =Scheme.Color[1]

				})

		end,function()
			Utils:Tween(Close,0.2,'Sine','In',{
				ImageColor3 = Color3.new(1, 1, 1),


			})

		end)
		MouseEvent(Close,function()
			UILIB:Destroy()
		end)

		local Minimize = CreateInstance('ImageButton', {
			Image = 'http://www.roblox.com/asset/?id=6023426928',
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0,
			ScaleType = Enum.ScaleType.Stretch,
			SliceCenter = Rect.new(0, 0, 0, 0),
			AutoButtonColor = false;
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Scheme.Element.Background[1],
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.884836853, 0, 0.0628930852, 0),


			Size = UDim2.new(0, 20, 0, 20),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,
			Visible = true;
			ZIndex = 1,
			Name = 'Minimize',
			Parent = Main
		},{
			Utils:UICorner(nil,5)
		})
		local Minimized = false 
		local Float = CreateInstance('ScreenGui', {
			DisplayOrder = 0,
			Enabled = true,
			ResetOnSpawn = true,
			Name = 'Float',
			Parent = game.CoreGui
		})

		local Mark = CreateInstance('ImageButton',{
			Size  = UDim2.new(0,0,0,0);
			Parent = Float;
			Image = 'rbxassetid://'.. Scheme.Logo;
			AnchorPoint = Vector2.new(0.5,0.5);
			Position = UDim2.new(0.5,0,0.5,0);
			BackgroundTransparency = 1
		},{
			Utils:UICorner(nil,100)
		})
		local MarkStroke = 	Utils:UIStroke(Mark,1,Scheme.Color[1]);

		local Mouse = game.Players.LocalPlayer:GetMouse()
		local First = false 
		MarkStroke.Enabled = false 
		MouseEvent(Mark,function()
			Minimized = false 
			MarkStroke.Enabled = false 
			Utils:Tween(Mark,0.2,'Linear','In',{
				Size  = UDim2.new(0,0,0,0);

			},function()
				Utils:Tween(Shadow,0.2,'Sine','In',{
					Size = UDim2.new(0, 552, 0, 338),

				})
			end)

		end)
		draggable(Mark)

		MouseEvent(Minimize,function()
			local Cornor = Shadow:FindFirstChildWhichIsA('UICorner')
			if not Minimized then 
				Minimized = true
				if First == false then 
					Mark.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
					First = true
				end 
				Utils:Tween(Shadow,0.2,'Sine','In',{
					Size = UDim2.new(0,0,0,0)

				},function()
					Utils:Tween(Mark,0.7,'Elastic','Out',{
						Size  = UDim2.new(0,50,0,50);

					},function()
						MarkStroke.Enabled = true
					end)

				end)



			end 

		end)
		MouseState(Minimize,function()
			Utils:Tween(Minimize,0.2,'Sine','In',{
				ImageColor3 =Scheme.Color[1]

			})

		end,function()
			Utils:Tween(Minimize,0.2,'Sine','In',{
				ImageColor3 = Color3.new(1, 1, 1),


			})

		end)





		local Information = CreateInstance('Frame', {


			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Scheme.Background[1],
			BackgroundTransparency = 0.20000000298023224,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.0191938579, 0, 0.830188692, 0),


			Size = UDim2.new(0, 124, 0, 43),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'Information',
			Parent = Main
		},{
			Utils:UIStroke(Frame,1,Scheme.Background[3]);

			Utils:UICorner(nil,5);
			Utils:UIPadding(nil,{
				Top = 2, 
				Bottom = 2,
				Left = 10,
				Right = 5,
			}),
		})
		local content, isReady = game.Players:GetUserThumbnailAsync(game.Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		local ProfilePic = CreateInstance('ImageLabel', {
			Image = content,
			ImageColor3 = Color3.new(1, 1, 1),
			ImageRectOffset = Vector2.new(0, 0),
			ImageRectSize = Vector2.new(0, 0),
			ImageTransparency = 0,
			ScaleType = Enum.ScaleType.Crop,
			SliceCenter = Rect.new(0, 0, 0, 0),

			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Scheme.Background[3],
			BackgroundTransparency = 0.5,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.100000001, 0, 0.5, 0),


			Size = UDim2.new(0, 30, 0, 30),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'ProfilePic',
			Parent = Information
		},{
			Utils:UICorner(nil,100)
		})
		local NameP = CreateInstance('TextLabel', {
			Font = Enum.Font.Gotham,
			FontSize = Enum.FontSize.Size14,
			Text = game.Players.LocalPlayer.DisplayName ,
			TextColor3 = Scheme.TextColor,
			TextScaled = true,
			TextSize = 15,
			TextStrokeColor3 = Color3.new(0, 0, 0),
			TextStrokeTransparency = 1,
			TextTransparency = 0,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,

			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.263157904, 0, 0.0303030312, 0),


			Size = UDim2.new(0, 84, 0, 19),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'Name',
			Parent = Information
		})
		local Game = CreateInstance('TextLabel', {
			Font = Enum.Font.Gotham,
			FontSize = Enum.FontSize.Size14,
			Text = des or '• Online',
			TextColor3 = Scheme.TextColor,
			TextScaled = false,
			TextSize = 14,
			TextStrokeColor3 = Color3.new(0, 0, 0),
			TextStrokeTransparency = 1,
			TextTransparency = 0.5,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,

			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = false,

			Position = UDim2.new(0.263157904, 0, 0.363636374, 0),


			Size = UDim2.new(0, 84, 0, 19),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'Game',
			Parent = Information
		})	




		local ContentHolder = CreateInstance('Frame', {


			AnchorPoint = Vector2.new(0, 0),
			BackgroundColor3 = Scheme.Background[1],
			BackgroundTransparency = 0.20000000298023224,
			BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
			BorderSizePixel = 0,
			ClipsDescendants = true,

			Position = UDim2.new(0.282149702, 0, 0.15408805, 0),


			Size = UDim2.new(0, 365, 0, 259),
			SizeConstraint = Enum.SizeConstraint.RelativeXY,

			ZIndex = 1,
			Name = 'ContentHolder',
			Parent = Main
		},{
			Utils:UIStroke(Frame,1,Scheme.Background[3]);

			Utils:UICorner(nil,5);
			Utils:UIPadding(nil,{
				Top = 8,
				Bottom = 8,
				Left = 8,
				Right = 8
			})
		})

		local Tab = {}
		function Tab:Notification(title,des,button,cb)
			library.modal = true
			local callback = cb or function() end 
			local Darken = CreateInstance('ImageLabel', {
				Image = '',
				ImageColor3 = Color3.new(1, 1, 1),
				ImageRectOffset = Vector2.new(0, 0),
				ImageRectSize = Vector2.new(0, 0),
				ImageTransparency = 1,
				ScaleType = Enum.ScaleType.Stretch,
				SliceCenter = Rect.new(0, 0, 0, 0),	


				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Color3.new(0,0,0),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0.5, 0, 0.5, 0),


				Size = UDim2.new(1,0,1,0),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 12,
				Name = 'Shadow',
				Parent = Main
			},{
				Utils:UICorner(nil,5)
			})
			Utils:Tween(Darken,0.3,'Sine','In',{
				BackgroundTransparency = 0.4,
			})


			local Holder = CreateInstance('Frame',{
				Size = UDim2.new(0.6,0,0.6,0);
				AnchorPoint = Vector2.new(0.5,0.5);
				Position = UDim2.new(0.5,0,0.9,0);
				Parent = Darken;
				ClipsDescendants = true;
				ZIndex = 13;
				BackgroundTransparency = 1;
				BackgroundColor3 = Scheme.Background[1]

			},{
				Utils:UICorner(nil,5);
				Utils:UIStroke(nil,1,Scheme.Background[3]);

			})
			Utils:Tween(Holder,0.2,'Linear','Out',{
				BackgroundTransparency = 0;
				Position = UDim2.new(0.5,0,0.5,0);
			},function()

				local H =CreateInstance('Frame',{
					Size = UDim2.new(0.6,0,0.6,0);
					AnchorPoint = Vector2.new(0.5,0.5);
					Position = UDim2.new(0.5,0,0.5,0);
					Parent = Darken;
					ClipsDescendants = true;
					ZIndex = 11;
					BackgroundTransparency = 1;
					BackgroundColor3 = Color3.fromRGB(255,255,255);

				},{
					Utils:UICorner(nil,5);

				})

				H.BackgroundTransparency = 0.5
				Utils:Tween(H,0.5,'Linear','In',{
					Size = UDim2.new(0.7,0,0.7,0);
					BackgroundTransparency = 1
				},function()
					H:Destroy()
				end)
			end)





			local Title = CreateInstance('TextLabel', {
				Font = Enum.Font.Gotham,
				FontSize = Enum.FontSize.Size24,
				Text = title or 'Notification',
				TextColor3 = Scheme.Color[1],
				TextScaled = false,
				TextSize = 20,
				TextStrokeColor3 = Color3.new(0, 0, 0),
				TextStrokeTransparency = 1,
				TextTransparency = 0,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,

				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0.5, 0, 0.05, 0),


				Size = UDim2.new(1, 0, 0, 25),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 20,
				Name = 'TextLabel',
				Parent = Holder
			})

			local Des = CreateInstance('TextLabel', {
				Font = Enum.Font.Gotham,
				FontSize = Enum.FontSize.Size24,
				Text = des or '. . .',
				TextColor3 = Scheme.TextColor,
				TextScaled = false,
				TextSize = 16,
				TextStrokeColor3 = Color3.new(0, 0, 0),
				TextStrokeTransparency = 1,
				TextTransparency = 0,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextYAlignment = Enum.TextYAlignment.Center,

				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0.5, 0, 0.2, 0),


				Size = UDim2.new(1, 0, 0, 100),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 20,
				Name = 'TextLabel',
				Parent = Holder
			},{
				Utils:UIPadding(nil,{
					Top = 10,
					Bottom = 10,
					Left = 10,
					Right = 10
				});
			})


			local ButtonContainer = CreateInstance('Frame', {
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0.5, 0, 0.7, 0),


				Size = UDim2.new(1, 0, 0, 40),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 20,
				Name = 'TextLabel',
				Parent = Holder
			},{
				Utils:UIPadding(nil,{
					Top = 10,
					Bottom = 10,
					Left = 10,
					Right = 10
				});

				CreateInstance('UIListLayout', {
					Padding = UDim.new(0, 4),
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					Name = 'UIListLayout',
					Parent = ScrollingFrame
				})

			})	
			function close()
				library.modal = false 
				Utils:Tween(Darken,0.3,'Linear','In',{
					BackgroundTransparency = 1,
				})
				Utils:Tween(Holder,0.3,'Linear','In',{
					BackgroundTransparency = 1;
					Position = UDim2.new(0.5,0,0.9,0);
				})
				Utils:Tween(Title,0.3,'Linear','In',{
					BackgroundTransparency = 1;
					Position = UDim2.new(0.5,0,0.2,0);
					TextTransparency = 1
				})

				Utils:Tween(Des,0.3,'Linear','In',{
					BackgroundTransparency = 1;
					Position = UDim2.new(0.5,0,0.7,0);
					TextTransparency = 1

				})
				ButtonContainer:Destroy()


				wait(0.3)




				Darken:Destroy()
			end 
			function makebtn(t,arg,add)
				local addd = add or {}
				local props = {
					Font = Enum.Font.Gotham,
					FontSize = Enum.FontSize.Size14,
					Text = t,
					TextColor3 = Scheme.TextColor,
					TextScaled = false,
					TextSize = 14,
					TextStrokeColor3 = Color3.new(0, 0, 0),
					TextStrokeTransparency = 1,
					TextTransparency = 0,
					TextWrapped = false,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,
					Active = false,
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Scheme.Background[3],
					BackgroundTransparency = 0,
					BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
					BorderSizePixel = 0,
					AutoButtonColor = true;
					ClipsDescendants = false,
					AutomaticSize = Enum.AutomaticSize.X;
					Draggable = false,
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Rotation = 0,
					Selectable = false,
					Size = UDim2.new(0, 0, 0, 30),
					SizeConstraint = Enum.SizeConstraint.RelativeXY,
					Visible = true,
					ZIndex = 20,
					Name = 'TextLabel',
					Parent = ButtonContainer
				}

				if  typeof(addd) == 'table' then
					for i,v in pairs(addd) do 
						props[i] = v 
					end 
				end 
				local Btn = CreateInstance('TextButton', props,{
					Utils:UIPadding(nil,{
						Top = 5, 
						Bottom = 5,
						Left = 5,
						Right = 5,
					}),
					Utils:UICorner(nil,3);

				})
				if addd =='outline' then 
					Utils:UIStroke(Btn,1,Scheme.TextColor);
					Btn.BackgroundColor3 = Scheme.Color[1]
				end 

				local cbb = function()

					close()


					callback(arg) 

				end



				MouseEvent(Btn,cbb,true)



			end 
			if typeof(button) == 'table' then
				for i,v in next,button do 
					if typeof(v) == 'table' then 
						local cg = v.callback or nil 
						local style = v.style and tostring(v.style):lower() or nil 
						if style == nil  then 
							makebtn(i,cg)
						elseif style == 'fade' then 
							makebtn(i,cg,{
								BackgroundTransparency = 0.5
							})
						elseif style == 'cancel' then 
							makebtn(i,cg,{
								BackgroundColor3 = Scheme.OppositeColor;
							})
						elseif style == 'outline' then 
							makebtn(i,cg,'outline')

						end 

					else 
						makebtn(i,v)
					end 

				end 
			else 

				makebtn('OK','bah','outline')
			end 




		end 
		function Tab:NewTab(name,logo)
			local SectionBtnTemplate = CreateInstance('TextButton', {
				Font = Enum.Font.Gotham,
				FontSize = Enum.FontSize.Size14,
				Text = name,

				TextColor3 = Color3.new(1, 1, 1),
				TextScaled = false,
				TextSize = 14,
				TextStrokeColor3 = Color3.new(0, 0, 0),
				TextStrokeTransparency = 1,
				TextTransparency = 0,
				TextWrapped = true,
				TextXAlignment = Enum.TextXAlignment.Right,
				TextYAlignment = Enum.TextYAlignment.Center,
				AutoButtonColor = false,
				Modal = false,
				Selected = false,
				Style = Enum.ButtonStyle.Custom,
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Scheme.Background[3],
				BackgroundTransparency = library.ed  == nil and 0 or 0.5,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0, 0, 0, 0),

				Selectable = true,
				Size = UDim2.new(1, 0, 0, 30),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 10,
				Name = 'SectionBtnTemplate',
				Parent = SectionButton
			},{
				Utils:UICorner(nil,5);
			})
			local SectionLogo = CreateInstance('ImageLabel', {
				Image = logo or  'http://www.roblox.com/asset/?id=6031094667',
				ImageColor3 = library.ed == nil and Scheme.Color[1] or  Color3.new(1, 1, 1),
				ImageRectOffset = Vector2.new(0, 0),
				ImageRectSize = Vector2.new(0, 0),
				ImageTransparency = 0,
				ScaleType = Enum.ScaleType.Stretch,
				SliceCenter = Rect.new(0, 0, 0, 0),

				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundColor3 = Scheme.Background[1],
				BackgroundTransparency = 1;--library.ed == nil and 0.5 or 0.8,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = false,

				Position = UDim2.new(0, 3, 0.5, 0),


				Size = UDim2.new(0, 20, 0, 20),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,

				ZIndex = 11,
				Name = 'SectionLogo',
				Parent = SectionBtnTemplate
			},{
				Utils:UICorner(nil,5);
			})


			local ScrollingFrame = CreateInstance('ScrollingFrame', {
				BottomImage = 'rbxasset://textures/ui/Scroll/scroll-bottom.png',
				CanvasPosition = Vector2.new(0, 0),
				CanvasSize = UDim2.new(0, 0, 1, 100),
				MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
				ScrollBarThickness = 2,
				ScrollingEnabled = true,
				TopImage = 'rbxasset://textures/ui/Scroll/scroll-top.png',

				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundColor3 = Scheme.Background[1],
				BackgroundTransparency = 1,
				BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
				BorderSizePixel = 0,
				ClipsDescendants = true,

				Position = UDim2.new(0.5, 0, 0.5, 0),


				Size = UDim2.new(0, 365, 0, 259),
				SizeConstraint = Enum.SizeConstraint.RelativeXY,
				Visible = library.ed  == nil,
				ZIndex = 1,
				Name = name,
				Parent = ContentHolder
			},{
				Utils:UICorner(nil,5);
				Utils:UIPadding(nil,{
					Top = 10, 
					Bottom = 2,
					Left = 5,
					Right = 5,
				}),
			})
			local _time = 0.3
			MouseEvent(SectionBtnTemplate,function()

				if library.currentpage == name or library.sliding then 
					return
				end 
				library.currentpage = name
				ScrollingFrame.Visible = true
				ScrollingFrame.Position = UDim2.new(0.5, 0, -0.5, 0)
				library.sliding = true

				for i,v in pairs(ContentHolder:GetChildren()) do 
					if v.Name ~= name and v:IsA('ScrollingFrame') then
						Utils:Tween(v,_time,'Linear','In',{
							Position = UDim2.new(0.5, 0, 1.5, 0)
						},function()

							v.Visible = false 


						end)
					end 
				end 
				Utils:Tween(ScrollingFrame,_time,'Linear','In',{
					Position = UDim2.new(0.5, 0, 0.5, 0)
				}) 

				for i,v in pairs(SectionButton:GetChildren()) do 
					if v.Name ~= name and v:IsA('TextButton') then
						Utils:Tween(v,0.2,'Linear','In',{
							BackgroundTransparency = 0.5
						})
						Utils:Tween(v.SectionLogo,0.2,'Linear','In',{
							ImageColor3 = Color3.new(1, 1, 1),
							--	BackgroundTransparency = 0.8
						})

					end 
				end 
				Utils:Tween(SectionLogo,0.2,'Linear','In',{
					ImageColor3 = Scheme.Color[1];
					--	BackgroundTransparency = 0.5
				})
				Utils:Tween(SectionBtnTemplate,0.2,'Linear','In',{
					BackgroundTransparency = 0
				},function()

				end)
				wait(_time)
				library.sliding = false 


			end)
			--[[
			MouseState(SectionBtnTemplate,function()
				Utils:Tween(SectionBtnTemplate,0.2,'Linear','In',{
					Size = UDim2.new(1.1, 0, 0, 30),

                })
			end,function()
				Utils:Tween(SectionBtnTemplate,0.2,'Linear','In',{
					Size = UDim2.new(1, 0, 0, 30),

				  })
			end)
			]]


			if library.ed == nil then
				library.ed = true
				library.currentpage = name 
			end 	

			local UIListLayout = CreateInstance('UIListLayout', {
				Padding = UDim.new(0, 7),
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				Name = 'UIListLayout',
				Parent = ScrollingFrame
			})


			UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				local ContentSize = UIListLayout.AbsoluteContentSize.Y
				--	Content.Size = UDim2.new(Content.Size.X,0,ContentSize+5)
				ScrollingFrame.CanvasSize = UDim2.fromOffset(0, ContentSize+20)
				--	Content.CanvasPosition = Vector2.new(0, ContentSize)
			end)


			local Section = {}
			function Section:NewSection(n)

				local SectionContainer = CreateInstance('Frame', {


					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundColor3 = Scheme.Element.Background[1],
					BackgroundTransparency = 0.800000011920929,
					BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
					BorderSizePixel = 0,
					ClipsDescendants = false,

					Position = UDim2.new(0.514084518, 0, 0.468057513, 0),


					Size = UDim2.new(1, 0, 0, 100),
					SizeConstraint = Enum.SizeConstraint.RelativeXY,

					ZIndex = 1,
					Name = 'SectionContainer',
					Parent = ScrollingFrame
				},{
					Utils:UIStroke(Frame,1,Scheme.Background[3]);
					Utils:UICorner(nil,5);
					Utils:UIPadding(nil,{
						Top = 2,
						Bottom = 5,
						Left = 5,
						Right = 5
					})
				})



				local UIListLayout = CreateInstance('UIListLayout', {
					Padding = UDim.new(0, 2),
					FillDirection = Enum.FillDirection.Vertical,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Top,
					Name = 'UIListLayout',
					Parent = SectionContainer
				})

				UIListLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()

					local ContentSize = UIListLayout.AbsoluteContentSize.Y
					SectionContainer.Size = UDim2.new(1,0,0,ContentSize+10)
				end)



				local TextLabel = CreateInstance('TextLabel', {
					Font = Enum.Font.Gotham,
					FontSize = Enum.FontSize.Size24,
					Text = n,
					TextColor3 = Scheme.Color[1],
					TextScaled = false,
					TextSize = 15,
					TextStrokeColor3 = Color3.new(0, 0, 0),
					TextStrokeTransparency = 1,
					TextTransparency = 0,
					TextWrapped = true,
					TextXAlignment = Enum.TextXAlignment.Center,
					TextYAlignment = Enum.TextYAlignment.Center,

					AnchorPoint = Vector2.new(0, 0),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
					BorderSizePixel = 0,
					ClipsDescendants = false,

					Position = UDim2.new(0.0289855078, 0, -0.0444261469, 0),


					Size = UDim2.new(1, 0, 0, 25),
					SizeConstraint = Enum.SizeConstraint.RelativeXY,

					ZIndex = 1,
					Name = 'TextLabel',
					Parent = SectionContainer
				})


				local func = {
					Table = {}
				}

				function func:Toggle(text,default,callback)
					local ToggleScheme = Scheme.Element.Toggle; 
					local Background1 = CreateInstance('TextButton', {
						Text = '';

						Active = false,
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Scheme.Element.Background[1],
						BackgroundTransparency = 0.5,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 30),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						AutoButtonColor = false ;
						Name = 'Frame',
						Parent = SectionContainer
					},{
						Utils:UICorner(nil,5)
					})
					local TextLabel = CreateInstance('TextButton', {
						Font = Enum.Font.Gotham,
						FontSize = Enum.FontSize.Size14,
						Text = text,
						TextColor3 =ToggleScheme.Text[1],
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						Active = false,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.0500000007, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0.5, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					})
					local TextButton = CreateInstance('TextButton', {
						Font = Enum.Font.SourceSans,
						FontSize = Enum.FontSize.Size14,
						Text = '',
						TextColor3 = Color3.new(0, 0, 0),
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						AutoButtonColor = false,
						Modal = false,
						Selected = false,
						Style = Enum.ButtonStyle.Custom,
						Active = true,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 =ToggleScheme.DotBg.Off,
						BackgroundTransparency = 0,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.927536249, 0, 0.5, 0),
						Rotation = 0,
						Selectable = true,
						Size = UDim2.new(0, 38, 0, 20),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextButton',
						Parent = Background1
					},{
						Utils:UICorner(nil,100)
					})
					local Dot = CreateInstance('Frame', {

						Active = false,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = ToggleScheme.Dot.Off,
						BackgroundTransparency = 0,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.3, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0, 18, 0, 18),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'Frame',
						Parent = TextButton
					},{
						Utils:UICorner(nil,100)
					})
					local flags = false 
					local callback = callback or function() end 
					function Callback()
						Splash(Background1)
						if flags == false then
							flags = true
							Utils:Tween(Dot,0.2,'Sine','In',{
								Position = UDim2.new(0.75, 0, 0.5, 0);
								BackgroundColor3 = ToggleScheme.Dot.On

							})
							Utils:Tween(TextButton,0.2,'Sine','In',{
								BackgroundColor3 = ToggleScheme.DotBg.On,

							})

						else 
							Utils:Tween(Dot,0.2,'Sine','In',{
								Position = UDim2.new(0.3, 0, 0.5, 0);
								BackgroundColor3 = ToggleScheme.Dot.Off


							})

							Utils:Tween(TextButton,0.2,'Sine','In',{
								BackgroundColor3 = ToggleScheme.DotBg.Off,
							})

							flags = false 
						end 
						callback(flags)

					end
					MouseEvent(TextButton,Callback)
					MouseEvent(TextLabel,Callback)
					MouseEvent(Background1,Callback)
					if default  then 
						Callback()
					end 


				end

				function func:Dropdown(text,list,cb)
					local title = text or 'Dropdown'
					local lists = list or {}
					local callback = cb or function() end 

					local DropdownColor = Scheme.Element.Dropdown; 
					local Background1 = CreateInstance('TextButton', {
						Text = '';

						Active = false,
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Scheme.Element.Background[1],
						BackgroundTransparency = 0.5,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 30),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						AutoButtonColor = false ;
						Name = 'Frame',
						Parent = SectionContainer
					},{
						Utils:UICorner(nil,5);
						Utils:UIStroke(Frame,1,Scheme.Background[3]);

					})
					local TextLabel = CreateInstance('TextButton', {
						Font = Enum.Font.Gotham,
						FontSize = Enum.FontSize.Size14,
						Text = text,
						TextColor3 =DropdownColor.Text[1],
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						Active = false,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.0500000007, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0.5, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					})

					local Selected = CreateInstance('TextButton', {
						Font = Enum.Font.Gotham,
						FontSize = Enum.FontSize.Size14,
						Text = '. . .',
						TextColor3 =DropdownColor.Selected[1],
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Right,
						TextYAlignment = Enum.TextYAlignment.Center,
						Active = false,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.65, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0.5, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					})

					local Logo = CreateInstance('ImageButton', {

						AutoButtonColor = false,
						Modal = false,
						Selected = false,
						Style = Enum.ButtonStyle.Custom,
						Active = true,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 =DropdownColor.Background1,
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.95, 0, 0.5, 0),
						Rotation = 0,
						Selectable = true,
						Size = UDim2.new(0, 20, 0, 20),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Image = 'http://www.roblox.com/asset/?id=6034818372',
						Name = 'TextButton',
						Parent = Background1
					},{
						Utils:UICorner(nil,100)
					})
					local line = CreateInstance('Frame', {
						Active = false,
						AnchorPoint = Vector2.new(0.5, 0),

						BackgroundTransparency = 1,

						Size = UDim2.new(1, 0, 0, 1),

						Visible = false,
						ZIndex = 1,


						Parent = SectionContainer
					})
					local Content = CreateInstance('Frame', {
						Active = false,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Scheme.Element.Background[1],
						BackgroundTransparency = 0.5,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,

						Name = 'Frame',
						Parent = SectionContainer
					},{
						Utils:UICorner(nil,5);
						Utils:UIPadding(nil,{
							Top = 5,
							Bottom = 5,
							Left = 5,
							Right = 5
						});

					})
					local line2 = CreateInstance('Frame', {
						Active = false,
						AnchorPoint = Vector2.new(0.5, 0),

						BackgroundTransparency = 1,

						Size = UDim2.new(1, 0, 0, 1),

						Visible = false,
						ZIndex = 1,


						Parent = SectionContainer
					})

					local ScrollingFrame = CreateInstance('ScrollingFrame', {
						BottomImage = 'rbxasset://textures/ui/Scroll/scroll-bottom.png',
						CanvasPosition = Vector2.new(0, 0),
						CanvasSize = UDim2.new(0, 0, 1, 100),
						MidImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
						ScrollBarThickness = 2,
						ScrollingEnabled = true,
						TopImage = 'rbxasset://textures/ui/Scroll/scroll-top.png',

						Active = false,
						AnchorPoint = Vector2.new(0.5, 0),
						BackgroundColor3 = Color3.fromRGB(0,0,0),
						BackgroundTransparency = 1;
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0.5, 0, 0.25, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0.8, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,

						Name = 'Frame',
						Parent = Content
					},{

						Utils:UICorner(nil,5);

						Utils:UIPadding(nil,{
							Top = 2, 
							Bottom = 2,
							Left = 3,
							Right = 3,
						}),
					})

					local UIListLayout1 = CreateInstance('UIListLayout', {
						Padding = UDim.new(0, 4),
						FillDirection = Enum.FillDirection.Vertical,
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.LayoutOrder,
						VerticalAlignment = Enum.VerticalAlignment.Top,
						Name = 'UIListLayout',
						Parent = ScrollingFrame
					})


					UIListLayout1:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
						local ContentSize = UIListLayout1.AbsoluteContentSize.Y

						ScrollingFrame.CanvasSize = UDim2.fromOffset(0, ContentSize+20)

					end)


					local Searchbar = CreateInstance('TextBox',{
						AnchorPoint = Vector2.new(0.5,0); 
						Size = UDim2.new(1,0,0,30);
						PlaceholderText = "Search..";
						Font = Enum.Font.Gotham;
						TextSize = 14;
						Position = UDim2.new(0.5,0,0,0);
						BackgroundTransparency = 1;
						Parent = Content;
						Text = '';
						TextColor3 = Scheme.TextColor;
					},{
						Utils:UICorner(nil,5);


					})
					Searchbar:GetPropertyChangedSignal('Text'):Connect(function()

						for i,v in pairs(ScrollingFrame:GetChildren()) do 
							if v:IsA('TextButton') then
								if  string.find(v.Text:lower(),Searchbar.Text:lower()) then 
									v.Visible = true 
									Utils:Tween(v,0.1,'Sine','In',{
										Size = UDim2.new(1,0,0,25);
									})
									wait(0.1)


								else 
									--	v.Visible = false 
									Utils:Tween(v,0.1,'Sine','In',{
										Size = UDim2.new(1,0,0,0)

									})
									wait(0.1)
									v.Visible = false

								end 
							end 

						end 

					end)


					local sbstroke = Utils:UIStroke(Searchbar,1,Scheme.Background[3]);
					local ContentStroke =	Utils:UIStroke(Content,1,Scheme.Background[3]);
					Searchbar.Focused:Connect(function()
						Utils:Tween(sbstroke,0.2,'Sine','In',{
							Color = Scheme.Color[1];
						})

					end)
					Searchbar.FocusLost:Connect(function()
						Utils:Tween(sbstroke,0.2,'Sine','In',{
							Color = Scheme.Background[3]
						})

					end)

					ContentStroke.Enabled = false 
					local flags = false 
					local callback = callback or function() end 
					local	function cclose()
						line2.Visible = false 
						Utils:Tween(Content,0.2,'Sine','In',{
							Size = UDim2.new(1, 0, 0, 0),
						})
						Utils:Tween(Logo,0.2,'Sine','In',{
							Rotation = 0;
						})
						flags = false 
					end 
					local function MakeDropList(v)
						local Buttons = CreateInstance('TextButton',{
							AnchorPoint = Vector2.new(0.5,0.5); 
							Size = UDim2.new(1,0,0,25);
							ClipsDescendants = true;
							Font = Enum.Font.Gotham;
							TextSize = 14;
							Position = UDim2.new(0.5,0,0,0);
							BackgroundTransparency = 1;
							TextColor3 = Scheme.Element.Button.Background[1],
							BackgroundColor3 = Scheme.Element.Button.Background[1],
							AutoButtonColor = false;
							Parent = ScrollingFrame;
							Text = v;

						},{
							Utils:UICorner(nil,5);


						})
						local BtnStroke = Utils:UIStroke(Buttons,1,Scheme.Element.Button.Background[1]);

						MouseState(Buttons,function()
							Utils:Tween(Buttons,0.2,'Sine','In',{
								TextColor3  = Scheme.Element.Button.Text[1];
								BackgroundTransparency = 0;
							})

						end,function()
							Utils:Tween(Buttons,0.2,'Sine','In',{
								TextColor3  = Scheme.Element.Button.Background[1];
								BackgroundTransparency = 1;
							})

						end)


						MouseEvent(Buttons,function()
							callback(v)
							Splash(Buttons)
							cclose()
							Selected.Text = tostring(v)
						end)
					end 
					for i,v in pairs(lists) do 
						MakeDropList(v)
					end 


					local function Callback()

						line.Visible = true
						line2.Visible = true
						Splash(Background1)
						Content.Visible = true
						ContentStroke.Enabled = not flags
						if flags == false then
							flags = true
							Utils:Tween(Content,0.2,'Sine','In',{
								Size = UDim2.new(1, 0, 0, 150),
							})
							Utils:Tween(Logo,0.2,'Sine','In',{
								Rotation = 180;
							})

						else 
							cclose()

						end 
						wait(0.2)
						Content.Visible = flags
						callback(flags)

					end
					MouseEvent(Logo,Callback)
					MouseEvent(TextLabel,Callback)
					MouseEvent(Background1,Callback)
					MouseEvent(Selected,Callback)

					local Dropdownfunctions = {}
					function Dropdownfunctions:Clear()
						for i,v in pairs(ScrollingFrame:GetChildren()) do 
							if v:IsA('TextButton') then	
								v:Destroy()
							end 
						end 
					end 
					function Dropdownfunctions:Add(text)
						MakeDropList(text)
					end 
					function Dropdownfunctions:Refresh(newlist)
						Dropdownfunctions:Clear()
						for i,v in pairs(newlist) do 
							MakeDropList(v)
						end 

					end 
					function Dropdownfunctions:Set(t)
						Selected.Text = tostring(t)
					end 


					return Dropdownfunctions


				end
				function func:Slider(text,min,default,max,callback)
					local title = text or 'Dropdown'
					local lists = list or {}
					local callback = cb or function() end 

					local DropdownColor = Scheme.Element.Dropdown; 
					local Background1 = CreateInstance('Frame', {

						Active = false,
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Scheme.Element.Background[1],
						BackgroundTransparency = 0.5,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 50),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1	,

						Name = 'Frame',
						Parent = SectionContainer
					},{
						Utils:UICorner(nil,5);
						Utils:UIStroke(Frame,1,Scheme.Background[3]);

					})
					local TextLabel = CreateInstance('TextLabel', {
						Font = Enum.Font.Gotham,
						FontSize = Enum.FontSize.Size14,
						Text = text,
						TextColor3 =DropdownColor.Text[1],
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						Active = false,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.0500000007, 0, 0.25, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0.5, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					})

					local SliderBackground = CreateInstance('Frame', {

						Active = false,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.5, 0, 0.7, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(0.91, 0, 0, 10),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					},{
						Utils:UIStroke(nil,1,Scheme.Background[3]);

						Utils:UICorner(nil,5)
					}) 

					local SliderInner = CreateInstance('Frame', {

						Active = false,
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundColor3 =Scheme.Color[1],
						BackgroundTransparency = 0,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(default/max, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = SliderBackground
					},{

						Utils:UICorner(nil,5)
					}) 



					local TextControl = CreateInstance('TextBox',{
						AnchorPoint = Vector2.new(1,0.5); 
						Size = UDim2.new(0,0,0,20);
						PlaceholderText = "number";
						AutomaticSize = Enum.AutomaticSize.X;
						TextXAlignment = Enum.TextXAlignment.Right,

						Font = Enum.Font.Gotham;
						TextSize = 14;
						Position = UDim2.new(0.95, 0, 0.3, 0),
						BackgroundTransparency = 1;
						Parent = Background1;
						Text = tostring(default);
						TextColor3 = Scheme.TextColor;
					},{
						Utils:UICorner(nil,5);
						Utils:UIPadding(nil,{

							Left = 4,
							Right = 4,
						}),

					})

					local tstroke = Utils:UIStroke(TextControl,1,Scheme.Background[3]);
					TextControl.Focused:Connect(function()
						Utils:Tween(tstroke,0.2,'Sine','In',{
							Color = Scheme.Color[1];
						})

					end)
					TextControl.FocusLost:Connect(function()
						Utils:Tween(tstroke,0.2,'Sine','In',{
							Color = Scheme.Background[3]
						})
						local num = tonumber(TextControl.Text)
						if num then 
							if num > max  then 

								num = max 
							elseif num < min then
								num = min


							end 

							Utils:Tween(SliderInner,0.3,'Sine','Out',{
								Size = UDim2.new(num/max, 0, 1, 0)
							})
							TextControl.Text = tostring(num)

						else 

							TextControl.Text = tostring(default)

						end
					end)




					local dragging = false 
					local function move(input)
						local pos = UDim2.new(math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1),0,1,0)
						local results = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)

						Utils:Tween(SliderInner,0.1,'Linear','Out',{
							Size = pos 
						})
						TextControl.Text = math.floor(results)
						pcall(callback, value)
						library.drag = true
					end
					MouseState(Background1,function()
						library.drag = true
					end,function()
						library.drag = false
					end)
					Background1.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end)
					Background1.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false
								library.drag = false 
							end
						end)
					game:GetService("UserInputService").InputChanged:Connect(
					function(input)
						if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
							move(input)
						end
					end)











				end
				function func:Line(text)
				end 
				function func:Label(text)
					local T = CreateInstance('TextLabel', {
						Text = text;
						Active = false,
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Scheme.Element.Button.Background[1],
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						Font = Enum.Font.SourceSans;
						TextScaled = true;

						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 20),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'Frame',
						--AutomaticSize = Enum.AutomaticSize.Y;
						TextColor3 = Scheme.TextColor,
						Parent = SectionContainer
					})
					local func = {}
					function func:Refresh(newtext)
						T.Text = newtext

					end 
					return func 

				end 

				function func:Button(text,callback)
					local Background1 = CreateInstance('TextButton', {
						Text = '';
						AutoButtonColor = false; 
						Active = false,
						AnchorPoint = Vector2.new(0, 0),
						BackgroundColor3 = Scheme.Element.Button.Background[1],
						BackgroundTransparency = 0,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,

						ClipsDescendants = true,
						Draggable = false,
						Position = UDim2.new(0, 0, 0.149617583, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 30),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'Frame',
						Parent = SectionContainer
					},{
						Utils:UICorner(nil,5);
						Utils:UIStroke(Frame,1,Scheme.Background[3]);

					})
					local TextLabel = CreateInstance('TextButton', {
						Font = Enum.Font.Gotham,
						FontSize = Enum.FontSize.Size14,
						Text = text,
						TextColor3 = Scheme.Element.Button.Text[1],
						TextScaled = false,
						TextSize = 14,
						TextStrokeColor3 = Color3.new(0, 0, 0),
						TextStrokeTransparency = 1,
						TextTransparency = 0,
						TextWrapped = false,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextYAlignment = Enum.TextYAlignment.Center,
						Active = false,
						AnchorPoint = Vector2.new(0.5, 0.5),
						BackgroundColor3 = Color3.new(1, 1, 1),
						BackgroundTransparency = 1,
						BorderColor3 = Color3.new(0.105882, 0.164706, 0.207843),
						BorderSizePixel = 0,
						ClipsDescendants = false,
						Draggable = false,
						Position = UDim2.new(0.5, 0, 0.5, 0),
						Rotation = 0,
						Selectable = false,
						Size = UDim2.new(1, 0, 1, 0),
						SizeConstraint = Enum.SizeConstraint.RelativeXY,
						Visible = true,
						ZIndex = 1,
						Name = 'TextLabel',
						Parent = Background1
					})
					local cb = callback or function() end
					local Callback = function()
						cb() 
						Splash(Background1)
					end
					MouseState(TextLabel,function()

						Utils:Tween(TextLabel,0.2,'Linear','In',{

							TextColor3 = Scheme.Element.Button.Text[2],

						})
						Utils:Tween(Background1,0.2,'Linear','In',{

							BackgroundColor3 = Scheme.Element.Button.Background[2];
						})

					end,function()

						Utils:Tween(TextLabel,0.2,'Linear','In',{

							TextColor3 = Scheme.Element.Button.Text[1],


						})
						Utils:Tween(Background1,0.2,'Linear','In',{

							BackgroundColor3 = Scheme.Element.Button.Background[1];
						})

					end)


					MouseEvent(Background1,Callback)
					MouseEvent(TextLabel,Callback)


				end

				function func:SetTable(tbl,obj)
					self.Table = tbl 


				end 


				function func:Add(name,f,cb)
					local callback = cb or function() end 
					local flag = f or name 
					local Varible = self.Table[flag] 
					local t = typeof(Varible)

					if t == 'boolean' then 
						return self:Toggle(name,Varible,function(v)
							self.Table[flag] = v 
							callback(v)
						end)
					end 
					if t == 'table' and Varible['min'] and Varible['max'] then 
						return self:Slider(name,Varible.min,Varible.value,Varible.max,function(v)
							self.Table[flag]['value'] = v 
							callback(v)
						end)
					end 
					if t == 'table' and Varible['list']  then 
						local result =  self:Dropdown(name, Varible['list'],function(v)
							self.Table[flag]['value'] = v 
							callback(v)
						end)
						result:Set(Varible['value'])
						return result

					end 

				end


				return func 
			end 

			return Section
		end 
		return Tab 

	end 





	return library
