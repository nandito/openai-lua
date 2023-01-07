# Lua OpenAI SDK

A simple package for interacting with the OpenAI API in Lua.

## Installation

To install the OpenAI SDK, simply copy the `openai.lua` file to your project
and require it in your script:

```lua
local openai = require("openai")
```

## Configuration

Before using the OpenAI SDK, you will need to configure it with your OpenAI API
key:

```lua
openai.configure(api_key)
```

## Usage

The OpenAI SDK provides a single function, `createCompletion`, which sends a
request to the OpenAI API to generate a completion for a given prompt:

```lua
local response = openai.createCompletion(model, prompt, temperature, max_tokens)
```

The `createCompletion` function accepts the following parameters:

- `model`: the name of the OpenAI model to use for generating the completion.
- `prompt`: the prompt to generate a completion for.
- `temperature`: the temperature parameter for the model.
- `max_tokens`: the maximum number of tokens to generate in the completion.

See more in the official [api docs](https://beta.openai.com/docs/api-reference/completions/create).

The `createCompletion` function returns the response from the OpenAI API as a
string.

## Example

Here is an example of how to use the OpenAI SDK to generate a completion for a
prompt using the "davinci" model:

```lua
local openai = require("openai")

openai.configure(api_key)

local model = "davinci"
local prompt = "The quick brown fox jumps over the lazy dog"
local temperature = 0.5
local max_tokens = 10

local response = openai.createCompletion(model, prompt, temperature, max_tokens)
print(response)
```

This will print the generated completion to the console.

