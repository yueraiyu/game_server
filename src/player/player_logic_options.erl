%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 23. 十一月 2018 上午11:44
%%%-------------------------------------------------------------------
-module(player_logic_options).
-author("dhcd").

%% role
-define(ROLES, ["humanity", "mage", "elf", "orc", "angel"]).

%% API
-export([login/2, register/2, login_out/2, info/2, upgrade/2, change_name/2, change_pass/2, chang_role/2, add_tools/2, delete_tools/2, upgrade_tools/2, add_equips/2, delete_equips/2, upgrade_equips/2, append_msg/2]).

-spec login(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
login(Data, _Player) ->
  case player_mongo_options:find_player(maps:get(name, Data), maps:get(role, Data), maps:get(pass, Data)) of
    {ok, Player}  ->
      Size = maps:size(Player),
      if
        Size =:= 0 ->
          {warring, un_register};
        true ->
          {ok, Player}
      end;
    {error, _}    ->
      {error, server_error}
  end.


-spec register(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
register(Data, _Player) ->
  case player_mongo_options:find_player(maps:get(name, Data), maps:get(role, Data), maps:get(pass, Data)) of
    {ok, Player}  ->
      Size = maps:size(Player),
      if
        Size =:= 0 ->
          Reg_player = player_options:create(list_to_atom(maps:get(name, Data)), list_to_atom(maps:get(role, Data)), maps:get(pass, Data)),
          player_mongo_options:add_player(Reg_player),
          {ok, Reg_player};
        true ->
          {warring, had_registed}
      end;
    {error, _}    ->
      {error, server_error}
  end.

-spec login_out(Data :: term(), Player :: player_options:player()) -> {ok, login_out}|{error, atom()}.
login_out(Data, _Player) ->
  case player_mongo_options:find_player(maps:get(name, Data), maps:get(role, Data), maps:get(pass, Data)) of
    {ok, Player}  ->
      Size = maps:size(Player),
      if
        Size =:= 0 ->
          {warring, error_param};
        true ->
          {ok, login_out}
      end;
    {error, _}    ->
      {error, server_error}
  end.

-spec info(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
info(_Data, Player) ->
  case player_mongo_options:update_player(Player) of
    ok ->
      {ok, Player};
    {error, _} ->
      {error, server_error}
  end.

-spec upgrade(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
upgrade(_Data, Player) ->
  Update_ = player_options:upgrade(Player, 1),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec change_name(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
change_name(Data, Player) ->
  Update_ = player_options:change_name(list_to_atom(maps:get(new_name, Data)), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec change_pass(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
change_pass(Data, Player) ->
  Update_ = player_options:change_pass(maps:get(new_pass, Data), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec chang_role(Data :: string(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
chang_role(Data, Player) ->
  Update_ = player_options:chang_role(list_to_atom(maps:get(new_role, Data)), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec add_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
add_tools(Data, Player) ->
  Update_ = player_options:add_te(<<"tools">>, player_options:init_tools_or_equips(length(maps:get(tools, Data)), maps:get(tools, Data)), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec delete_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
delete_tools(Data, Player) ->
  Update_ = player_options:delete_te(<<"tools">>, maps:get(tool, Data), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec upgrade_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
upgrade_tools(Data, Player) ->
  Update_ = player_options:upgrade_te(<<"tools">>, maps:get(tool, Data), 1, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec add_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
add_equips(Data, Player) ->
  Update_ = player_options:add_te(<<"equips">>, player_options:init_tools_or_equips(length(maps:get(equips, Data)), maps:get(equips, Data)), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec delete_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
delete_equips(Data, Player) ->
  Update_ = player_options:delete_te(<<"equips">>, maps:get(equip, Data), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec upgrade_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
upgrade_equips(Data, Player) ->
  Update_ = player_options:upgrade_te(<<"equips">>, maps:get(equip, Data), 1, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec append_msg(Data :: player_options:msg(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
append_msg(Data, Player) ->
  Update_ = player_options:append_msg(Data, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.