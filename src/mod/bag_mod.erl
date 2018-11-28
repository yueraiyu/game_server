%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十一月 2018 下午1:53
%%%-------------------------------------------------------------------
-module(bag_mod).
-author("dhcd").

%% API
-export([init_bag/2, update_tool_or_equip/3, update_bag/3, add_te/3, delete_te/3, upgrade_te/4, init_tools_or_equips/2]).

%% 初始化 装备 及 道具
-spec init_tools_or_equips(integer(), list(type:baseInfo())) -> type:toolsOrEquips().
init_tools_or_equips(Size, List) ->
  #{
    <<"count">> => Size,
    <<"details">> => List
  }.

%% 初始化 背包
-spec init_bag(Tools :: type:toolsOrEquips(), Equips :: type:toolsOrEquips()) -> type:bag().
init_bag(Tools, Equips) ->
  #{
    <<"tools">> => Tools,
    <<"equips">> => Equips
  }.

%% 修改装备/工具 一级Key
-spec update_tool_or_equip(Key :: binary(), Value :: any(), Te :: type:toolsOrEquips()) -> type:toolsOrEquips().
update_tool_or_equip(Key, Value, Te) ->
  Te#{Key := Value}.

%% 修改背包 一级Key
-spec update_bag(Key :: binary(), Value :: any(), Bag :: type:bag()) -> type:bag().
update_bag(Key, Value, Bag) ->
  Bag#{Key := Value}.

%% 添加道具/装备
-spec add_te(Type :: binary(), Tes :: list(type:baseInfo()), Bag :: type:bag()) -> type:bag().
add_te(Type, Tes, Bag) ->
  #{Type := #{<<"details">> := Details, <<"count">> := Count}} = Bag,
  case Type of
    <<"tools">>  ->
      Tools = init_tools_or_equips(length(Tes) + Count, Tes ++ Details),
      update_bag(Type, Tools, Bag);
    <<"equips">> ->
      Equips = init_tools_or_equips(length(Tes) + Count, Tes ++ Details),
      update_bag(Type, Equips, Bag)
  end.

%% 删除道具/装备
-spec delete_te(Type :: binary(), Tes :: type:baseInfo(), Bag :: type:bag()) -> type:bag().
delete_te(Type, Tes, Bag) ->
  #{Type := #{<<"details">> := Details, <<"count">> := Count}} = Bag,
  Target = filter(Tes, Details),
  if
    length(Target) =/= 0 ->
      case Type of
        <<"tools">>  ->
          Tools = init_tools_or_equips(Count - 1, Details -- [Target]),
          update_bag(Type, Tools, Bag);
        <<"equips">> ->
          Equips = init_tools_or_equips(Count - 1, Details -- [Target]),
          update_bag(Type, Equips, Bag)
      end;
    true ->
      Bag
  end.

%% 道具/装备升级
-spec upgrade_te(Type :: binary(), Tes :: type:toolsOrEquips(), Ups :: integer(), Bag :: type:bag()) -> type:bag().
upgrade_te(Type, #{lv := Lv} = Tes, Ups, Bag) ->
  #{Type := #{<<"details">> := Details, <<"count">> := Count}} = Bag,
  Target = filter(Tes, Details),
  if
    length(Target) =/= 0 ->
      case Type of
        <<"tools">>  ->
          Tools = init_tools_or_equips(Count, lists:delete(Target, Details) ++ [base_info_mod:update_base(<<"lv">>, Lv + Ups, Target)]),
          update_bag(Type, Tools, Bag);
        <<"equips">> ->
          Equips = init_tools_or_equips(Count, lists:delete(Target, Details) ++ [base_info_mod:update_base(<<"lv">>, Lv + Ups, Target)]),
          update_bag(Type, Equips, Bag)
      end;
    true ->
      Bag
  end.

%% 根据 key-value 查找
-spec filter(Target :: string(), List :: list(type:baseInfo())) -> type:baseInfo().
filter(Target, List) ->
  Find = fun(Info) -> Target =:= Info end,
  AllTarget = lists:filter(Find, List),
  if
    length(AllTarget) > 1   ->
      [H|_] = AllTarget, H;
    length(AllTarget) =< 1 -> AllTarget
  end.