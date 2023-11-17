if status is-interactive
    # Commands to run in interactive sessions can go here
end

kubectl completion fish | source

alias k kubectl
alias awslogin "saml2aws login --skip-prompt --force"
alias awsgovlogin "saml2aws -a gov-default login --skip-prompt --force"
alias gs "git status"

function gb
    set -l branch_name $argv[1]
    git checkout main
    git pull origin main
    git checkout -b $branch_name
end

function gc 
    set -l commit_message $argv[1]
    git pull origin (git rev-parse --abbrev-ref HEAD)
    git add .
    git commit -m $commit_message
    git push origin (git rev-parse --abbrev-ref HEAD)
end

function gp
    set -l pr_title $argv[1]
    set -l pr_template_path "/path/to/your/pr-template.md"
    set -l current_branch (git rev-parse --abbrev-ref HEAD)
    hub pull-request -F $pr_template_path -b main -h $current_branch -m $pr_title
end


function al
    aws sso login --profile $argv
end

function lk
  set loc (walk $argv); and cd $loc;
end

eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source
