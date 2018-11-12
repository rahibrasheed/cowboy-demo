-module(spam_api).
-export([handle/2,init/3,terminate/3]).
-record(state,{}).

init(_Type, Req, _Opts) ->
  {ok, Req, #state{}}.

-spec handle(any(), any()) -> any().
handle(Req, State) ->
  {Method, Req1} = cowboy_req:method(Req),
  {Path, Req2} = cowboy_req:path_info(Req1),
  handle_req(Method, Path, Req),
  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
  ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create, 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

handle_req(<<"GET">>, [<<"create">>], Req) ->
  {ok, Body, _Req2} = cowboy_req:body(Req),
  {Data} = jiffy:decode(Body),
% do_read(Data),
  cowboy_req:reply(200,[{<<"content-type">>, <<"text/plain">>}], "Success", Req);

handle_req(<<"PUT">>, [<<"read">>], Req) ->
  {ok, Body, _Req2} = cowboy_req:body(Req),
  {Data} = jiffy:decode(Body),
% do_write(data),
  cowboy_req:reply(200,[{<<"content-type">>, <<"text/plain">>}], "Success" Req);

handle_req(<<"POST">>, [<<"update">>], Req) ->
  {ok, Body, _Req2} = cowboy_req:body(Req),
  {Data} = jiffy:decode(Body),
% do_update(Data),
  cowboy_req:reply(200,[{<<"content-type">>, <<"text/plain">>}], "Success", Req);

handle_req(<<"DELETE">>, [<<"update">>], Req) ->
  {ok, Body, _Req2} = cowboy_req:body(Req),
  {Data} = jiffy:decode(Body),
% do_delete(Data).
  cowboy_req:reply(200,[{<<"content-type">>, <<"text/plain">>}], "Success", Req);


