-- 用于解决2005年11月份宋金刷分的bug的事后处理,故制作了清除所有宋金排行榜的功能
TAB_SJ_LADDERID = 
{	10008	,
	10009	,
	10011	,
	10012	,
	10013	,
	10014	,
	10017	,
	10018	,
	10020	,
	10021	,
	10022	,
	10023	,
	10036	,
	10037	,
	10038	,
	10039	,
	10040	,
	10041	,
	10044	,
	10045	,
	10046	,
	10047	,
	10048	,
	10049	,
	10052	,
	10053	,
	10054	,
	10055	,
	10056	,
	10057	,
	10060	,
	10061	,
	10062	,
	10063	,
	10064	,
	10065	,
	10068	,
	10069	,
	10070	,
	10071	,
	10072	,
	10073	,
	10076	,
	10077	,
	10078	,
	10079	,
	10080	,
	10081	,
	10084	,
	10085	,
	10085	,
	10086	,
	10086	,
	10087	,
	10088	,
	10089	,
	10090	,
	10097	,
	10098	,
	10099	,
	10100	,
	10101	,
	10102	,
	10103	,
	10104	,
	10105	,
	10106	,
	10107	,
	10108	,
	10109	,
	10110	,
	10111	,
	10112	,
	10113	,
	10114	,
	10115	,
	10116	,
	10147	,
	10148	,
	10149	,
	10150	,
	10151	,
	10152	,
	10153	,
	10154	,
	10155	,
	10156	,
	10157	,
	10158	,
	10159	,
	10160	,
	10161	,
	10162	,
	};
	
function sj_ClearAllLadder()
	for i = 1, getn(TAB_SJ_LADDERID) do 
		Ladder_ClearLadder(TAB_SJ_LADDERID[i])
	end
	OutputMsg("Tong Kim Reset thong tin lien quan den xep hang!")
end

function TaskShedule()
	-- 设置方案名称
	TaskName( "Tong Kim Reset thong tin lien quan den xep hang!" );
	-- 只执行一次，用于解决2005年11月份宋金刷分的bug的事后处理
	TaskInterval( 244000 );
	-- 设置触发次数，0表示无限次数
	TaskCountLimit(1);
	-- 输出启动消息
end

function TaskContent()
	if (tonumber(date("%Y%m%d")) > 20051116) then
		OutputMsg(" [Tong Kim Reset thong tin lien quan den xep hang] Nhiem vu da qua ky han khong the thi hanh.")		
		return
	end
	sj_ClearAllLadder();
	OutputMsg( "============ DA XOA BO THONG TIN XEP HANG TONG KIM (clear_sjladder.lua)");
end
