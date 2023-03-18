-- Author      : hpsnk
-------------------------------------------------------
LOGGER                      = {}
TARGET_MSG_1                = "防脚本检测"
TARGET_MSG_2                = "请在聊天频道回答以下问题的答案"
TARGET_MSG_3                = "剩余回答时间"
TARGET_MSG_4                = "请在聊天频道回答以下问题的答案:|cffFFD800"

TARGET_MSG_INVITE_CHECK     = "555"
TARGET_MSG_INVITE_APPLY     = "666"

AUTO_FOLLOW_PLAYER_NAME     = "";
AUTO_FOLLOW_START_MSG       = "111";
AUTO_FOLLOW_STOP_MSG        = "222";

HAR_ACTIVE_FLAG             = true;
TRACE_FLAG                  = false;

Config = {};
Config.commandStart         = "111";
Config.commandStop          = "222";
-------------------------------------------------------

SLASH_HAF1                  = "/haf";
-- SLASH_HAF2                  = "/happyar";
SlashCmdList["HAF"]         = function(msg)
	local cmd, arg = string.split(" ", msg, 2);
	cmd = cmd:lower()

	print("HappyAutoFollow!");
end

local hafFrame = CreateFrame("frame", nil, UIParent)

-- hafFrame:RegisterEvent("ADDON_LOADED")

hafFrame:RegisterEvent("CHAT_MSG_PARTY")
-- hafFrame:RegisterEvent("CHAT_MSG_WHISPER")
hafFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER")

-- hafFrame:RegisterEvent("TRADE_SHOW")

-- hafFrame:RegisterEvent("PLAYER_LOGIN")

hafFrame:SetScript("OnEvent", hafFrame.EventHandler)

function hafFrame:EventHandler(event,arg1,_,_,_,arg5,_,_,_,_,_,_,_,_)

	-- 组队邀请
	if event == "PARTY_INVITE_REQUEST" then
		-- 接受组队邀请
		AcceptGroup();

		-- 关闭组队邀请窗口
		HAF_closePartyInviteFrame();
	end

	if event == "CHAT_MSG_PARTY_LEADER" or event == "CHAT_MSG_PARTY" then
		if arg1 == Config.commandStart then
			print("开始跟随" .. arg5)
			FollowUnit(arg5)
		end

		if arg1 == Config.commandStop then
			print("停止跟随")
			FollowUnit("player")
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

