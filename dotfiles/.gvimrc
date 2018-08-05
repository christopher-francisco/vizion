if has("gui_macvim")
    "Disable the print key for Macvim
    macmenu &File.Print key=<nop>

    set macligatures					" We want pretty symbols, when available

    set lines=25 columns=90
endif
