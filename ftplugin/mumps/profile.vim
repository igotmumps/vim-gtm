" This file provides a list of tools that can be used when
" working with the Profile Anywhere core banking system.
"
function! GetFromProfile(dir,ObjType,ObjId)
	let l:dir = a:dir
	let l:ObjType = a:ObjType
	if l:ObjType == "Procedure"
		let l:ext='.PROC'
	elseif l:ObjType == "Routine"
		let l:ext=".m"
	elseif l:ObjType == "Batch"
		let l:ext = ".BATCH"
	else
		let l:ext=".txt"
	endif
	let l:ObjId = a:ObjId
	let l:cmd = $HOME . '/wb/vim-gtm/scripts/getFromProfile.sh ' . l:dir . ' ' . l:ObjType . ' ' . l:ObjId
	botright new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
	execute 'read!'.l:cmd
endfunction

"command! -nargs=1 GetFromProfile call GetFromProfile(<q-args>)
