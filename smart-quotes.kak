# See LICENSE file for copyright and license details.

provide-module smart-quotes %{

    define-command -params 3 smart-quotes-insert %{
        # move to previous character
        execute-keys "<left>"    
        
        try %{
            # replace straight quote with closing quote
            execute-keys "<a-;><a-k>%arg{1}<ret><del>%arg{3}"
        } catch %{
            # replace opening quote with straight quote
            execute-keys "<a-;><a-k>%arg{2}<ret><del>%arg{1}"
        } catch %{
            # replace closing quote with opening quote
            execute-keys "<a-;><a-k>%arg{3}<ret><del>%arg{2}"
        } catch %{
            # if a whitespace is present, insert an opening quote
            execute-keys "<a-;><a-k>[ ]<ret><right>%arg{2}"
        } catch %{
            # otherwise insert a closing quote
            execute-keys "<right>%arg{3}"
        } 
    }

}

require-module smart-quotes
