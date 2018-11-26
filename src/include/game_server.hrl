%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 十一月 2018 下午3:43
%%%-------------------------------------------------------------------
-author("dhcd").

-define(HOST, {127,0,0,1}).
-define(PORT, 8080).
-define(SOCKET_OPTS, [binary, {packet, 2}, {active, true}, {reuseaddr, true}, {nodelay, true},
  {delay_send, false}, {send_timeout, 5000},{keepalive, true},{ip, ?HOST} ]).