%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 十一月 2018 下午1:40
%%%-------------------------------------------------------------------
-module(player_options).
-author("dhcd").

%% define type
-export_type([player/0]).

-type player() ::
  #{
      index => atom(),
      pass  => string(),
      role  => atom(),
      base  => baseInfo(),
      bag   => bag(),
      msgs  => list(msg())
    }.

-type baseInfo() ::
  #{
      name  => atom(),
      lv    => integer(),
      logo  => integer()
    }.

-type toolsOrEquips() ::
  #{
      count   => integer(),
      details => list(baseInfo())
  }.

-type bag() ::
  #{
      tools   => toolsOrEquips(),
      equips  => toolsOrEquips()
  }.

-type msg() ::
  #{
    from   => atom(),
    target => atom(),
    msg    => string()
  }.

%% player options API
-export([
  upgrade/2,
  change_name/2,
  change_pass/2,
  chang_role/2,
  create/3,
  update/3,
  update_base/3,
  update_tool_or_equip/3,
  update_bag/3,
  add_te/3,
  delete_te/3,
  upgrade_te/4,
  init_base_info/3,
  init_tools_or_equips/2,
  init_bag/2, append_msg/2]).

%% 创建初始化玩家
-spec create(Name :: string(), Role :: string(), Pass :: string()) -> player().
create(Name, Role, Pass) ->
  #{
      <<"index">> => Name,
      <<"pass">>  => dhcrypt:md5(Pass),
      <<"role">>  => Role,
      <<"base">>  => init_base_info(Name, 1, 0),
      <<"bag">>   => init_bag(init_tools_or_equips(0, []), init_tools_or_equips(0, [])),
      <<"msgs">>  => []
  }.

%% 修改玩家 一级Key
-spec update(Key :: binary(), Value :: any(), Player :: player()) -> player().
update(Key, Value, Player) ->
  case Key of
     <<"index">> ->
       Base_ = update_base(<<"name">>, Value, maps:get(<<"base">>, Player)),
       Player#{Key := Value, <<"base">> := Base_};
     <<"pass">>  ->
       Player#{Key := dhcrypt:md5(Value)};
     _     ->
       Player#{Key := Value}
  end.

%% 修改基本信息 一级Key
-spec update_base(Key :: binary(), Value :: any(), Base :: baseInfo()) -> baseInfo().
update_base(Key, Value, Base) ->
  Base#{Key := Value}.

%% 修改装备/工具 一级Key
-spec update_tool_or_equip(Key :: binary(), Value :: any(), Te :: toolsOrEquips()) -> toolsOrEquips().
update_tool_or_equip(Key, Value, Te) ->
  Te#{Key := Value}.

%% 修改背包 一级Key
-spec update_bag(Key :: binary(), Value :: any(), Bag :: bag()) -> bag().
update_bag(Key, Value, Bag) ->
  Bag#{Key := Value}.

%% 初始化基本信息
-spec init_base_info(string(), integer(), integer()) -> player_options:baseInfo().
init_base_info(Name, Lv, Logo) -> #{<<"name">> => Name, <<"lv">> => Lv, <<"logo">> => Logo}.

%% 初始化 装备 及 道具
-spec init_tools_or_equips(integer(), list(player_options:baseInfo())) -> player_options:toolsOrEquips().
init_tools_or_equips(Size, List) -> #{<<"count">> => Size, <<"details">> => List}.

%% 初始化 背包
-spec init_bag(Tools :: toolsOrEquips(), Equips :: toolsOrEquips()) -> bag().
init_bag(Tools, Equips) -> #{<<"tools">> => Tools, <<"equips">> => Equips}.

%% 玩家升级 Ups 为升级数
-spec upgrade(Player :: player(), Ups :: integer()) -> player().
upgrade(Player, Ups) ->
  Base_ = maps:get(<<"base">>, Player),
  Base_up_ = update_base(<<"lv">>, maps:get(<<"lv">>, Base_) + Ups, Base_),
  Player#{<<"base">> := Base_up_}.

%% 修改用户名
-spec change_name(Name :: string(), Player :: player()) -> player().
change_name(Name, Player) ->
  update(<<"index">>, Name, Player).

