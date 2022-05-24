# name: nai (modified version)
# Display the following bits on the left:
# * Current directory name
# * Git branch and dirty state (if inside a git repo)

function fish_mode_prompt --description 'Displays the current mode'
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
        case default
            set_color --bold red
            echo 🅽
        case insert
            set_color --bold green
            echo 🅸
        case replace-one
            set_color --bold green
            echo 🆁
        case visual
            set_color --bold brmagenta
            echo 🆅
        end
        set_color normal

        printf " "
    end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set -l yellow (set_color yellow)
  set -l green (set_color green)
  set -l normal (set_color normal)

  set -l cwd (basename (prompt_pwd))

  echo -e -n ''

  echo -n -s ' ' $cwd $normal

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)
    set git_info $green $git_branch
    echo -n -s ' ' $git_info $normal
  end

  echo -n -s " " $normal
end
