-ifndef(LOGIN_REQUEST_PB_H).
-define(LOGIN_REQUEST_PB_H, true).
-record(login_request, {
    oper = 'LOGIN',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(REGISTER_REQUEST_PB_H).
-define(REGISTER_REQUEST_PB_H, true).
-record(register_request, {
    oper = 'REGISTER',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(LOGIN_OUT_REQUEST_PB_H).
-define(LOGIN_OUT_REQUEST_PB_H, true).
-record(login_out_request, {
    oper = 'LOGIN_OUT',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(UPGRADE_REQUEST_PB_H).
-define(UPGRADE_REQUEST_PB_H, true).
-record(upgrade_request, {
    oper = 'UPGRADE',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(CHANGE_NAME_REQUEST_PB_H).
-define(CHANGE_NAME_REQUEST_PB_H, true).
-record(change_name_request, {
    oper = 'CHANGE_NAME',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(CHANGE_PASS_REQUEST_PB_H).
-define(CHANGE_PASS_REQUEST_PB_H, true).
-record(change_pass_request, {
    oper = 'CHANGE_PASS',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(CHANGE_ROLE_REQUEST_PB_H).
-define(CHANGE_ROLE_REQUEST_PB_H, true).
-record(change_role_request, {
    oper = 'CHANGE_ROLE',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(ADD_TOOLS_REQUEST_PB_H).
-define(ADD_TOOLS_REQUEST_PB_H, true).
-record(add_tools_request, {
    oper = 'ADD_TOOLS',
    data = []
}).
-endif.

-ifndef(DELETE_TOOLS_REQUEST_PB_H).
-define(DELETE_TOOLS_REQUEST_PB_H, true).
-record(delete_tools_request, {
    oper = 'DELETE_TOOLS',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(UPGRADE_TOOLS_REQUEST_PB_H).
-define(UPGRADE_TOOLS_REQUEST_PB_H, true).
-record(upgrade_tools_request, {
    oper = 'UPGRADE_TOOLS',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(ADD_EQUIPS_REQUEST_PB_H).
-define(ADD_EQUIPS_REQUEST_PB_H, true).
-record(add_equips_request, {
    oper = 'ADD_EQUIPS',
    data = []
}).
-endif.

-ifndef(DELETE_EQUIPS_REQUEST_PB_H).
-define(DELETE_EQUIPS_REQUEST_PB_H, true).
-record(delete_equips_request, {
    oper = 'DELETE_EQUIPS',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(UPGRADE_EQUIPS_REQUEST_PB_H).
-define(UPGRADE_EQUIPS_REQUEST_PB_H, true).
-record(upgrade_equips_request, {
    oper = 'UPGRADE_EQUIPS',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(INFO_REQUEST_PB_H).
-define(INFO_REQUEST_PB_H, true).
-record(info_request, {
    oper = 'INFO',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(SEND_MSG_REQUEST_PB_H).
-define(SEND_MSG_REQUEST_PB_H, true).
-record(send_msg_request, {
    oper = 'SEND_MSG',
    data = erlang:error({required, data})
}).
-endif.

-ifndef(BASE_INFO_PB_H).
-define(BASE_INFO_PB_H, true).
-record(base_info, {
    name = erlang:error({required, name}),
    pass = erlang:error({required, pass}),
    role = erlang:error({required, role})
}).
-endif.

-ifndef(EMPTY_PB_H).
-define(EMPTY_PB_H, true).
-record(empty, {
    
}).
-endif.

-ifndef(TE_PB_H).
-define(TE_PB_H, true).
-record(te, {
    name = erlang:error({required, name}),
    lv = erlang:error({required, lv}),
    logo = erlang:error({required, logo})
}).
-endif.

-ifndef(CHANGE_NAME_REQUEST_CHANGE_NAME_PB_H).
-define(CHANGE_NAME_REQUEST_CHANGE_NAME_PB_H, true).
-record(change_name_request_change_name, {
    new_name = erlang:error({required, new_name})
}).
-endif.

-ifndef(CHANGE_PASS_REQUEST_CHANGE_PASS_PB_H).
-define(CHANGE_PASS_REQUEST_CHANGE_PASS_PB_H, true).
-record(change_pass_request_change_pass, {
    new_pass = erlang:error({required, new_pass})
}).
-endif.

-ifndef(CHANGE_ROLE_REQUEST_CHANGE_ROLE_PB_H).
-define(CHANGE_ROLE_REQUEST_CHANGE_ROLE_PB_H, true).
-record(change_role_request_change_role, {
    new_role = erlang:error({required, new_role})
}).
-endif.

-ifndef(SEND_MSG_REQUEST_MESSAGE_PB_H).
-define(SEND_MSG_REQUEST_MESSAGE_PB_H, true).
-record(send_msg_request_message, {
    from = erlang:error({required, from}),
    target = erlang:error({required, target}),
    msg = erlang:error({required, msg})
}).
-endif.

