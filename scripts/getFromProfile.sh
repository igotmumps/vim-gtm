DIR=$1
. /app/${DIR}/gtmenv
OBJTYPE=$2
OBJID=$3
vimgtm="$HOME/wb/vim-gtm"

gtmroutines="${vimgtm}/scripts/o(${vimgtm}/scripts/r) ${gtmroutines}"
export gtmroutines
mumps -r GETFROMPROFILE^PROFILETBX "${OBJTYPE},${OBJID}"
