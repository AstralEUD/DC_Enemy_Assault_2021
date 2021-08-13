/*──────────────────────────────────────────────────────┐
│   Author: Astral                                      │
│   Github: https://github.com/AstralKG                 │
│                                                       │
│   Description: For  refund vehicle                    │
└──────────────────────────────────────────────────────*/

params["_spCheck","_selections","_price","_tobe","_playerUID","_position"];
_position = getPos ASTAir_Spawn;
_CheckAlpha = nearestObjects [_position, ["landVehicle","Air","Ship"], 12] select 0; 
if (isNil "_CheckAlpha") exitWith {hint "There is no a Car/Aircraft/Ship on the spawn point. Check out!"};
_spCheck = typeOf _CheckAlpha;

_playerUID = getPlayerUID player;
_selections = ASTAirListR find _spCheck;
[player] remoteExec ["AST_fnc_fetch_money", 2, false];
sleep 0.5;
if (_selections == -1) exitWith {hint format ["This vehicle are not added to Vehicle List %1",_spCheck];};
if (count(fullCrew [_CheckAlpha, "cargo"]) > 1) exitWith {hint "There is still crew on the vehicle";};
if (_CheckAlpha getVariable ["spawner",""] != _playerUID) exitWith {hint "You're not owner/spawner of this Vehicle";};
[
	["Are you sure that want to refund vehicles really?"],
	"Agreement",
	{
		if _confirmed then {
			//systemchat "You accepted the T&C's";
			_position = getMarkerPos ["AST_Air_Spawn_Marker",false];
			_CheckAlpha = nearestObjects [_position, ["landVehicle","Air","Ship"], 12] select 0; 
			_spCheck = typeOf _CheckAlpha;
			_selections = ASTAirListR find _spCheck;
			_price = (ASTAirListRP select _selections) select 1;
			_tobe = AST_kill_score + _price;
			[player, "kill_score", _tobe] remoteExecCall ["AST_fnc_db_save", 2, false];
			hint format ["%1을 환불하셔서 %2 pts를 획득하셨습니다.",_spCheck, _price];
			deleteVehicle _CheckAlpha;
		} else {
			systemchat "You Rejected it";
		};
	},
	"", // reverts to default
	""  // reverts to default, disable cancel option
] call CAU_UserInputMenus_fnc_guiMessage;
