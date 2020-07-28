%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2007-2020 VMware, Inc. or its affiliates.  All rights reserved.
%%

%% Sets X-Content-Type-Options header on the response if configured
%% see https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Content-Type-Options

-module(rabbit_mgmt_content_type_opts).

-export([set_headers/1]).

-define(CONTENT_TYPE_OPTIONS_HEADER, <<"X-Content-Type-Options">>).

%%
%% API
%%

set_headers(ReqData) ->
    case application:get_env(rabbitmq_management, content_type_options) of
        undefined   -> ReqData;
        {ok, Value} ->
            cowboy_req:set_resp_header(?CONTENT_TYPE_OPTIONS_HEADER,
                                       rabbit_data_coercion:to_binary(Value),
                                       ReqData)
    end.