%% 修改密码
-spec change_pass(Pass :: string(), Player :: player()) -> player().
change_pass(Pass, Player) ->
  update(<<"pass">>, Pass, Player).

%% 修改角色
-spec chang_role(Role :: string(), Player :: player()) -> player().
chang_role(Role, Player) ->
  update(<<"role">>, Role, Player).

%% 添加道具/装备
-spec add_te(Type :: atom(), Tes :: list(toolsOrEquips()), Player :: player()) -> player().
add_te(Type, Tes, Player) ->
  Bag_    = maps:get(<<"bag">>, Player),
  Tes_    = maps:get(Type, Bag_),
  Details = maps:get(<<"details">>, Tes_),
  Count   = maps:get(<<"count">>, Tes_),
  case Type of
    <<"tools">>  ->
      Tools = init_tools_or_equips(Count + maps:get(<<"count">>, Tes), Details ++ maps:get(<<"details">>, Tes)),
      Player#{<<"bag">> := Bag_#{<<"tools">> := Tools}};
    <<"equips">> ->
      Equips = init_tools_or_equips(Count + maps:get(<<"count">>, Tes), Details ++ maps:get(<<"details">>, Tes)),
      Player#{<<"bag">> := Bag_#{<<"equips">> := Equips}}
  end.

%% 删除道具/装备
-spec delete_te(Type :: atom(), Tes :: toolsOrEquips(), Player :: player()) -> player().
delete_te(Type, Tes, Player) ->
  Bag_    = maps:get(<<"bag">>, Player),
  Tes_    = maps:get(Type, Bag_),
  Details = maps:get(<<"details">>, Tes_),
  Count   = maps:get(<<"count">>, Tes_),
  Target = filter(Tes, Details),
  lager:info("[~p] delete ~p [~p] ~n", [self(), Type, Target]),
  if
    length(Target) =/= 0 ->
      case Type of
        <<"tools">>  ->
          Tools = init_tools_or_equips(Count - 1, Details -- [Target]),
          Player#{<<"bag">> := Bag_#{<<"tools">> := Tools}};
        <<"equips">> ->
          Equips = init_tools_or_equips(Count - 1, Details -- [Target]),
          Player#{<<"bag">> := Bag_#{<<"equips">> := Equips}}
      end;
    true ->
      Player
  end.

%% 道具/装备升级
-spec upgrade_te(Type :: atom(), Tes :: toolsOrEquips(), Ups :: integer(), Player :: player()) -> player().
upgrade_te(Type, Tes, Ups, Player) ->
  Bag_    = maps:get(<<"bag">>, Player),
  Tes_    = maps:get(Type, Bag_),
  Details = maps:get(<<"details">>, Tes_),
  Count   = maps:get(<<"count">>, Tes_),
  Target = filter(Tes, Details),
  case Type of
    <<"tools">>  ->
      Tools = init_tools_or_equips(Count, lists:delete(Target, Details) ++ [update_base(<<"lv">>, maps:get(<<"lv">>, Target) + Ups, Target)]),
      Player#{<<"bag">> := Bag_#{<<"tools">> := Tools}};
    <<"equips">> ->
      Equips = init_tools_or_equips(Count, lists:delete(Target, Details) ++ [update_base(<<"lv">>, maps:get(<<"lv">>, Target) + Ups, Target)]),
      Player#{<<"bag">> := Bag_#{<<"equips">> := Equips}}
  end.

%% 追加 消息
-spec append_msg(Msg :: msg(), Player :: player()) -> player().
append_msg(Msg, Player) ->
  Msgs = maps:get(<<"msgs">>, Player) ++ [Msg],
  update(<<"msgs">>, Msgs, Player).

%% 根据 key-value 查找
-spec filter(Target :: string(), List :: list(baseInfo())) -> baseInfo().
filter(Target, List) ->
  Find = fun(Info) -> Target =:= Info end,
  AllTarget = lists:filter(Find, List),
  if
    length(AllTarget) > 1   ->
      [H|_] = AllTarget, H;
    length(AllTarget) =< 1 -> AllTarget
  end.
