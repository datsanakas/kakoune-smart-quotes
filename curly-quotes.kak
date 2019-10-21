hook global InsertKey "'" %{
    # The user just typed a quote. What character comes before it? Store
    # that in register ‘q.’
    execute-keys -draft '<esc>hh"qy'

    # Now we attempt to replace that quote with the correct curly one.
    execute-keys %sh{
        char_prior="$kak_reg_q"

        # For the special case where the cursor’s at 0:0 (really 0:1
        # after typing the quote), let’s pretend like there’s
        # whitespace before it.
        if [ $kak_cursor_byte_offset -le 1 ]; then
            char_prior=' '
        fi

        # Is the prior character whitespace?
        case "$char_prior" in
        [[:space:]])
            # If so, we replace it with an opening curly.
            printf '<backspace>‘'
            ;;
        *)
            # Otherwise, we replace it with a closing curly.
            printf '<backspace>’'
            ;;
        esac
    }
}
