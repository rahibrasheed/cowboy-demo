%%%-------------------------------------------------------------------
%% @doc demo public API
%% @end
%%%-------------------------------------------------------------------

-module(demo_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
                      {'_', [{"/",cowboy_static,{file,"www/index.html"}},
                             {"/demo/[...]", demo_api, []}]}
                      ]),
    cowboy:start_http(monitor_http_listener, 100, [{port, 8081}],
                            [{env, [{dispatch, Dispatch}]}]),
    demo_sup:start_link().

%%--------------------------------------------------------------------

stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
