local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("cjson")

local allowed_models = dofile("models.lua")
local ORIGIN = 'https://api.openai.com'
local API_VERSION = 'v1'
local OPEN_AI_URL = ORIGIN .. "/" ..API_VERSION
local COMPLETION_URL = OPEN_AI_URL .. "/completions"

local openai = {}

--- Configures the OpenAI SDK with an API key.
-- @param api_key The OpenAI API key to use for authenticating requests.
local function configure(api_key)
    openai.api_key = api_key
end

--- Sends a request to the OpenAI API to generate a completion for a given prompt.
-- @param model The name of the OpenAI model to use for generating the completion.
-- @param prompt The prompt to generate a completion for.
-- @param temperature The temperature parameter for the model.
-- @param max_tokens The maximum number of tokens to generate in the completion.
-- @return The response from the OpenAI API as a string.
-- @raise Error if the model parameter is not one of the allowed models.
local function createCompletion(model, prompt, temperature, max_tokens)
    local found = false
    for _, value in pairs(allowed_models) do
        if value == model then
            found = true
            break
        end
    end

    if not found then
        error("Invalid model: " .. model)
    end

    local body = {
        model = model,
        prompt = prompt,
        temperature = temperature,
        max_tokens = max_tokens
    }

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. openai.api_key
    }

    local respbody = {}

    http.request{
        url = COMPLETION_URL,
        method= "POST",
        headers = headers,
        source = ltn12.source.string(json.encode(body)),
        sink = ltn12.sink.table(respbody),
    }
    respbody = table.concat(respbody)

    return respbody
end

openai.configure = configure
openai.createCompletion = createCompletion

return openai

