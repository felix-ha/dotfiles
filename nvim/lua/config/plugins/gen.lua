return {
-- Custom Parameters (with defaults)
{
    "David-Kunz/gen.nvim",
    opts = {
        model = "codegemma:7b-instruct-v1.1-fp16", -- The default model to use.
        quit_map = "q", -- set keymap to close the response window
        retry_map = "<c-r>", -- set keymap to re-send the current prompt
        accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        display_mode = "split", -- The display mode. Can be "float" or "split" or "horizontal-split".
        show_prompt = "full", -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        file = false, -- Write the payload to a temporary file to keep the command short.
        hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = {model = options.model, stream = true}
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        result_filetype = "markdown", -- Configure filetype of the result buffer
        debug = false -- Prints errors and the command which is run.
    },
        config = function(_, opts)
        -- Apply the options from the lazy.nvim spec
        require("gen").setup(opts)

        require('gen').prompts['Write_Tests'] = {
            prompt = "Given this code:\n$text\nWrite unittests. Do not use the unittest module, just plain asserts. Use the triple A pattern and write comments for each of the three steps: # arrange # act # assert. Only output the code, no comments!",
        }

        require('gen').prompts['Ask_Yanked'] = {
            prompt = "Given this context:\n$register\nAnswer this prompt:\n$input",
        }

        require('gen').prompts['Ask_Harpoon'] = {
            prompt = "Given python code answer the question. The context will be provied as a some complete python files from a project. the files are separeted by --- file_name.py ---. Here are the files: \n$register\nAnswer this prompt: $input",
        }

    end
 }
}

