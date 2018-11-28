%%%-------------------------------------------------------------------
%%% @author dhcd
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十一月 2018 下午1:41
%%%-------------------------------------------------------------------
-module(type).
-author("dhcd").

%% API
-export([]).

-type player() ::
#{
  index => atom(),
  pass  => string(),
  role  => atom(),
  base  => baseInfo(),
  bag   => bag(),
  msgs  => list(msg())
}.

-type baseInfo() ::
#{
  name  => atom(),
  lv    => integer(),
  logo  => integer()
}.

-type toolsOrEquips() ::
#{
  count   => integer(),
  details => list(baseInfo())
}.

-type bag() ::
#{
  tools   => toolsOrEquips(),
  equips  => toolsOrEquips()
}.

-type msg() ::
#{
  from   => atom(),
  target => atom(),
  msg    => string()
}.