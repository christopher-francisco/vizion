if has("gui_macvim")
    "Disable the print key for Macvim
    macmenu &File.Print key=<nop>

    set macligatures					" We want pretty symbols, when available

    set lines=25 columns=90
 
    " set guifont=Fira\ Code\ Retina:h16
    set guifont=FuraCode\ Nerd\ Font:h16
endif
