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

-include("../../include/game_server_pb.hrl").

%% role
-define(ROLES, ["humanity", "mage", "elf", "orc", "angel"]).

%% API
-export([login/2, register/2, login_out/2, info/2, upgrade/2, change_name/2, change_pass/2, change_role/2, add_tools/2, delete_tools/2, upgrade_tools/2, add_equips/2, delete_equips/2, upgrade_equips/2, append_msg/2]).

-spec login(Data :: #login_request{}, Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
login(Data, _Player) ->
  Name = Data#base_info.name,
  Role = Data#base_info.role,
  Pass = Data#base_info.pass,
  case player_mongo_options:find_player(list_to_atom(Name), list_to_atom(Role), Pass) of
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
  Name = Data#base_info.name,
  Role = Data#base_info.role,
  Pass = Data#base_info.pass,
  case player_mongo_options:find_player(list_to_atom(Name), list_to_atom(Role), Pass) of
    {ok, Player}  ->
      Size = maps:size(Player),
      if
        Size =:= 0 ->
          Reg_player = player_options:create(list_to_atom(Name), list_to_atom(Role), Pass),
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
  Name = Data#base_info.name,
  Role = Data#base_info.role,
  Pass = Data#base_info.pass,
  case player_mongo_options:find_player(list_to_atom(Name), list_to_atom(Role), Pass) of
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
  Name = Data#change_name_request_change_name.new_name,
  Update_ = player_options:change_name(list_to_atom(Name), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec change_pass(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
change_pass(Data, Player) ->
  Pass = Data#change_pass_request_change_pass.new_pass,
  Update_ = player_options:change_pass(Pass, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec change_role(Data :: string(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
change_role(Data, Player) ->
  Role = Data#change_role_request_change_role.new_role,
  Update_ = player_options:chang_role(list_to_atom(Role), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec add_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
add_tools(Data, Player) ->
  Tools = [convert_to_map(te, T) || T <- Data],
  Update_ = player_options:add_te(<<"tools">>, player_options:init_tools_or_equips(length(Tools), Tools), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec delete_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
delete_tools(Data, Player) ->
  Tool = convert_to_map(te, Data),
  Update_ = player_options:delete_te(<<"tools">>, Tool, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec upgrade_tools(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
upgrade_tools(Data, Player) ->
  Tool = convert_to_map(te, Data),
  Update_ = player_options:upgrade_te(<<"tools">>, Tool, 1, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec add_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
add_equips(Data, Player) ->
  Equips = [convert_to_map(te, T) || T <- Data],
  Update_ = player_options:add_te(<<"equips">>, player_options:init_tools_or_equips(length(Equips), Equips), Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec delete_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
delete_equips(Data, Player) ->
  Equip = convert_to_map(te, Data),
  Update_ = player_options:delete_te(<<"equips">>, Equip, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec upgrade_equips(Data :: term(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
upgrade_equips(Data, Player) ->
  Equip = convert_to_map(te, Data),
  Update_ = player_options:upgrade_te(<<"equips">>, Equip, 1, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

-spec append_msg(Data :: player_options:msg(), Player :: player_options:player()) -> {ok, Player :: player_options:player()}|{error, atom()}.
append_msg(Data, Player) ->
  Msg = convert_to_map(msg, Data),
  Update_ = player_options:append_msg(Msg, Player),
  case player_mongo_options:update_player(Update_) of
    ok ->
      {ok, Update_};
    {error, _} ->
      {error, server_error}
  end.

convert_to_map(Map_type,Rec) ->
  case Map_type of
      te  -> #{
        <<"name">> => list_to_atom(Rec#te.name),
        <<"lv">>   => Rec#te.lv,
        <<"logo">> => Rec#te.logo
      };
      msg -> #{
        <<"from">>   => Rec#send_msg_request_message.from,
        <<"target">> => Rec#send_msg_request_message.target,
        <<"msg">>    => Rec#send_msg_request_message.msg
      };
      _   -> #{}
  end.

