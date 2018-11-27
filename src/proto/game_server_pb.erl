-file("src/game_server_pb.erl", 1).

-module(game_server_pb).

-export([encode_send_msg_request_message/1,
	 decode_send_msg_request_message/1,
	 delimited_decode_send_msg_request_message/1,
	 encode_change_role_request_change_role/1,
	 decode_change_role_request_change_role/1,
	 delimited_decode_change_role_request_change_role/1,
	 encode_change_pass_request_change_pass/1,
	 decode_change_pass_request_change_pass/1,
	 delimited_decode_change_pass_request_change_pass/1,
	 encode_change_name_request_change_name/1,
	 decode_change_name_request_change_name/1,
	 delimited_decode_change_name_request_change_name/1,
	 encode_te/1, decode_te/1, delimited_decode_te/1,
	 encode_empty/1, decode_empty/1,
	 delimited_decode_empty/1, encode_base_info/1,
	 decode_base_info/1, delimited_decode_base_info/1,
	 encode_send_msg_request/1, decode_send_msg_request/1,
	 delimited_decode_send_msg_request/1,
	 encode_info_request/1, decode_info_request/1,
	 delimited_decode_info_request/1,
	 encode_upgrade_equips_request/1,
	 decode_upgrade_equips_request/1,
	 delimited_decode_upgrade_equips_request/1,
	 encode_delete_equips_request/1,
	 decode_delete_equips_request/1,
	 delimited_decode_delete_equips_request/1,
	 encode_add_equips_request/1,
	 decode_add_equips_request/1,
	 delimited_decode_add_equips_request/1,
	 encode_upgrade_tools_request/1,
	 decode_upgrade_tools_request/1,
	 delimited_decode_upgrade_tools_request/1,
	 encode_delete_tools_request/1,
	 decode_delete_tools_request/1,
	 delimited_decode_delete_tools_request/1,
	 encode_add_tools_request/1, decode_add_tools_request/1,
	 delimited_decode_add_tools_request/1,
	 encode_change_role_request/1,
	 decode_change_role_request/1,
	 delimited_decode_change_role_request/1,
	 encode_change_pass_request/1,
	 decode_change_pass_request/1,
	 delimited_decode_change_pass_request/1,
	 encode_change_name_request/1,
	 decode_change_name_request/1,
	 delimited_decode_change_name_request/1,
	 encode_upgrade_request/1, decode_upgrade_request/1,
	 delimited_decode_upgrade_request/1,
	 encode_login_out_request/1, decode_login_out_request/1,
	 delimited_decode_login_out_request/1,
	 encode_register_request/1, decode_register_request/1,
	 delimited_decode_register_request/1,
	 encode_login_request/1, decode_login_request/1,
	 delimited_decode_login_request/1]).

-export([has_extension/2, extension_size/1,
	 get_extension/2, set_extension/3]).

-export([decode_extensions/1]).

-export([encode/1, decode/2, delimited_decode/2]).

-export([int_to_enum/2, enum_to_int/2]).

-record(send_msg_request_message, {from, target, msg}).

-record(change_role_request_change_role, {new_role}).

-record(change_pass_request_change_pass, {new_pass}).

-record(change_name_request_change_name, {new_name}).

-record(te, {name, lv, logo}).

-record(empty, {}).

-record(base_info, {name, pass, role}).

-record(send_msg_request, {oper, data}).

-record(info_request, {oper, data}).

-record(upgrade_equips_request, {oper, data}).

-record(delete_equips_request, {oper, data}).

-record(add_equips_request, {oper, data}).

-record(upgrade_tools_request, {oper, data}).

-record(delete_tools_request, {oper, data}).

-record(add_tools_request, {oper, data}).

-record(change_role_request, {oper, data}).

-record(change_pass_request, {oper, data}).

-record(change_name_request, {oper, data}).

-record(upgrade_request, {oper, data}).

-record(login_out_request, {oper, data}).

-record(register_request, {oper, data}).

-record(login_request, {oper, data}).

encode([]) -> [];
encode(Records) when is_list(Records) ->
    delimited_encode(Records);
encode(Record) -> encode(element(1, Record), Record).

