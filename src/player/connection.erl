%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 22. 十一月 2018 下午4:36
%%%-------------------------------------------------------------------
-module(connection).
-author("dhcd").

-behaviour(gen_server).

%% include server define
-include("../include/game_server.hrl").

%% connection api
-export([]).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {conn :: pid(), player :: player_options:player()}).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% Starts the server
%%
%% @end
%%--------------------------------------------------------------------
-spec(start_link() ->
  {ok, Pid :: pid()} | ignore | {error, Reason :: term()}).
start_link() ->
  gen_server:start_link(?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Initializes the server
%%
%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore |
%%                     {stop, Reason}
%% @end
%%--------------------------------------------------------------------
-spec(init(Args :: term()) ->
  {ok, State :: #state{}} | {ok, State :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term()} | ignore).
init([]) ->
  lager:info("[~p] connection init success", [self()]),
  {ok, #state{}}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling call messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_call(Request :: term(), From :: {pid(), Tag :: term()},
    State :: #state{}) ->
  {reply, Reply :: term(), NewState :: #state{}} |
  {reply, Reply :: term(), NewState :: #state{}, timeout() | hibernate} |
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), Reply :: term(), NewState :: #state{}} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_call(_Request, _From, State) ->
  {reply, ok, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling cast messages
%%
%% @end
%%--------------------------------------------------------------------
-spec(handle_cast(Request :: term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_cast({response, {Oper, Data}}, State) ->
  if
    Oper =/= login , Oper =/= register , State#state.player =:= undefined ->
      dhtcp_conn:send(State#state.conn, term_to_binary(#{status => 400, data => login_or_register})),
      {noreply, State};
    Oper =:= send_msg ->
      send_msg(Data),
      dhtcp_conn:send(State#state.conn, term_to_binary(#{status => 200, data => send_msg_success})),
      {ok, Player} = player_logic_options:append_msg(Data, State#state.player),
      {noreply, State#state{player = Player}};
    true ->
      case apply(player_logic_options, Oper, [Data, State#state.player]) of
        {ok, Rep} ->
          dhtcp_conn:send(State#state.conn, term_to_binary(#{status => 200, data => Rep})),

          case Oper of
             login    ->
               gproc:reg({n, l, maps:get(<<"index">>, Rep)}, State#state.conn),
               lager:info("[~p] login success, regist ~p as ~p ~n", [self(), gproc:lookup_pid({n, l, maps:get(<<"index">>, Rep)}), maps:get(<<"index">>, Rep)]);
             register ->
               gproc:reg({n, l, maps:get(<<"index">>, Rep)}, State#state.conn),
               lager:info("[~p] register success, regist ~p as ~p ~n", [self(), gproc:lookup_pid({n, l, maps:get(<<"index">>, Rep)}), maps:get(<<"index">>, Rep)])
          end,

          case Rep of
            login_out ->
              {stop, login_out, #state{}};
            Player ->
              {noreply, State#state{player = Player}}
          end;
        {error, Reason} ->
          dhtcp_conn:send(State#state.conn, term_to_binary(#{status => 500, data => Reason})),
          {noreply, State};
        {warring, Reason} ->
          dhtcp_conn:send(State#state.conn, term_to_binary(#{status => 400, data => Reason})),
          {noreply, State}
    end
  end;
handle_cast(_Request, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Handling all non call/cast messages
%%
%% @spec handle_info(Info, State) -> {noreply, State} |
%%                                   {noreply, State, Timeout} |
%%                                   {stop, Reason, State}
%% @end
%%--------------------------------------------------------------------
-spec(handle_info(Info :: timeout() | term(), State :: #state{}) ->
  {noreply, NewState :: #state{}} |
  {noreply, NewState :: #state{}, timeout() | hibernate} |
  {stop, Reason :: term(), NewState :: #state{}}).
handle_info({dhtcp, _Pid, Req}, State) ->
  lager:info("[~p] receive request [~p] from [~p:~p]~n", [self(), binary_to_term(Req), ?HOST, ?PORT]),
  map_req(binary_to_term(Req)),
  {noreply, State};
handle_info({dhconn_start, Pid}, State) ->
  lager:info("[~p] connect created, pid is [~p]", [self(), Pid]),
  {noreply, State#state{conn = Pid}};
handle_info({message, Data}, State) ->
  lager:info("[~p] receive message from [~p] : [~p]", [self(), maps:get(from, Data), maps:get(msg, Data)]),
  {ok, Player} = player_logic_options:append_msg(Data, State#state.player),
  {noreply, State#state{player = Player}};
handle_info(_Info, State) ->
  {noreply, State}.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% This function is called by a gen_server when it is about to
%% terminate. It should be the opposite of Module:init/1 and do any
%% necessary cleaning up. When it returns, the gen_server terminates
%% with Reason. The return value is ignored.
%%
%% @spec terminate(Reason, State) -> void()
%% @end
%%--------------------------------------------------------------------
-spec(terminate(Reason :: (normal | shutdown | {shutdown, term()} | term()),
    State :: #state{}) -> term()).
terminate(_Reason, _State) ->
  ok.

%%--------------------------------------------------------------------
%% @private
%% @doc
%% Convert process state when code is changed
%%
%% @spec code_change(OldVsn, State, Extra) -> {ok, NewState}
%% @end
%%--------------------------------------------------------------------
-spec(code_change(OldVsn :: term() | {down, term()}, State :: #state{},
    Extra :: term()) ->
  {ok, NewState :: #state{}} | {error, Reason :: term()}).
code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
map_req(Req) ->
  case req:handle_req(Req) of
    {Oper, Data} ->
      lager:info("[~p] receive ~p request, receive request data ~p", [self(), Oper, Data]),
      gen_server:cast(self(), {response, {Oper, Data}});
    other ->
      lager:error("[~p] request [~p] error", [self(), other])
  end.

send_msg(Data) ->
  lager:info("[~p] ~p send [~p] to ~p ~n", [self(), maps:get(from, Data), maps:get(msg, Data), maps:get(target, Data)]),
  Target = gproc:lookup_pid({n, l, maps:get(target, Data)}),
  Target ! {message, Data},
  dhtcp_conn:send(Target, term_to_binary(#{status => 200, data => {message, Data}})).