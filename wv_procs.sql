use werewolfvillage;
go

-- procédure pour démarrer une nouvelle partie
create procedure sp_start_game
    @id_party int,
    @title_party nvarchar(100),
    @rows int,
    @columns int,
    @max_turn_time int,
    @total_turns int,
    @obstacle_count int
as
begin
    -- insérer la partie
    insert into dbo.parties (id_party, title_party)
    values (@id_party, @title_party);

    -- insérer les paramètres de la partie
    insert into dbo.game_settings (id_party, rows, columns, max_turn_time, total_turns, obstacle_count)
    values (@id_party, @rows, @columns, @max_turn_time, @total_turns, @obstacle_count);
end;
go

-- procédure pour ajouter un joueur à une partie
create procedure sp_add_player_to_game
    @id_party int,
    @id_player int,
    @id_role int
as
begin
    insert into dbo.players_in_parties (id_party, id_player, id_role, is_alive)
    values (@id_party, @id_player, @id_role, 'oui');
end;
go

-- procédure pour effectuer une action dans un tour
create procedure sp_perform_action
    @id_player int,
    @id_turn int,
    @action varchar(10),
    @origin_row nvarchar(50),
    @origin_col nvarchar(50),
    @target_row nvarchar(50),
    @target_col nvarchar(50)
as
begin
    insert into dbo.players_play (id_player, id_turn, start_time, end_time, action, origin_position_row, origin_position_col, target_position_row, target_position_col)
    values (@id_player, @id_turn, getdate(), getdate(), @action, @origin_row, @origin_col, @target_row, @target_col);
end;
go

-- procédure pour marquer un joueur comme mort
create procedure sp_kill_player
    @id_party int,
    @id_player int
as
begin
    update dbo.players_in_parties
    set is_alive = 'non'
    where id_party = @id_party and id_player = @id_player;
end;
go