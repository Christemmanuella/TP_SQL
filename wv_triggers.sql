use werewolfvillage;
go

-- trigger pour marquer un joueur comme mort après une attaque
create trigger tr_after_attack
on dbo.players_play
after insert
as
begin
    declare @id_player int;
    declare @id_party int;
    declare @action varchar(10);

    -- récupérer les informations de l'action insérée
    select @id_player = i.id_player,
           @action = i.action,
           @id_party = t.id_party
    from inserted i
    join dbo.turns t on i.id_turn = t.id_turn;

    -- si l'action est une attaque, marquer le joueur ciblé comme mort
    if @action = 'attack'
    begin
        -- ici, on suppose que le joueur ciblé est déterminé par une logique (par exemple, position cible)
        -- pour simplifier, on marque le joueur attaquant comme mort (à adapter selon les règles du jeu)
        update dbo.players_in_parties
        set is_alive = 'non'
        where id_party = @id_party and id_player = @id_player;
    end;
end;
go