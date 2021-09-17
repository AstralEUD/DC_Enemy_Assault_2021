SAKY_Reward = 0;

SAKY_RTBReward_GiveReward = {
	if((position player)in "AST_basePositions") then {
		if(SAKY_Reward > 0 && (vehicle player == player)) then {
			_player = player;
			_increase = SAKY_Reward;
			gamelogic globalChat format ["성공적으로 복귀하여 %1의 자원을 추가로 획득하였습니다.",_increase*30];
			AST_kill_score = AST_kill_score + (_increase * 15);
			[_increase * 30] call AST_fnc_hud_plus;
			SAKY_Reward = 0;
		};
	};
};

if (hasInterface) then {
	[] spawn {
		while {true} do {
			sleep 10;
			call SAKY_RTBreward_GiveReward;
		};
	};
	player addEventHandler ["Killed", {
		if (SAKY_Reward > 0) then {
			gamelogic globalChat ("사망으로 인해 복귀 보너스가 초기화되었습니다.");
			SAKY_Reward = 0;
		};
	}];
};