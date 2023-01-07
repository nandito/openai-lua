local http = require("socket.http")
local json = require("cjson")

local ALLOWED_MODELS = dofile("models.lua")

local openai = {}

local ORIGIN = 'https://api.openai.com'
local API_VERSION = 'v1'
local OPEN_AI_URL = ORIGIN .. "/" ..API_VERSION
local COMPLETION_URL = OPEN_AI_URL .. "/completions"

local function configure(api_key)
    openai.api_key = api_key
end

local function createCompletion(model, prompt, temperature, max_tokens)
    local found = false
    for _, value in pairs(ALLOWED_MODELS) do
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

    local options = {
        method = "POST",
        body = json.encode(body),
        headers = headers
    }

    local response = http.request(COMPLETION_URL, json.encode(options))
    return response
end

openai.configure = configure
openai.createCompletion = createCompletion

return openai

