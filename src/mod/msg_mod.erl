%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十一月 2018 下午2:01
%%%-------------------------------------------------------------------
-module(msg_mod).
-author("dhcd").

%% API
-export([append_msg/2, init_msg/3]).

%% 初始化消息
-spec init_msg(From :: atom(), Target ::atom(), Msg :: string()) -> type:msg().
init_msg(From, Target, Msg) ->
  #{
    <<"from">>    => From,
    <<"target">>  => Target,
    <<"msg">>     => Msg
  }.

%% 追加 消息
-spec append_msg(Msg :: type:msg(), Msgs :: list(type:msg())) -> list(type:msg()).
append_msg(Msg, Msgs) ->
  Msgs ++ Msg.