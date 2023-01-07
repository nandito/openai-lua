local http = require("http")
local json = require("json")

local openai = {}
local ORIGIN = 'https://api.openai.com'
local API_VERSION = 'v1'
local OPEN_AI_URL = ORIGIN .. "/" ..API_VERSION
local COMPLETION_URL = OPEN_AI_URL .. "/completions"
local ALLOWED_MODELS = {
    "ada",
    "ada-code-search-code",
    "ada-code-search-text",
    "ada-search-document",
    "ada-search-query",
    "ada-similarity",
    "ada:2020-05-03",
    "audio-transcribe-001",
    "babbage",
    "babbage-code-search-code",
    "babbage-code-search-text",
    "babbage-search-document",
    "babbage-search-query",
    "babbage-similarity",
    "babbage:2020-05-03",
    "code-cushman-001",
    "code-davinci-002",
    "code-davinci-edit-001",
    "code-search-ada-code-001",
    "code-search-ada-text-001",
    "code-search-babbage-code-001",
    "code-search-babbage-text-001",
    "curie",
    "curie-instruct-beta",
    "curie-search-document",
    "curie-search-query",
    "curie-similarity",
    "curie:2020-05-03",
    "cushman:2020-05-03",
    "davinci",
    "davinci-if:3.0.0",
    "davinci-instruct-beta",
    "davinci-instruct-beta:2.0.0",
    "davinci-search-document",
    "davinci-search-query",
    "davinci-similarity",
    "davinci:2020-05-03",
    "if-curie-v2",
    "if-davinci-v2",
    "if-davinci:3.0.0",
    "text-ada-001",
    "text-ada:001",
    "text-babbage-001",
    "text-babbage:001",
    "text-curie-001",
    "text-curie:001",
    "text-davinci-001",
    "text-davinci-002",
    "text-davinci-003",
    "text-davinci-edit-001",
    "text-davinci-insert-001",
    "text-davinci-insert-002",
    "text-davinci:001",
    "text-embedding-ada-002",
    "text-search-ada-doc-001",
    "text-search-ada-query-001",
    "text-search-babbage-doc-001",
    "text-search-babbage-query-001",
    "text-search-curie-doc-001",
    "text-search-curie-query-001",
    "text-search-davinci-doc-001",
    "text-search-davinci-query-001",
    "text-similarity-ada-001",
    "text-similarity-babbage-001",
    "text-similarity-curie-001",
    "text-similarity-davinci-001",
 }

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

    local response = http.request(COMPLETION_URL, options)
    return response
end

openai.configure = configure
openai.createCompletion = createCompletion

return openai

