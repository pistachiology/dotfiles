
local execute = vim.api.nvim_command
local fn = vim.fn

local pack_path = fn.stdpath("data") .. "/site/pack"
local fmt = string.format

-- Copied from https://github.com/Olical/dotfiles/blob/master/stowed/.config/nvim/init.lua
function ensure (user, repo)
  -- Ensures a given github.com/USER/REPO is cloned in the pack/packer/start directory.
  local install_path = fmt("%s/packer/start/%s", pack_path, repo, repo)
  if fn.empty(fn.glob(install_path)) > 0 then
    execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
    execute(fmt("packadd %s", repo))
  end
end

ensure("wbthomason", "packer.nvim")
ensure("Olical", "aniseed")


vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g["aniseed#env"] = true
-- vim.g["aniseed#env"] = { compile = false }

require('core')
require('keys').setup()
require('load-packers')
