# *: current window flag removed
# -: last window flag replaced by (⦁)
# #: window activity flag replaced by ()
# ~: window silence flag replaced by ()
# !: window bell flag replaced by ()
# Z: window zoomed flag replaced by ()

flag=$1

# Current window
flag=${flag//\*/} # Remove it

# Zoom
flag=${flag//Z/" "}

# Last window
flag=${flag//-/" ⦁"}

# Window activity
flag=${flag//-/" "}

# Window silence
flag=${flag//-/" "}

# Window bell
flag=${flag//-/" "}

# NOTE: must wrap in double quotes (") or the spaces will be gone for some reason
echo "$flag"
