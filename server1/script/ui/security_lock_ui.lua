if MODEL_GAMECLIENT ~= 1 then
	return
end


Include("\\script\\global\\securitylock\\common.lua")
Include("\\script\\script_protocol\\protocol_def_c.lua")
Include("\\script\\lib\\objbuffer_head.lua")

function tbSecurityLock:OnClickLockBtn(nLockerState)	
	local handle = OB_Create()
	ObjBuffer:PushByType(handle, OBJTYPE_NUMBER, nLockerState)
	ScriptProtocol:SendData("emSCRIPT_PROTOCOL_SECURITY_LOCK", handle)
	OB_Release(handle)
end

function tbSecurityLock:OnClickUnLockBtn(szPassWord)
	local handle = OB_Create()
	ObjBuffer:PushByType(handle, OBJTYPE_STRING, tostring(szPassWord))
	ScriptProtocol:SendData("emSCRIPT_PROTOCOL_SECURITY_UNLOCK", handle)
	OB_Release(handle)
end

function tbSecurityLock:OnClickCloseBtn(nLockerState)
	local handle = OB_Create()
	ObjBuffer:PushByType(handle, OBJTYPE_NUMBER, nLockerState)
	ScriptProtocol:SendData("emSCRIPT_PROTOCOL_SECURITY_CONFIG", handle)
	OB_Release(handle)
end

function tbSecurityLock:OnClickResetPasswordBtn(szOldPassWord, szNewPassWord)
	local handle = OB_Create()
	ObjBuffer:PushByType(handle, OBJTYPE_STRING, szOldPassWord)
	ObjBuffer:PushByType(handle, OBJTYPE_STRING, szNewPassWord)
	ScriptProtocol:SendData("emSCRIPT_PROTOCOL_SECURITY_RESET", handle)
	OB_Release(handle)
end

function tbSecurityLock:UpdateLocker()
	
	return self:IsLocked() or 0, self:GetLockerValue()
end