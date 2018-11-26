%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 十一月 2018 下午6:28
%%%-------------------------------------------------------------------
-module(req).
-author("dhcd").

%% API
-export([handle_req/1]).

-export_type([req/0]).

-type req() ::
  #{
    oper => string(),
    data => term()
  }.

%% 处理请求
-spec handle_req(Req :: req()) -> {Oper :: string(), Data :: term()}.
handle_req(Req) ->
  {maps:get(oper, Req), maps:get(data, Req)}.
