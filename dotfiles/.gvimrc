"Disable the print key for Macvim
if has("gui_macvim")
    colorscheme one                                    " We want atom on MacVim
    macmenu &File.Print key=<nop>
    set macligatures					" We want pretty symbols, when available
    set lines=25 columns=90
endif
