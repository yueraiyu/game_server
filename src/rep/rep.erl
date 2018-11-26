%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 十一月 2018 下午6:28
%%%-------------------------------------------------------------------
-module(rep).
-author("dhcd").

%% API

-export_type([rep/0]).

-export([handle_rep/1]).

-type rep() ::
  #{
    status => integer(),
    data   => term()
  }.

%% 处理请求
-spec handle_rep(Rep :: rep()) -> {Status :: string(), Data :: term()}.
handle_rep(Rep) ->
  {maps:get(status, Rep), maps:get(data, Rep)}.