encode_send_msg_request_message(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_send_msg_request_message(Record)
    when is_record(Record, send_msg_request_message) ->
    encode(send_msg_request_message, Record).

encode_change_role_request_change_role(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_role_request_change_role(Record)
    when is_record(Record,
		   change_role_request_change_role) ->
    encode(change_role_request_change_role, Record).

encode_change_pass_request_change_pass(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_pass_request_change_pass(Record)
    when is_record(Record,
		   change_pass_request_change_pass) ->
    encode(change_pass_request_change_pass, Record).

encode_change_name_request_change_name(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_name_request_change_name(Record)
    when is_record(Record,
		   change_name_request_change_name) ->
    encode(change_name_request_change_name, Record).

encode_te(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_te(Record) when is_record(Record, te) ->
    encode(te, Record).

encode_empty(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_empty(Record) when is_record(Record, empty) ->
    encode(empty, Record).

encode_base_info(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_base_info(Record)
    when is_record(Record, base_info) ->
    encode(base_info, Record).

encode_send_msg_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_send_msg_request(Record)
    when is_record(Record, send_msg_request) ->
    encode(send_msg_request, Record).

encode_info_request(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_info_request(Record)
    when is_record(Record, info_request) ->
    encode(info_request, Record).

encode_upgrade_equips_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_upgrade_equips_request(Record)
    when is_record(Record, upgrade_equips_request) ->
    encode(upgrade_equips_request, Record).

encode_delete_equips_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_delete_equips_request(Record)
    when is_record(Record, delete_equips_request) ->
    encode(delete_equips_request, Record).

encode_add_equips_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_add_equips_request(Record)
    when is_record(Record, add_equips_request) ->
    encode(add_equips_request, Record).

encode_upgrade_tools_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_upgrade_tools_request(Record)
    when is_record(Record, upgrade_tools_request) ->
    encode(upgrade_tools_request, Record).

encode_delete_tools_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_delete_tools_request(Record)
    when is_record(Record, delete_tools_request) ->
    encode(delete_tools_request, Record).

encode_add_tools_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_add_tools_request(Record)
    when is_record(Record, add_tools_request) ->
    encode(add_tools_request, Record).

encode_change_role_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_role_request(Record)
    when is_record(Record, change_role_request) ->
    encode(change_role_request, Record).

encode_change_pass_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_pass_request(Record)
    when is_record(Record, change_pass_request) ->
    encode(change_pass_request, Record).

encode_change_name_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_change_name_request(Record)
    when is_record(Record, change_name_request) ->
    encode(change_name_request, Record).

encode_upgrade_request(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_upgrade_request(Record)
    when is_record(Record, upgrade_request) ->
    encode(upgrade_request, Record).

encode_login_out_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_login_out_request(Record)
    when is_record(Record, login_out_request) ->
    encode(login_out_request, Record).

encode_register_request(Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode_register_request(Record)
    when is_record(Record, register_request) ->
    encode(register_request, Record).

encode_login_request(Records) when is_list(Records) ->
    delimited_encode(Records);
encode_login_request(Record)
    when is_record(Record, login_request) ->
    encode(login_request, Record).

encode(login_request, Records) when is_list(Records) ->
    delimited_encode(Records);
encode(login_request, Record) ->
    [iolist(login_request, Record)
     | encode_extensions(Record)];
encode(register_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(register_request, Record) ->
    [iolist(register_request, Record)
     | encode_extensions(Record)];
encode(login_out_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(login_out_request, Record) ->
    [iolist(login_out_request, Record)
     | encode_extensions(Record)];
encode(upgrade_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(upgrade_request, Record) ->
    [iolist(upgrade_request, Record)
     | encode_extensions(Record)];
encode(change_name_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_name_request, Record) ->
    [iolist(change_name_request, Record)
     | encode_extensions(Record)];
encode(change_pass_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_pass_request, Record) ->
    [iolist(change_pass_request, Record)
     | encode_extensions(Record)];
encode(change_role_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_role_request, Record) ->
    [iolist(change_role_request, Record)
     | encode_extensions(Record)];
encode(add_tools_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(add_tools_request, Record) ->
    [iolist(add_tools_request, Record)
     | encode_extensions(Record)];
encode(delete_tools_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(delete_tools_request, Record) ->
    [iolist(delete_tools_request, Record)
     | encode_extensions(Record)];
encode(upgrade_tools_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(upgrade_tools_request, Record) ->
    [iolist(upgrade_tools_request, Record)
     | encode_extensions(Record)];
encode(add_equips_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(add_equips_request, Record) ->
    [iolist(add_equips_request, Record)
     | encode_extensions(Record)];
encode(delete_equips_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(delete_equips_request, Record) ->
    [iolist(delete_equips_request, Record)
     | encode_extensions(Record)];
encode(upgrade_equips_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(upgrade_equips_request, Record) ->
    [iolist(upgrade_equips_request, Record)
     | encode_extensions(Record)];
encode(info_request, Records) when is_list(Records) ->
    delimited_encode(Records);
encode(info_request, Record) ->
    [iolist(info_request, Record)
     | encode_extensions(Record)];
encode(send_msg_request, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(send_msg_request, Record) ->
    [iolist(send_msg_request, Record)
     | encode_extensions(Record)];
encode(base_info, Records) when is_list(Records) ->
    delimited_encode(Records);
encode(base_info, Record) ->
    [iolist(base_info, Record) | encode_extensions(Record)];
encode(empty, Records) when is_list(Records) ->
    delimited_encode(Records);
encode(empty, Record) ->
    [iolist(empty, Record) | encode_extensions(Record)];
encode(te, Records) when is_list(Records) ->
    delimited_encode(Records);
encode(te, Record) ->
    [iolist(te, Record) | encode_extensions(Record)];
encode(change_name_request_change_name, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_name_request_change_name, Record) ->
    [iolist(change_name_request_change_name, Record)
     | encode_extensions(Record)];
encode(change_pass_request_change_pass, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_pass_request_change_pass, Record) ->
    [iolist(change_pass_request_change_pass, Record)
     | encode_extensions(Record)];
encode(change_role_request_change_role, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(change_role_request_change_role, Record) ->
    [iolist(change_role_request_change_role, Record)
     | encode_extensions(Record)];
encode(send_msg_request_message, Records)
    when is_list(Records) ->
    delimited_encode(Records);
encode(send_msg_request_message, Record) ->
    [iolist(send_msg_request_message, Record)
     | encode_extensions(Record)].

encode_extensions(_) -> [].

delimited_encode(Records) ->
    lists:map(fun (Record) ->
		      IoRec = encode(Record),
		      Size = iolist_size(IoRec),
		      [protobuffs:encode_varint(Size), IoRec]
	      end,
	      Records).

iolist(login_request, Record) ->
    [pack(1, optional,
	  with_default(Record#login_request.oper, 'LOGIN'),
	  operation, []),
     pack(2, required,
	  with_default(Record#login_request.data, none),
	  base_info, [])];
iolist(register_request, Record) ->
    [pack(1, optional,
	  with_default(Record#register_request.oper, 'REGISTER'),
	  operation, []),
     pack(2, required,
	  with_default(Record#register_request.data, none),
	  base_info, [])];
iolist(login_out_request, Record) ->
    [pack(1, optional,
	  with_default(Record#login_out_request.oper,
		       'LOGIN_OUT'),
	  operation, []),
     pack(2, required,
	  with_default(Record#login_out_request.data, none),
	  base_info, [])];
iolist(upgrade_request, Record) ->
    [pack(1, optional,
	  with_default(Record#upgrade_request.oper, 'UPGRADE'),
	  operation, []),
     pack(2, required,
	  with_default(Record#upgrade_request.data, none), empty,
	  [])];
iolist(change_name_request, Record) ->
    [pack(1, optional,
	  with_default(Record#change_name_request.oper,
		       'CHANGE_NAME'),
	  operation, []),
     pack(2, required,
	  with_default(Record#change_name_request.data, none),
	  change_name_request_change_name, [])];
iolist(change_pass_request, Record) ->
    [pack(1, optional,
	  with_default(Record#change_pass_request.oper,
		       'CHANGE_PASS'),
	  operation, []),
     pack(2, required,
	  with_default(Record#change_pass_request.data, none),
	  change_pass_request_change_pass, [])];
iolist(change_role_request, Record) ->
    [pack(1, optional,
	  with_default(Record#change_role_request.oper,
		       'CHANGE_ROLE'),
	  operation, []),
     pack(2, required,
	  with_default(Record#change_role_request.data, none),
	  change_role_request_change_role, [])];
iolist(add_tools_request, Record) ->
    [pack(1, optional,
	  with_default(Record#add_tools_request.oper,
		       'ADD_TOOLS'),
	  operation, []),
     pack(2, repeated,
	  with_default(Record#add_tools_request.data, none), te,
	  [])];
iolist(delete_tools_request, Record) ->
    [pack(1, optional,
	  with_default(Record#delete_tools_request.oper,
		       'DELETE_TOOLS'),
	  operation, []),
     pack(2, required,
	  with_default(Record#delete_tools_request.data, none),
	  te, [])];
iolist(upgrade_tools_request, Record) ->
    [pack(1, optional,
	  with_default(Record#upgrade_tools_request.oper,
		       'UPGRADE_TOOLS'),
	  operation, []),
     pack(2, required,
	  with_default(Record#upgrade_tools_request.data, none),
	  te, [])];
iolist(add_equips_request, Record) ->
    [pack(1, optional,
	  with_default(Record#add_equips_request.oper,
		       'ADD_EQUIPS'),
	  operation, []),
     pack(2, repeated,
	  with_default(Record#add_equips_request.data, none), te,
	  [])];
iolist(delete_equips_request, Record) ->
    [pack(1, optional,
	  with_default(Record#delete_equips_request.oper,
		       'DELETE_EQUIPS'),
	  operation, []),
     pack(2, required,
	  with_default(Record#delete_equips_request.data, none),
	  te, [])];
iolist(upgrade_equips_request, Record) ->
    [pack(1, optional,
	  with_default(Record#upgrade_equips_request.oper,
		       'UPGRADE_EQUIPS'),
	  operation, []),
     pack(2, required,
	  with_default(Record#upgrade_equips_request.data, none),
	  te, [])];
iolist(info_request, Record) ->
    [pack(1, optional,
	  with_default(Record#info_request.oper, 'INFO'),
	  operation, []),
     pack(2, required,
	  with_default(Record#info_request.data, none), empty,
	  [])];
iolist(send_msg_request, Record) ->
    [pack(1, optional,
	  with_default(Record#send_msg_request.oper, 'SEND_MSG'),
	  operation, []),
     pack(2, required,
	  with_default(Record#send_msg_request.data, none),
	  send_msg_request_message, [])];
iolist(base_info, Record) ->
    [pack(1, required,
	  with_default(Record#base_info.name, none), string, []),
     pack(2, required,
	  with_default(Record#base_info.pass, none), string, []),
     pack(3, required,
	  with_default(Record#base_info.role, none), string, [])];
iolist(empty, _Record) -> [];
iolist(te, Record) ->
    [pack(1, required, with_default(Record#te.name, none),
	  string, []),
     pack(2, required, with_default(Record#te.lv, none),
	  int32, []),
     pack(3, required, with_default(Record#te.logo, none),
	  int32, [])];
iolist(change_name_request_change_name, Record) ->
    [pack(1, required,
	  with_default(Record#change_name_request_change_name.new_name,
		       none),
	  string, [])];
iolist(change_pass_request_change_pass, Record) ->
    [pack(1, required,
	  with_default(Record#change_pass_request_change_pass.new_pass,
		       none),
	  string, [])];
iolist(change_role_request_change_role, Record) ->
    [pack(1, required,
	  with_default(Record#change_role_request_change_role.new_role,
		       none),
	  string, [])];
iolist(send_msg_request_message, Record) ->
    [pack(1, required,
	  with_default(Record#send_msg_request_message.from,
		       none),
	  string, []),
     pack(2, required,
	  with_default(Record#send_msg_request_message.target,
		       none),
	  string, []),
     pack(3, required,
	  with_default(Record#send_msg_request_message.msg, none),
	  string, [])].

with_default(Default, Default) -> undefined;
with_default(Val, _) -> Val.

pack(_, optional, undefined, _, _) -> [];
pack(_, repeated, undefined, _, _) -> [];
pack(_, repeated_packed, undefined, _, _) -> [];
pack(_, repeated_packed, [], _, _) -> [];
pack(FNum, required, undefined, Type, _) ->
    exit({error,
	  {required_field_is_undefined, FNum, Type}});
pack(_, repeated, [], _, Acc) -> lists:reverse(Acc);
pack(FNum, repeated, [Head | Tail], Type, Acc) ->
    pack(FNum, repeated, Tail, Type,
	 [pack(FNum, optional, Head, Type, []) | Acc]);
pack(FNum, repeated_packed, Data, Type, _) ->
    protobuffs:encode_packed(FNum, Data, Type);
pack(FNum, _, Data, _, _) when is_tuple(Data) ->
    [RecName | _] = tuple_to_list(Data),
    protobuffs:encode(FNum, encode(RecName, Data), bytes);
pack(FNum, _, Data, Type, _)
    when Type =:= bool;
	 Type =:= int32;
	 Type =:= uint32;
	 Type =:= int64;
	 Type =:= uint64;
	 Type =:= sint32;
	 Type =:= sint64;
	 Type =:= fixed32;
	 Type =:= sfixed32;
	 Type =:= fixed64;
	 Type =:= sfixed64;
	 Type =:= string;
	 Type =:= bytes;
	 Type =:= float;
	 Type =:= double ->
    protobuffs:encode(FNum, Data, Type);
pack(FNum, _, Data, Type, _) when is_atom(Data) ->
    protobuffs:encode(FNum, enum_to_int(Type, Data), enum).

enum_to_int(operation, 'SEND_MSG') -> 15;
enum_to_int(operation, 'INFO') -> 14;
enum_to_int(operation, 'UPGRADE_EQUIPS') -> 13;
enum_to_int(operation, 'DELETE_EQUIPS') -> 12;
enum_to_int(operation, 'ADD_EQUIPS') -> 11;
enum_to_int(operation, 'UPGRADE_TOOLS') -> 10;
enum_to_int(operation, 'DELETE_TOOLS') -> 9;
enum_to_int(operation, 'ADD_TOOLS') -> 8;
enum_to_int(operation, 'CHANGE_ROLE') -> 7;
enum_to_int(operation, 'CHANGE_PASS') -> 6;
enum_to_int(operation, 'CHANGE_NAME') -> 5;
enum_to_int(operation, 'UPGRADE') -> 4;
enum_to_int(operation, 'LOGIN_OUT') -> 3;
enum_to_int(operation, 'REGISTER') -> 2;
enum_to_int(operation, 'LOGIN') -> 1;
enum_to_int(operation, 'UN_KNOWN') -> 0.

int_to_enum(operation, 15) -> 'SEND_MSG';
int_to_enum(operation, 14) -> 'INFO';
int_to_enum(operation, 13) -> 'UPGRADE_EQUIPS';
int_to_enum(operation, 12) -> 'DELETE_EQUIPS';
int_to_enum(operation, 11) -> 'ADD_EQUIPS';
int_to_enum(operation, 10) -> 'UPGRADE_TOOLS';
int_to_enum(operation, 9) -> 'DELETE_TOOLS';
int_to_enum(operation, 8) -> 'ADD_TOOLS';
int_to_enum(operation, 7) -> 'CHANGE_ROLE';
int_to_enum(operation, 6) -> 'CHANGE_PASS';
int_to_enum(operation, 5) -> 'CHANGE_NAME';
int_to_enum(operation, 4) -> 'UPGRADE';
int_to_enum(operation, 3) -> 'LOGIN_OUT';
int_to_enum(operation, 2) -> 'REGISTER';
int_to_enum(operation, 1) -> 'LOGIN';
int_to_enum(operation, 0) -> 'UN_KNOWN';
int_to_enum(_, Val) -> Val.

decode_send_msg_request_message(Bytes)
    when is_binary(Bytes) ->
    decode(send_msg_request_message, Bytes).

decode_change_role_request_change_role(Bytes)
    when is_binary(Bytes) ->
    decode(change_role_request_change_role, Bytes).

decode_change_pass_request_change_pass(Bytes)
    when is_binary(Bytes) ->
    decode(change_pass_request_change_pass, Bytes).

decode_change_name_request_change_name(Bytes)
    when is_binary(Bytes) ->
    decode(change_name_request_change_name, Bytes).

decode_te(Bytes) when is_binary(Bytes) ->
    decode(te, Bytes).

decode_empty(Bytes) when is_binary(Bytes) ->
    decode(empty, Bytes).

decode_base_info(Bytes) when is_binary(Bytes) ->
    decode(base_info, Bytes).

decode_send_msg_request(Bytes) when is_binary(Bytes) ->
    decode(send_msg_request, Bytes).

decode_info_request(Bytes) when is_binary(Bytes) ->
    decode(info_request, Bytes).

decode_upgrade_equips_request(Bytes)
    when is_binary(Bytes) ->
    decode(upgrade_equips_request, Bytes).

decode_delete_equips_request(Bytes)
    when is_binary(Bytes) ->
    decode(delete_equips_request, Bytes).

decode_add_equips_request(Bytes)
    when is_binary(Bytes) ->
    decode(add_equips_request, Bytes).

decode_upgrade_tools_request(Bytes)
    when is_binary(Bytes) ->
    decode(upgrade_tools_request, Bytes).

decode_delete_tools_request(Bytes)
    when is_binary(Bytes) ->
    decode(delete_tools_request, Bytes).

decode_add_tools_request(Bytes) when is_binary(Bytes) ->
    decode(add_tools_request, Bytes).

decode_change_role_request(Bytes)
    when is_binary(Bytes) ->
    decode(change_role_request, Bytes).

decode_change_pass_request(Bytes)
    when is_binary(Bytes) ->
    decode(change_pass_request, Bytes).

decode_change_name_request(Bytes)
    when is_binary(Bytes) ->
    decode(change_name_request, Bytes).

decode_upgrade_request(Bytes) when is_binary(Bytes) ->
    decode(upgrade_request, Bytes).

decode_login_out_request(Bytes) when is_binary(Bytes) ->
    decode(login_out_request, Bytes).

decode_register_request(Bytes) when is_binary(Bytes) ->
    decode(register_request, Bytes).

decode_login_request(Bytes) when is_binary(Bytes) ->
    decode(login_request, Bytes).

delimited_decode_login_request(Bytes) ->
    delimited_decode(login_request, Bytes).

delimited_decode_register_request(Bytes) ->
    delimited_decode(register_request, Bytes).

delimited_decode_login_out_request(Bytes) ->
    delimited_decode(login_out_request, Bytes).

delimited_decode_upgrade_request(Bytes) ->
    delimited_decode(upgrade_request, Bytes).

delimited_decode_change_name_request(Bytes) ->
    delimited_decode(change_name_request, Bytes).

delimited_decode_change_pass_request(Bytes) ->
    delimited_decode(change_pass_request, Bytes).

delimited_decode_change_role_request(Bytes) ->
    delimited_decode(change_role_request, Bytes).

delimited_decode_add_tools_request(Bytes) ->
    delimited_decode(add_tools_request, Bytes).

delimited_decode_delete_tools_request(Bytes) ->
    delimited_decode(delete_tools_request, Bytes).

delimited_decode_upgrade_tools_request(Bytes) ->
    delimited_decode(upgrade_tools_request, Bytes).

delimited_decode_add_equips_request(Bytes) ->
    delimited_decode(add_equips_request, Bytes).

delimited_decode_delete_equips_request(Bytes) ->
    delimited_decode(delete_equips_request, Bytes).

delimited_decode_upgrade_equips_request(Bytes) ->
    delimited_decode(upgrade_equips_request, Bytes).

delimited_decode_info_request(Bytes) ->
    delimited_decode(info_request, Bytes).

delimited_decode_send_msg_request(Bytes) ->
    delimited_decode(send_msg_request, Bytes).

delimited_decode_base_info(Bytes) ->
    delimited_decode(base_info, Bytes).

delimited_decode_empty(Bytes) ->
    delimited_decode(empty, Bytes).

delimited_decode_te(Bytes) ->
    delimited_decode(te, Bytes).

delimited_decode_change_name_request_change_name(Bytes) ->
    delimited_decode(change_name_request_change_name,
		     Bytes).

delimited_decode_change_pass_request_change_pass(Bytes) ->
    delimited_decode(change_pass_request_change_pass,
		     Bytes).

delimited_decode_change_role_request_change_role(Bytes) ->
    delimited_decode(change_role_request_change_role,
		     Bytes).

delimited_decode_send_msg_request_message(Bytes) ->
    delimited_decode(send_msg_request_message, Bytes).

delimited_decode(Type, Bytes) when is_binary(Bytes) ->
    delimited_decode(Type, Bytes, []).

delimited_decode(_Type, <<>>, Acc) ->
    {lists:reverse(Acc), <<>>};
delimited_decode(Type, Bytes, Acc) ->
    try protobuffs:decode_varint(Bytes) of
      {Size, Rest} when size(Rest) < Size ->
	  {lists:reverse(Acc), Bytes};
      {Size, Rest} ->
	  <<MessageBytes:Size/binary, Rest2/binary>> = Rest,
	  Message = decode(Type, MessageBytes),
	  delimited_decode(Type, Rest2, [Message | Acc])
    catch
      _What:_Why -> {lists:reverse(Acc), Bytes}
    end.

decode(enummsg_values, 1) -> value1;
decode(login_request, Bytes) when is_binary(Bytes) ->
    Types = [{2, data, base_info, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'LOGIN'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(login_request, Decoded);
decode(register_request, Bytes) when is_binary(Bytes) ->
    Types = [{2, data, base_info, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'REGISTER'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(register_request, Decoded);
decode(login_out_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, base_info, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'LOGIN_OUT'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(login_out_request, Decoded);
decode(upgrade_request, Bytes) when is_binary(Bytes) ->
    Types = [{2, data, empty, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'UPGRADE'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(upgrade_request, Decoded);
decode(change_name_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, change_name_request_change_name,
	      [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'CHANGE_NAME'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_name_request, Decoded);
decode(change_pass_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, change_pass_request_change_pass,
	      [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'CHANGE_PASS'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_pass_request, Decoded);
decode(change_role_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, change_role_request_change_role,
	      [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'CHANGE_ROLE'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_role_request, Decoded);
decode(add_tools_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record, repeated]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'ADD_TOOLS'}, {2, data, []}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(add_tools_request, Decoded);
decode(delete_tools_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'DELETE_TOOLS'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(delete_tools_request, Decoded);
decode(upgrade_tools_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'UPGRADE_TOOLS'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(upgrade_tools_request, Decoded);
decode(add_equips_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record, repeated]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'ADD_EQUIPS'}, {2, data, []}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(add_equips_request, Decoded);
decode(delete_equips_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'DELETE_EQUIPS'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(delete_equips_request, Decoded);
decode(upgrade_equips_request, Bytes)
    when is_binary(Bytes) ->
    Types = [{2, data, te, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'UPGRADE_EQUIPS'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(upgrade_equips_request, Decoded);
decode(info_request, Bytes) when is_binary(Bytes) ->
    Types = [{2, data, empty, [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'INFO'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(info_request, Decoded);
decode(send_msg_request, Bytes) when is_binary(Bytes) ->
    Types = [{2, data, send_msg_request_message,
	      [is_record]},
	     {1, oper, operation, []}],
    Defaults = [{1, oper, 'SEND_MSG'}],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(send_msg_request, Decoded);
decode(base_info, Bytes) when is_binary(Bytes) ->
    Types = [{3, role, string, []}, {2, pass, string, []},
	     {1, name, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(base_info, Decoded);
decode(empty, Bytes) when is_binary(Bytes) ->
    Types = [],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(empty, Decoded);
decode(te, Bytes) when is_binary(Bytes) ->
    Types = [{3, logo, int32, []}, {2, lv, int32, []},
	     {1, name, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(te, Decoded);
decode(change_name_request_change_name, Bytes)
    when is_binary(Bytes) ->
    Types = [{1, new_name, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_name_request_change_name, Decoded);
decode(change_pass_request_change_pass, Bytes)
    when is_binary(Bytes) ->
    Types = [{1, new_pass, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_pass_request_change_pass, Decoded);
decode(change_role_request_change_role, Bytes)
    when is_binary(Bytes) ->
    Types = [{1, new_role, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(change_role_request_change_role, Decoded);
decode(send_msg_request_message, Bytes)
    when is_binary(Bytes) ->
    Types = [{3, msg, string, []}, {2, target, string, []},
	     {1, from, string, []}],
    Defaults = [],
    Decoded = decode(Bytes, Types, Defaults),
    to_record(send_msg_request_message, Decoded).

decode(<<>>, Types, Acc) ->
    reverse_repeated_fields(Acc, Types);
decode(Bytes, Types, Acc) ->
    {ok, FNum} = protobuffs:next_field_num(Bytes),
    case lists:keyfind(FNum, 1, Types) of
      {FNum, Name, Type, Opts} ->
	  {Value1, Rest1} = case lists:member(is_record, Opts) of
			      true ->
				  {{FNum, V}, R} = protobuffs:decode(Bytes,
								     bytes),
				  RecVal = decode(Type, V),
				  {RecVal, R};
			      false ->
				  case lists:member(repeated_packed, Opts) of
				    true ->
					{{FNum, V}, R} =
					    protobuffs:decode_packed(Bytes,
								     Type),
					{V, R};
				    false ->
					{{FNum, V}, R} =
					    protobuffs:decode(Bytes, Type),
					{unpack_value(V, Type), R}
				  end
			    end,
	  case lists:member(repeated, Opts) of
	    true ->
		case lists:keytake(FNum, 1, Acc) of
		  {value, {FNum, Name, List}, Acc1} ->
		      decode(Rest1, Types,
			     [{FNum, Name, [int_to_enum(Type, Value1) | List]}
			      | Acc1]);
		  false ->
		      decode(Rest1, Types,
			     [{FNum, Name, [int_to_enum(Type, Value1)]} | Acc])
		end;
	    false ->
		decode(Rest1, Types,
		       [{FNum, Name, int_to_enum(Type, Value1)} | Acc])
	  end;
      false ->
	  case lists:keyfind('$extensions', 2, Acc) of
	    {_, _, Dict} ->
		{{FNum, _V}, R} = protobuffs:decode(Bytes, bytes),
		Diff = size(Bytes) - size(R),
		<<V:Diff/binary, _/binary>> = Bytes,
		NewDict = dict:store(FNum, V, Dict),
		NewAcc = lists:keyreplace('$extensions', 2, Acc,
					  {false, '$extensions', NewDict}),
		decode(R, Types, NewAcc);
	    _ ->
		{ok, Skipped} = protobuffs:skip_next_field(Bytes),
		decode(Skipped, Types, Acc)
	  end
    end.

reverse_repeated_fields(FieldList, Types) ->
    [begin
       case lists:keyfind(FNum, 1, Types) of
	 {FNum, Name, _Type, Opts} ->
	     case lists:member(repeated, Opts) of
	       true -> {FNum, Name, lists:reverse(Value)};
	       _ -> Field
	     end;
	 _ -> Field
       end
     end
     || {FNum, Name, Value} = Field <- FieldList].

unpack_value(Binary, string) when is_binary(Binary) ->
    binary_to_list(Binary);
unpack_value(Value, _) -> Value.

to_record(login_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       login_request),
						   Record, Name, Val)
			  end,
			  #login_request{}, DecodedTuples),
    Record1;
to_record(register_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       register_request),
						   Record, Name, Val)
			  end,
			  #register_request{}, DecodedTuples),
    Record1;
to_record(login_out_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       login_out_request),
						   Record, Name, Val)
			  end,
			  #login_out_request{}, DecodedTuples),
    Record1;
to_record(upgrade_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       upgrade_request),
						   Record, Name, Val)
			  end,
			  #upgrade_request{}, DecodedTuples),
    Record1;
to_record(change_name_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_name_request),
						   Record, Name, Val)
			  end,
			  #change_name_request{}, DecodedTuples),
    Record1;
to_record(change_pass_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_pass_request),
						   Record, Name, Val)
			  end,
			  #change_pass_request{}, DecodedTuples),
    Record1;
to_record(change_role_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_role_request),
						   Record, Name, Val)
			  end,
			  #change_role_request{}, DecodedTuples),
    Record1;
to_record(add_tools_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       add_tools_request),
						   Record, Name, Val)
			  end,
			  #add_tools_request{}, DecodedTuples),
    Record1;
to_record(delete_tools_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       delete_tools_request),
						   Record, Name, Val)
			  end,
			  #delete_tools_request{}, DecodedTuples),
    Record1;
to_record(upgrade_tools_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       upgrade_tools_request),
						   Record, Name, Val)
			  end,
			  #upgrade_tools_request{}, DecodedTuples),
    Record1;
to_record(add_equips_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       add_equips_request),
						   Record, Name, Val)
			  end,
			  #add_equips_request{}, DecodedTuples),
    Record1;
to_record(delete_equips_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       delete_equips_request),
						   Record, Name, Val)
			  end,
			  #delete_equips_request{}, DecodedTuples),
    Record1;
to_record(upgrade_equips_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       upgrade_equips_request),
						   Record, Name, Val)
			  end,
			  #upgrade_equips_request{}, DecodedTuples),
    Record1;
to_record(info_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       info_request),
						   Record, Name, Val)
			  end,
			  #info_request{}, DecodedTuples),
    Record1;
to_record(send_msg_request, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       send_msg_request),
						   Record, Name, Val)
			  end,
			  #send_msg_request{}, DecodedTuples),
    Record1;
to_record(base_info, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       base_info),
						   Record, Name, Val)
			  end,
			  #base_info{}, DecodedTuples),
    Record1;
to_record(empty, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields, empty),
						   Record, Name, Val)
			  end,
			  #empty{}, DecodedTuples),
    Record1;
to_record(te, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields, te),
						   Record, Name, Val)
			  end,
			  #te{}, DecodedTuples),
    Record1;
to_record(change_name_request_change_name,
	  DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_name_request_change_name),
						   Record, Name, Val)
			  end,
			  #change_name_request_change_name{}, DecodedTuples),
    Record1;
to_record(change_pass_request_change_pass,
	  DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_pass_request_change_pass),
						   Record, Name, Val)
			  end,
			  #change_pass_request_change_pass{}, DecodedTuples),
    Record1;
to_record(change_role_request_change_role,
	  DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       change_role_request_change_role),
						   Record, Name, Val)
			  end,
			  #change_role_request_change_role{}, DecodedTuples),
    Record1;
to_record(send_msg_request_message, DecodedTuples) ->
    Record1 = lists:foldr(fun ({_FNum, Name, Val},
			       Record) ->
				  set_record_field(record_info(fields,
							       send_msg_request_message),
						   Record, Name, Val)
			  end,
			  #send_msg_request_message{}, DecodedTuples),
    Record1.

decode_extensions(Record) -> Record.

decode_extensions(_Types, [], Acc) ->
    dict:from_list(Acc);
decode_extensions(Types, [{FNum, Bytes} | Tail], Acc) ->
    NewAcc = case lists:keyfind(FNum, 1, Types) of
	       {FNum, Name, Type, Opts} ->
		   {Value1, Rest1} = case lists:member(is_record, Opts) of
				       true ->
					   {{FNum, V}, R} =
					       protobuffs:decode(Bytes, bytes),
					   RecVal = decode(Type, V),
					   {RecVal, R};
				       false ->
					   case lists:member(repeated_packed,
							     Opts)
					       of
					     true ->
						 {{FNum, V}, R} =
						     protobuffs:decode_packed(Bytes,
									      Type),
						 {V, R};
					     false ->
						 {{FNum, V}, R} =
						     protobuffs:decode(Bytes,
								       Type),
						 {unpack_value(V, Type), R}
					   end
				     end,
		   case lists:member(repeated, Opts) of
		     true ->
			 case lists:keytake(FNum, 1, Acc) of
			   {value, {FNum, Name, List}, Acc1} ->
			       decode(Rest1, Types,
				      [{FNum, Name,
					lists:reverse([int_to_enum(Type, Value1)
						       | lists:reverse(List)])}
				       | Acc1]);
			   false ->
			       decode(Rest1, Types,
				      [{FNum, Name, [int_to_enum(Type, Value1)]}
				       | Acc])
			 end;
		     false ->
			 [{FNum,
			   {optional, int_to_enum(Type, Value1), Type, Opts}}
			  | Acc]
		   end;
	       false -> [{FNum, Bytes} | Acc]
	     end,
    decode_extensions(Types, Tail, NewAcc).

set_record_field(Fields, Record, '$extensions',
		 Value) ->
    Decodable = [],
    NewValue = decode_extensions(element(1, Record),
				 Decodable, dict:to_list(Value)),
    Index = list_index('$extensions', Fields),
    erlang:setelement(Index + 1, Record, NewValue);
set_record_field(Fields, Record, Field, Value) ->
    Index = list_index(Field, Fields),
    erlang:setelement(Index + 1, Record, Value).

list_index(Target, List) -> list_index(Target, List, 1).

list_index(Target, [Target | _], Index) -> Index;
list_index(Target, [_ | Tail], Index) ->
    list_index(Target, Tail, Index + 1);
list_index(_, [], _) -> -1.

extension_size(_) -> 0.

has_extension(_Record, _FieldName) -> false.

get_extension(_Record, _FieldName) -> undefined.

set_extension(Record, _, _) -> {error, Record}.

