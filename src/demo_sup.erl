%%%-------------------------------------------------------------------
%% @doc demo top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(demo_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

init([]) ->
  RestartStrategy = one_for_one,
  MaxRestarts = 1000,
  MaxSecondsBetweenRestarts = 3600,

  SupFlags = {RestartStrategy, MaxRestarts, MaxSecondsBetweenRestarts},

  Restart = permanent,
  Shutdown = 2000,
  Type = worker,

  Handler =   {demo_init, {demo_init, start_link, []},
                Restart,
                Shutdown,
                Type, [demo_init]},

 {ok, {SupFlags, [Handler]}}.

%%====================================================================
%% Internal functions
%%====================================================================
