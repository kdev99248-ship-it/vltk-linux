

tbSecurityLock = {}


tbSecurityLock.SECURITY_LOCK_TRADE = 0			--DO NOT change it
tbSecurityLock.SECURITY_LOCK_PET = 1			--DO NOT change it
tbSecurityLock.SECURITY_LOCK_MERIDIAN = 2		--DO NOT change it
tbSecurityLock.SECURITY_LOCK_TONG = 3			--DO NOT change it

tbSecurityLock.TSK_SECURITY_LOCKER = 4052

tbSecurityLock.TSK_SECURITY_LOCK_STATE = 4053
tbSecurityLock.TSK_STATE_BIT = 0
tbSecurityLock.TSK_FIRST_TIME_BIT = 1


function tbSecurityLock:IsLocked()
	return GetBitTask(self.TSK_SECURITY_LOCK_STATE, self.TSK_STATE_BIT, 1) == 1
end

function tbSecurityLock:GetLockerValue()
	return GetTask(self.TSK_SECURITY_LOCKER)
end