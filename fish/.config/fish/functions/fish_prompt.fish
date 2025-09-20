# name: Default
# author: Lily Ballard

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

# Helper that returns a random tile as a UTF‑8 string (with added vs15 sequence (zellij breaks this)).
    function __random_mahjong_tile    
      # Define tile unicode block
      set -l MAHJONG_START (math 0x1F000)
      set -l MAHJONG_END   (math 0x1F02B)

      set -l rand_tile_val (random (math $MAHJONG_START) (math $MAHJONG_END))
      set rand_hex (printf "%08X" $rand_tile_val)
      printf ' %b\UFE0E' (string join '' '\U' $rand_hex)
    end
    
    # Grab a fresh tile.
    set -l tile (__random_mahjong_tile)

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix $tile
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end
