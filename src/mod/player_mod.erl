%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 十一月 2018 下午1:40
%%%-------------------------------------------------------------------
-module(player_mod).
-author("dhcd").

%% player options API
-export([
  create/3,
  update/3,
  upgrade/2]).

%% 创建初始化玩家
-spec create(Name :: string(), Role :: string(), Pass :: string()) -> type:player().
create(Name, Role, Pass) ->
  #{
      <<"index">> => Name,
      <<"pass">>  => dhcrypt:md5(Pass),
      <<"role">>  => Role,
      <<"base">>  => base_info_mod:init_base_info(Name, 1, 0),
      <<"bag">>   => bag_mod:init_bag(bag_mod:init_tools_or_equips(0, []), bag_mod:init_tools_or_equips(0, [])),
      <<"msgs">>  => []
  }.

%% 修改玩家 一级Key
-spec update(Key :: binary(), Value :: any(), Player :: type:player()) -> type:player().
update(Key, Value, Player) ->
  case Key of
     <<"index">> ->
       Base_ = base_info_mod:update_base(<<"name">>, Value, maps:get(<<"base">>, Player)),
       Player#{Key := Value, <<"base">> := Base_};
     <<"pass">>  ->
       Player#{Key := dhcrypt:md5(Value)};
     _     ->
       Player#{Key := Value}
  end.

%% 玩家升级 Ups 为升级数
-spec upgrade(Player :: type:player(), Ups :: integer()) -> type:player().
upgrade(#{<<"base">> := #{<<"lv">> := Lv} = Base} = Player, Ups) ->
  Base_up = base_info_mod:update_base(<<"lv">>, Lv + Ups, Base),
  update(<<"base">>, Base_up, Player).



