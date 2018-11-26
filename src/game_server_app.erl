-module(game_server_app).

-behaviour(application).

%% include server define
-include("include/game_server.hrl").

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    CountAcceptor = 1,
    ConnectorCreate = {supervisor, start_child, [connection_sup, []]},
    DHTcpMode = agent,

    dhtcp:start(?PORT, ?SOCKET_OPTS, CountAcceptor, ConnectorCreate, DHTcpMode),
    lager:info("[~p] game server started, tcp started listened port is ~p", [self(), ?PORT]),
    game_server_sup:start_link().

stop(_State) ->
    ok.
