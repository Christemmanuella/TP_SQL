use werewolfvillage;
go

-- vue pour afficher les détails des parties et des joueurs associés
create view vw_parties_players as
select 
    p.id_party,
    p.title_party,
    pip.id_player,
    pl.pseudo,
    pip.id_role,
    r.description_role,
    pip.is_alive
from dbo.parties p
join dbo.players_in_parties pip on p.id_party = pip.id_party
join dbo.players pl on pip.id_player = pl.id_player
join dbo.roles r on pip.id_role = r.id_role;
go

-- vue pour afficher les tours d'une partie avec les actions des joueurs
create view vw_turns_actions as
select 
    t.id_turn,
    t.id_party,
    p.title_party,
    t.start_time,
    t.end_time,
    pp.id_player,
    pl.pseudo,
    pp.action,
    pp.origin_position_row,
    pp.origin_position_col,
    pp.target_position_row,
    pp.target_position_col
from dbo.turns t
join dbo.parties p on t.id_party = p.id_party
join dbo.players_play pp on t.id_turn = pp.id_turn
join dbo.players pl on pp.id_player = pl.id_player;
go

-- vue pour afficher les paramètres de jeu d'une partie
create view vw_game_settings as
select 
    gs.id_party,
    p.title_party,
    gs.rows,
    gs.columns,
    gs.max_turn_time,
    gs.total_turns,
    gs.obstacle_count
from dbo.game_settings gs
join dbo.parties p on gs.id_party = p.id_party;
go

-- vue pour afficher les obstacles d'une partie
create view vw_obstacles as
select 
    o.id_obstacle,
    o.id_party,
    p.title_party,
    o.position_row,
    o.position_col
from dbo.obstacles o
join dbo.parties p on o.id_party = p.id_party;
go