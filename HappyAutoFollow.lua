-- Author      : hpsnk
-------------------------------------------------------
Config = {};
Config.commandStart         = "111";
Config.commandStop          = "222";
-------------------------------------------------------


local hafFrame = CreateFrame("frame", nil, UIParent)

function hafFrame:EventHandler(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, _,_,_,_,_)
	print("receive event= " .. event .. ".");

	-- 组队邀请
	if event == "PARTY_INVITE_REQUEST" then
		-- 接受组队邀请
		AcceptGroup();

		-- 关闭组队邀请窗口
		HAF_closePartyInviteFrame();
	end

	if event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_PARTY" then

		-- print("arg2=" .. arg2);
		-- print("arg3=" .. arg3);
		-- print("arg4=" .. arg4);
		-- print("arg5=" .. arg5);
		-- print("arg6=" .. arg6);
		-- print("arg7=" .. arg7);
		-- print("arg8=" .. arg8);

		if arg1 == Config.commandStart then
			print("开始跟随" .. arg2 .. ".");
			HAF_followStart(arg2);
		end

		if arg1 == Config.commandStop then
			print("停止跟随");
			FollowUnit("player");
		end
	end

end

function HAF_closePartyInviteFrame()
	for i = 1, STATICPOPUP_NUMDIALOGS do
		local frame = _G["StaticPopup" .. i]
		if (frame:IsVisible() and frame.which == "PARTY_INVITE") then
			-- 		frame.inviteAccepted = 1
			StaticPopup_OnClick(frame, 1);
		end
	end
end

function HAF_followStart(followUnitName)

	print( "Test:" .. UnitName("player") );

	for i = 1, 5 do
		local strUnitId = "party" .. i;
		-- LOGGER.debug("  check " .. strUnitId)
		local strUnitName = UnitName(strUnitId);
		if strUnitName == nil then
			break;
		else
			print(strUnitId .. "=" .. strUnitName);
		end
		-- LOGGER.debug(strUnitId .. "=" .. strUnitName .. ".");
		if strUnitName == followUnitName then
			FollowUnit(strUnitId);
			break;
		end
	end
end

SLASH_HAF1                  = "/haf";
-- SLASH_HAF2                  = "/happyar";
SlashCmdList["HAF"]         = function(msg)
	local cmd, arg = string.split(" ", msg, 2);
	cmd = cmd:lower()

	print("HappyAutoFollow!");
end


hafFrame:RegisterEvent("PARTY_INVITE_REQUEST");
hafFrame:RegisterEvent("CHAT_MSG_PARTY");
hafFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER");

hafFrame:SetScript("OnEvent", hafFrame.EventHandler);

print("HappyAutoFollow Load Complete.");