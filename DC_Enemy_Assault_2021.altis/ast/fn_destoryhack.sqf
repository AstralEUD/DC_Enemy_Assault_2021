private ["_host","_caller","_id","_tsk"];
_host = _this select 0;
_caller = _this select 1;
_id = _this select 2;
_tsk = _this select 3;

_host removeaction _id;
["폭파 미션을 해킹하였습니다! 이제 파괴가 가능합니다.",_caller] remoteExec ["ghst_fnc_global_sidechat"];
_callerpos = getPosATL _caller;
[_callerpos] remoteExeccall ["ast_fnc_missionReward",0];
_host allowDamage true;
