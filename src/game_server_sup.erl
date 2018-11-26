-module(game_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    lager:info("[~p] game server init", [self()]),
    Child = #{id => connection_sup,
        start => {connection_sup, start_link, []},
        restart => temporary,
        shutdown => 2000,
        type => supervisor,
        modules => [connection_sup]},
    {ok, {{one_for_one, 5, 10}, [Child]}}.

