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

-include("../../include/game_server_pb.hrl").

-export_type([req/0]).

-type req() ::
  #{
    oper => string(),
    data => term()
  }.

%% 处理请求
%%-spec handle_req(Req :: req()) -> {Oper :: string(), Data :: term()}.
handle_req(<<Op:8, Req/binary>>) ->
  case Op of
    1 ->
      LoginReq = game_server_pb:decode_login_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(LoginReq#login_request.oper))), LoginReq#login_request.data};
    2 ->
      RegisterReq = game_server_pb:decode_register_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(RegisterReq#register_request.oper))), RegisterReq#register_request.data};
    3 ->
      LoginOutReq = game_server_pb:decode_login_out_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(LoginOutReq#login_out_request.oper))), LoginOutReq#login_out_request.data};
    4 ->
      UpgradeReq = game_server_pb:decode_upgrade_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(UpgradeReq#upgrade_request.oper))), UpgradeReq#upgrade_request.data};
    5 ->
      ChangeNameReq = game_server_pb:decode_change_name_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(ChangeNameReq#change_name_request.oper))), ChangeNameReq#change_name_request.data};
    6 ->
      ChangePassReq = game_server_pb:decode_change_pass_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(ChangePassReq#change_pass_request.oper))), ChangePassReq#change_pass_request.data};
    7 ->
      ChangeRoleReq = game_server_pb:decode_change_role_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(ChangeRoleReq#change_role_request.oper))), ChangeRoleReq#change_role_request.data};
    8 ->
      AddToolsReq = game_server_pb:decode_add_tools_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(AddToolsReq#add_tools_request.oper))), AddToolsReq#add_tools_request.data};
    9 ->
      DeleteToolReq = game_server_pb:decode_delete_tools_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(DeleteToolReq#delete_tools_request.oper))), DeleteToolReq#delete_tools_request.data};
    10 ->
      UpgradeToolReq = game_server_pb:decode_upgrade_tools_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(UpgradeToolReq#upgrade_tools_request.oper))), UpgradeToolReq#upgrade_tools_request.data};
    11 ->
      AddEquipsReq = game_server_pb:decode_add_equips_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(AddEquipsReq#add_equips_request.oper))), AddEquipsReq#add_equips_request.data};
    12 ->
      DeleteEquipReq = game_server_pb:decode_delete_equips_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(DeleteEquipReq#delete_equips_request.oper))), DeleteEquipReq#delete_equips_request.data};
    13 ->
      UpgradeEquipReq = game_server_pb:decode_upgrade_equips_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(UpgradeEquipReq#upgrade_equips_request.oper))), UpgradeEquipReq#upgrade_equips_request.data};
    14 ->
      InfoReq = game_server_pb:decode_info_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(InfoReq#info_request.oper))), InfoReq#info_request.data};
    15 ->
      SendMsgReq = game_server_pb:decode_send_msg_request(Req),
      {list_to_atom(string:to_lower(atom_to_list(SendMsgReq#send_msg_request.oper))), SendMsgReq#send_msg_request.data}
  end.
