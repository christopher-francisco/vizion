"Disable the print key for Macvim
if has("gui_macvim")
    macmenu &File.Print key=<nop>
    set macligatures					" We want pretty symbols, when available
    "set fu                                              " Open in fullscreen
endif
