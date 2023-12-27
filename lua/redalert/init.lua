local Job = require('plenary.job')

local M = {}

local function checkGitCommitAgeWarning(cutoffDays)
    local function isGitDirty()
        local output = vim.fn.systemlist('git status --porcelain')
        return #output > 0
    end

    local function isInGitRepo()
        return vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") ~= 1
    end

    if isInGitRepo() and isGitDirty() then
        local gitCommand = 'git log -1 --format=%ct'

        Job:new({
            command = 'bash',
            args = { '-c', gitCommand },
            cwd = vim.fn.expand('%:p:h'),
            on_exit = vim.schedule_wrap(function(_, code, _)
                if code == 0 then
                    local result = vim.fn.systemlist(gitCommand)
                    if result and #result > 0 then
                        local commitTimestamp = tonumber(result[1])
                        local currentTime = os.time()
                        local secondsInADay = 86400 -- 60 seconds * 60 minutes * 24 hours

                        local secondsSinceLastCommit = currentTime - commitTimestamp
                        local daysSinceLastCommit = secondsSinceLastCommit / secondsInADay

                        if daysSinceLastCommit > cutoffDays then
                            vim.api.nvim_echo(
                                { { "⚠️ Warning ⚠️: Last commit is older than " .. cutoffDays .. " days", "WarningMsg" } },
                                true, {})
                        end
                    else
                        print("Error: Unable to get Git commit information")
                    end
                else
                    print("Error: Unable to get Git commit information")
                end
            end),
        }):start()
    end
end

function M.setup(opts)
    opts = opts or {}
    local cutoffDays = opts.cutoff_days or 7

    M.checkGitCommitAgeWarning = function()
        checkGitCommitAgeWarning(cutoffDays)
    end

    local function setupAutocommand()
        vim.cmd(string.format(
            "autocmd BufEnter * lua require('redalert').checkGitCommitAgeWarning()"
        ))
    end

    setupAutocommand()
end

return M
