%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 十一月 2018 下午3:33
%%%-------------------------------------------------------------------
-module(player_mongo_options).
-author("dhcd").

-define(CONNECT_URL, <<"10.0.0.13:7109">>).
-define(COLLECTION_NAME, <<<<"test">>/binary, $., <<"player">>/binary>>).

%% API
-export([
  add_player/1,
  find_player/1,
  update_player/1,
  delete_player/1,
  find_player/3]).

add_player(Player) ->
  mongo:insert(?CONNECT_URL, ?COLLECTION_NAME, Player).

find_player(Name) ->
  mongo:findOne(?CONNECT_URL, ?COLLECTION_NAME, #{<<"index">> => Name}).

find_player(Name, Role, Pass) ->
  mongo:findOne(?CONNECT_URL, ?COLLECTION_NAME, #{<<"index">> => Name, <<"role">> => Role, <<"pass">> => dhcrypt:md5(Pass)}).

update_player(Player) ->
  UpUnit = #{<<"q">> => #{<<"_id">> => maps:get(<<"_id">>, Player)},
             <<"u">>  => #{<<"$set">> => Player},
             <<"upsert">> => true},
  mongo:update(?CONNECT_URL, ?COLLECTION_NAME, UpUnit).

delete_player(Name) ->
  mongo:deleteOne(?CONNECT_URL, ?COLLECTION_NAME, #{<<"index">> => Name}).