" An example for a vimrc file.
"
" Original Author: Bram Moolenaar <Bram@vim.org>
" Current Maintainer: Hank Anderson <hank@statease.com>
" Last change:	2012 Nov 19
"
" To use it, copy it to ~/.vimrc

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if has('win32') || has('win64')
  set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
endif

" ConEmu
if !empty($CONEMUBUILD)
	"echom "Running in conemu"
	set termencoding=utf8
	set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  " termcap codes for cursor shape changes on entry and exit to
  " /from insert mode
  " doesn't work
  " let &t_ti="\e[1 q"
  " let &t_SI="\e[5 q"
  " let &t_EI="\e[1 q"
  " let &t_te="\e[0 q"
endif

" set font for gui sessions
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
  endif

  highlight Normal guibg=#2B1B17

  " hide menu, toolbar, scrollbar
  set guioptions=i

  " this turns them back on
  " set guioptions=imTrL

  " or hide them individually
  "set guioptions -=m
  "set guioptions -=t
  "set guioptions -=r
endif

" pathogen allows you to store plugins in a single directory in .vim/bundle/plugin_name
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching
set cursorline	" highlight the line where the cursor is (this can be very slow)

" bash style tab completion (first tab completes as far as possible, second gives a list)
set wildmode=longest,list

" Toggle line highlighting, in case vim is slow on a particular file. Also
" turns off parenthesis matching, which is also slow. This will stay off until
" you call DoMatchParen.
nnoremap <silent> <Leader>cl :set cursorline! \| NoMatchParen<cr>
nnoremap <silent> <Leader>cc :set cursorcolumn!<cr>

" Improve move speed by turning off cursorline/syntax while moving (doesn't appear to work)
" let g:boostmove=0
" set updatetime=500
" au CursorMoved * call BoostMoveON()
" au CursorMovedI * call BoostMoveON()
" au CursorHold * call BoostMoveOFF()
" au CursorHoldI * call BoostMoveOFF()
function! BoostMoveON()
	if (winline() != line('$')) && (line('.') != 1)
		if (winline() == winheight('.')) || (winline() == 1)
			let g:boostmove=1
			setlocal nocursorline
			setlocal syntax=OFF
		endif
	endif
endfunction

function! BoostMoveOFF()
	if g:boostmove==1
		let g:boostmove=0
		setlocal cursorline
		setlocal syntax=ON
	endif
endfunction

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
	syntax on " turn on syntax highlighting
	set hlsearch " highlights search terms
endif

set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
set background=dark
colorscheme vividchalk
"colorscheme zenburn

" Set up pretty colors. This can be problematic in terminal mode with different terminals, so we use the guicolorscheme plugin.
" It needs to be loaded before running GuiColorScheme (hence the :runtime! command).
" See also: http://vim.wikia.com/wiki/Using_GUI_color_settings_in_a_terminal

" the highlight line shows up wrong in the terminal in this color scheme :(
"runtime! bundle/guicolorscheme/guicolorscheme.vim
"GuiColorScheme codeschool
"set background=dark
"colorscheme vividchalk

"" after much monkeying around, I have found that this colorscheme looks ok in the terminal (but only after loading codeschool, which I need to figure out)
"" found at http://www.vimninjas.com/2012/08/26/10-vim-color-schemes-you-need-to-own/
"" original: https://github.com/garybernhardt/dotfiles/blob/master/.vim/colors/grb256.vim
"set background=dark
"colo grb256
"
"" for some reason the previous commands leave Search as black on black
"hi Search ctermbg=Cyan
"" and xml matching errors
"hi xmlError ctermbg=Red
"" and ruby delimiter
"hi erubyDelimiter ctermfg=Cyan
"" and TODOs
"hi cTodo ctermbg=DarkRed
"" and JS braces
"hi javaScriptBraces ctermfg=White
"" and whatever this is
"hi SpellBad ctermbg=DarkRed

" use solarized colors (overrides the ones above) - turned off because setting these up to look the same across terminals is a huge pain
"	set t_Co=16

"	" to switch to transparent to get the bg from the terminal
"	" let g:solarized_termtrans = 1
"	"let g:solarized_termcolors=16
"	set background=dark " =dark or =light
"
"	colorscheme solarized
"	call togglebg#map("<Leader>bg")
"
if has("gui_running")
  " change to a non-black background in gvim
  " (helps differentiate from git bash)
  highlight Normal guibg=#2B1B17
endif

function! ExtraCPPSyntax()
	" add extra highlight for DEX double typedef
	syn match dxReal "\<Real\>"
	highlight link dxReal Type
endfunction

" turn on custom c++ syntax highlighting when a c++ file is loaded
au Syntax cpp call ExtraCPPSyntax()

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin on
	filetype indent on

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
	au!

	" For all text files set 'textwidth' to 78 characters. (turned off, this is annoying -hpa)
	" autocmd FileType text setlocal textwidth=78

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

	augroup END

	" building R files
	au FileType r set makeprg=rscript\ %
	au BufRead,BufNewFile *.r setfiletype r
	" au FileType r set autoindent
	" au FileType r set cindent

	" dxpx files are xml
	au BufRead,BufNewFile *.dxpx setfiletype xml

else

  set autoindent " always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" reload file -hpa
nnoremap <F3> :edit<cr>
" custom tab settings
:set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" for cpp use tabs width 4
autocmd Filetype cpp setlocal noexpandtab ts=4 sts=4 sw=4
" markdown requires either 4 spaces or a tab for most of its indentation
autocmd Filetype markdown setlocal noexpandtab ts=4 sts=4 sw=4
autocmd Filetype markdown setlocal wrap linebreak nolist
" PEP8 specifies 4 space tabs
autocmd Filetype python setlocal expandtab ts=4 sts=4 sw=4
" close file/tab
nnoremap <C-F4> :q<cr>

" build tags for this project
nnoremap <Leader>ct :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

" check the highlight group under the cursor (for testing/modifying color schemes)
" leader-wc = which color
map <Leader>wc :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" turns off the screen/tmux vim R functionality - to enable install:
" http://www.vim.org/scripts/script.php?script_id=2711
let vimrplugin_screenplugin = 0
" unmap _, which vim-r maps to -> (annoying)
let g:vimrplugin_underscore = 0

set completeopt=menuone,menu,longest ",preview


" set up clang_complete
let g:clang_use_library = 0
let g:clang_library_path = '/usr/lib/llvm'

let g:clang_auto_select = 1
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1
let g:clang_hl_errors = 1
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_complete_patterns = 1
let g:clang_close_preview = 1

" Debugging
" let g:clang_debug = 1

" default clang complete path is wrong, it includes gcc which causes errors
" the default is 'path, .clang_complete, gcc'
let g:clang_auto_user_options = 'path, .clang_complete'

" turn off bells and flashes
set t_vb=

" get rid of windows clang.exe stderr output
" let g:clang_user_options = '2> NUL || exit 0'

nnoremap <Leader>q :call g:ClangUpdateQuickFix()<CR>

" find in files under cursor -hpa
"noremap <F9> :noautocmd execute "vimgrep /" . expand("<cword>") . "/j ./**/*.cpp ./**/*.h" <Bar> cw
" use grep instead to exclude the boost folder
noremap <F9> :noautocmd execute "grep! -r \"" . expand("<cword>") . "\" . --include=\"*.cpp\" --include=\"*.h\" --exclude-dir=boost" <Bar> copen

" for XML tests, open files under cursor in split diff windows in new tab
" just uses a direct index of a split string, so this will break if the
" working in the XML test output changes
set diffopt+=iwhite
function! CompareXMLTests()
	let line = split(getline('.'))
	let output = expand("%:p:h") . "/" . line[4]
	let answer = expand("%:p:h") . "/" . line[8]

	exec "tabe " . output
	exec "vert diffs " . answer
	set nocursorline " this is really slow when looking at xml files
endfunction

" leader-xc = xml compare
noremap <Leader>xc :call CompareXMLTests()<cr>

" open quickfix links in a new tab
:set switchbuf=usetab,useopen,split

" map leader-g to switch to last opened tab
let g:lasttab = 1
nma <Leader>g :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" map control-j and control-k to move forward/back tabs
noremap <C-j> gT
noremap <C-k> gt

" map R (Remove) to delete to the black-hole register, so you don't overwrite previously yanked text
nnoremap R "_d

" map leader-c and leader-uc to comment and un-comment selected c++ lines
" (the second command clears the search so you don't get a ton of highlighting)
vnoremap <Leader>c :s/^/\/\//<cr>:let @/ = ""<cr>
vnoremap <Leader>uc :s/^\/\///<cr>:let @/ = ""<cr>

nnoremap ,, <C-w>T<cr>
" open nerd tree in the same dir as the current file
nnoremap <C-O> :NERDTreeFind<cr>
map <Leader>nt :NERDTreeTabsToggle<cr>

function! MoveBufferToNewTab()
	let n = bufnr('%')
	tabnew
	exec "buffer ".n
	tabprev
	quit
	tabnext
endfunction

" Find file in current directory and edit it.
" e.g.
" :Find whatever.c
" :Find *stream*.c
function! Find(name)
	let l:list=system("find . -name '".a:name."' | grep -v \".svn/\" | perl -ne 'print \"$.\\t$_\"'")
	let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
	if l:num < 1
		echo "'".a:name."' not found"
		return
	endif
	if l:num != 1
		echo l:list
		let l:input=input("Which ? (CR=nothing)\n")
		if strlen(l:input) == 0
			return
		endif
		if strlen(substitute(l:input, "[0-9]", "", "g"))>0
			echo "Not a number"
			return
		endif
		if l:input<1 || l:input>l:num
			echo "Out of range"
			return
		endif
		let l:line = matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
	else
		let l:line = l:list
	endif
	let l:line = substitute(l:line, "^[^\t]*\t./", "", "")
	let l:line = substitute(l:line, "[\r\n]", "", "")
	execute ":tabe ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

set errorformat+=%f:%l

" next/prev errors
nnoremap <F7> :cN<cr>
nnoremap <F8> :cn<cr>

" build
" make program
set makeprg=python\ waf\ install_debug
" make error file
set makeef=make.out

" nmap <F5>:Make<cr>
nnoremap <Leader>m :Make<cr>

let g:session_path="~/Dropbox/linux/dex.session.vim"

function! Mksdx()
	:wa
	:exec "mks! ".g:session_path
endfunction

" leader-s = save session
nnoremap <Leader>s :call Mksdx()<cr>
nnoremap <Leader>l :exec "source ".g:session_path<cr>


" the background make features won't work without +clientserver feature, which requires X11

" use vim-background-make
" nnoremap <F5> :Make<cr>

" use makebg script
" nnoremap <F5> :exec "!makebg" v:serverame "'" . &makeprg . "'" &makeef<CR><CR>
" map <Leader>o :exec "!rm " &makeef "; makebg" v:servername "'" . &makeprg . "'"  &makeef<CR><CR>


nnoremap <Leader>o :call OutOfSourceMake()<cr>

function! OutOfSourceMake()
	"read in make.out
	:cf build/make.out
	"open quickfix window
	:copen
	"jump to the end
	:normal G
endfunction

" make sure buffers go away when closing tabs
set nohidden


" wrapping is messy
set nowrap

" line numbers
" set number

" this sets the backup directory to .backup
set backupdir=./.backup,.,/tmp
" this sets the swap directory
set directory=.,./.backup,/tmp

" call astyle with the current selection
vnoremap <Leader>a :!astyle --style=allman --indent=tab --align-pointer=type --indent-switches --indent-col1-comments --unpad-paren --pad-header --pad-oper --convert-tabs --add-brackets<cr>

" for the ctags function name plugin - NOTE: this will slow down buffer loading/saving a bit
let g:ctags_statusline=1 " display function name on statusline
" :CTAGS " starts ctags script

" arduino file syntax highlighting
autocmd! BufNewFile,BufRead *.ino setlocal ft=arduino
" wscript file syntax highlighting
autocmd! BufNewFile,BufRead wscript setlocal ft=python

" change the colorcolumn color to not be an unpleasant red
highlight ColorColumn ctermbg=gray
" this is how you activate the colorcolumn
" set colorcolumn=80

if empty($CONEMUBUILD)
  highlight ColorColumn ctermbg=magenta "set to whatever you like
  call matchadd('ColorColumn', '\%81v', 100) "set column nr
endif

" fuzzy finder
nnoremap <C-P> :FufCoverageFile<cr>
" swap between source/header
nnoremap <C-H> :A<cr>

imap <Leader>e <Esc>
