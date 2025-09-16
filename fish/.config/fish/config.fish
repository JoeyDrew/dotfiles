if status is-interactive
    # Commands to run in interactive sessions can go here
end

kubectl completion fish | source

alias dv "cd ~/Documents/dev"
alias tf terraform
alias k kubectl
alias awslogin "saml2aws login --skip-prompt --force"
alias awsgovlogin "saml2aws -a gov-default login --skip-prompt --force"
alias gs "git status"
alias rm "gum confirm 'Remove these files?' && rm '$@'"


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


function rds_login
    set -l password (aws rds --profile $argv[1] generate-db-auth-token --hostname $argv[2] --port 5432 --region $argv[5] --username $argv[3])
    env PGPASSWORD=$password psql -h $argv[2] -p 5432 -d $argv[4] -U $argv[3]
end



function al
    aws sso login --profile $argv
end

function lk
  set loc (walk $argv); and cd $loc;
end

## Fish Shell version of Brian's setup_local_tf Bash script, with added functionality
#
# This is intended to be run as an alias within the desired module path. It copies
# both a local provider.tf file and versions.tf, enforcing our version rules. It then
# inserts your desired AWS profile into the provider.tf file.
# It also updates state.tf and remote-state.tf HCL blocks with the backend S3 profile.

function localtf
    if test -z "$argv[1]"
        echo "Please provide the AWS profile for running TF locally, or 'reset' to remove local development configurations. . ."
        return 1
    end

    set profile "$argv[1]"
    set INFRA_TERRAFORM_ROOT (pwd | sed 's/\(infra.terraform\).*/\1/g')

    # Function to add profile variable in config block
    function add_profile_variable
        set file_path $argv[1]
        set variable_name $argv[2]
        set variable_value $argv[3]
        set match $argv[4]

        # Check if the file exists
        if test -f $file_path
            # Add the variable in the config block
            awk -v variable_value="$variable_value" "1;/$match/{ print \"\t\t$variable_name = \x22$variable_value\x22\"}" $file_path > tmp_file && mv tmp_file $file_path
            echo "$variable_name added to $file_path"
        else
            echo "$file_path not found."
        end
    end

    # Function to remove profile variable from config block
    function remove_profile_variable
        set file_path $argv[1]
        set variable_name $argv[2]

        # Check if the file exists
        if test -f $file_path
            # Remove the line containing the variable
            sed -i "" -e "/$variable_name/d" $file_path
            echo "$variable_name removed from $file_path"
        else
            echo "$file_path not found."
        end
    end

    if test "$argv[1]" = "reset"
        # Undo changes
        rm  "$PWD/provider.tf"
        rm  "$PWD/versions.tf"
        remove_profile_variable "$PWD/state.tf" "profile"
        remove_profile_variable "$PWD/remote-state.tf" "profile"
    else
        # Add versions file
        cp "$INFRA_TERRAFORM_ROOT/terraform/aws/configs/versions.tf" $PWD/versions.tf

        # Add profile variable in provider.tf
        cp "$INFRA_TERRAFORM_ROOT/terraform/aws/configs/local-provider.tf" $PWD/provider.tf
        sed -i "" "s/#{profile}/$profile/g" provider.tf

        # Add profile variable in state.tf
        add_profile_variable "$PWD/state.tf" "profile" "platform-prod" "backend"

        # Add profile variable in remote-state.tf
        add_profile_variable "$PWD/remote-state.tf" "profile" "platform-prod" "config"
    end

    echo "Configuration files updated successfully."
end

eval "$(/opt/homebrew/bin/brew shellenv)"

starship init fish | source
