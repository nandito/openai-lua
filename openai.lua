local openai = {}

local function configure(api_key)
    openai.api_key = api_key
end

local function createCompletion(model, prompt, temperature, max_tokens)
    -- send request to OpenAI API endpoint using the provided parameters
    -- and the configured api key
end

openai.configure = configure
openai.createCompletion = createCompletion

return openai

