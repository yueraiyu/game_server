%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十一月 2018 下午2:00
%%%-------------------------------------------------------------------
-module(base_info_mod).
-author("dhcd").

%% API
-export([init_base_info/3, update_base/3]).

%% 初始化基本信息
-spec init_base_info(string(), integer(), integer()) -> type:baseInfo().
init_base_info(Name, Lv, Logo) ->
  #{
    <<"name">> => Name,
    <<"lv">> => Lv,
    <<"logo">> => Logo
  }.

%% 修改基本信息 一级Key
-spec update_base(Key :: binary(), Value :: any(), Base :: type:baseInfo()) -> type:baseInfo().
update_base(Key, Value, Base) ->
  Base#{Key := Value}.