" Vim syntax file
" Language:	ClearCase config spec
" Maintainer:	Gary Johnson <garyjohn@spk.agilent.com>
" Last Change:	2006-06-07 09:25:58
" URL:		http://www.spocom.com/users/gjohnson/vim/cccs.vim

" Filetype detection
"
" Since the ClearCase config spec is not a standard file type, nor does it
" have a unique suffix, the file type must be set manually or by a special
" rule in the user's personal filetype.vim:
"
"   au! BufRead,BufNewFile /var/tmp/tmp[0-9]*	if $CLEARCASE_CMDLINE =~ "^edcs" | setfiletype cccs | endif
"
" The above rule works for ClearCase on HP-UX; I don't know what the
" equivalent would be for Windows.
"
" UPDATE:
"
" On 2003-05-17, Alexander Sorg <at4also2 at rbg42 dot siemens dot de>
" wrote on the vim list that this works for windows:
"
" au! BufRead,BufNewFile C:/temp/tmp[0-9]*	if $CLEARCASE_CMDLINE =~ "edcs" | setfiletype cccs | endif
"
" On 2006-06-07, Marcin Koziol <m dot koziol at rtsnetworks dot com> wrote
" in e-mail that the following rule was missing, so I added it.
"
" syn match cccsScopeOption	/-dir\>/	contained skipwhite nextgroup=cccsPattern

" TODO:
" -  If a load rule specifies a file or directory name that includes one
"    or more spaces, the entire pathname must be enclosed in single-quotes
"    or double-quotes.
" -  Not all Pattern wildcards may be accounted for.
" -  Not all Version Selector forms are accounted for.
" -  The syntax rule for branch-type-names (cccsBranchType) may not be
"    correct.

" See:
" inittab.vim
" jess.vim
" jproperties.vim
" lilo.vim!

" Quit when a syntax file has already been loaded.
"
if exists("b:current_syntax")
  finish
endif

syn case match

" Comments:
"
syn match cccsComment		/#.*/

" Rule:
"
syn match cccsRule		/^\s*\l\+[^;]*/	contains=cccsStandardRule,cccsBranchRule,cccsTimeRule,cccsIncludeRule,cccsLoadRule
syn match cccsRule		/;\s*\l\+[^;]*/	contains=cccsStandardRule,cccsBranchRule,cccsTimeRule,cccsIncludeRule,cccsLoadRule
"syn match cccsRule		/\l[^;]*/	contains=cccsStandardRule,cccsBranchRule,cccsTimeRule,cccsIncludeRule,cccsLoadRule skipwhite nextgroup=cccsRuleSeparator
"syn match cccsRuleSeparator	/;/		contained skipwhite nextgroup=cccsRule
					" Either of the above pairs of
					" rules seems to work equally
					" well, but neither requires the
					" presence of the ';' between
					" rules, I think because
					" "contains" does not limit the
					" number of times the contained
					" group may appear.

" Standard Rule:
"
" Pattern:
" (cccsPattern is specified before cccsScopeOption since cccsPattern is a
" more general match and either can follow cccsStandardRule.)
"
syn match cccsPattern		/\f\+/		contained skipwhite nextgroup=cccsVersionSelector
syn match cccsPattern		/\*/		contained skipwhite nextgroup=cccsVersionSelector
"
" Scope:
"
syn keyword cccsStandardRule	element		contained skipwhite nextgroup=cccsScopeOption,cccsPattern
syn match cccsScopeOption	/-directory\>/	contained skipwhite nextgroup=cccsPattern
syn match cccsScopeOption	/-dir\>/	contained skipwhite nextgroup=cccsPattern
syn match cccsScopeOption	/-file\>/	contained skipwhite nextgroup=cccsPattern
syn match cccsScopeOption	/-eltype\>/	contained skipwhite nextgroup=cccsElType
syn match cccsElType		/\k\+/		contained skipwhite nextgroup=cccsPattern

syn match cccsVersionSelector	/\f\+/		contained skipwhite nextgroup=cccsClause
syn match cccsClause		/-time\>/	contained skipwhite nextgroup=@cccsDateTime
syn match cccsClause		/-mkbranch\>/	contained skipwhite nextgroup=cccsBranchType
syn match cccsClause		/-nocheckout\>/	contained

" Create Branch Rule:
"
syn keyword cccsBranchRule	end		contained skipwhite nextgroup=cccsBranchRule
syn keyword cccsBranchRule	mkbranch	contained skipwhite nextgroup=cccsBranchType
syn match cccsBranchType	/[-a-zA-Z0-9_.]\+/	contained skipwhite nextgroup=cccsOverride
syn match cccsOverride		/-override\>/	contained

" Time Rule:
"
" With these rules, long-date.time works but today.time doesn't: the .time
" is not highlighted.  Also, "UTC..." is not highlighted.
"
syn keyword cccsTimeRule	end		contained skipwhite nextgroup=cccsTimeRule
syn keyword cccsTimeRule	time		contained skipwhite nextgroup=@cccsDateTime
syn cluster cccsDateTime	contains=cccsDateDotTime,@cccsDate,cccsTime,cccsNow
syn cluster cccsDate		contains=cccsDayOfWeek,cccsLongDateDay

syn keyword cccsDayOfWeek	today yesterday			contained nextgroup=cccsDot
syn keyword cccsDayOfWeek	Sunday Monday Tuesday Wednesday	contained nextgroup=cccsDot
syn keyword cccsDayOfWeek	Thursday Friday Saturday	contained nextgroup=cccsDot
syn keyword cccsDayOfWeek	Sun Mon Tue Wed Thu Fri Sat	contained nextgroup=cccsDot

syn match cccsLongDateDay	/\d\d\=-/			contained nextgroup=cccsMonth
syn keyword cccsMonth		January February March April 	contained nextgroup=cccsYear
syn keyword cccsMonth		May June July August September	contained nextgroup=cccsYear
syn keyword cccsMonth		October November December	contained nextgroup=cccsYear
syn keyword cccsMonth		Jan Feb Mar Apr May Jun		contained nextgroup=cccsYear
syn keyword cccsMonth		Jul Aug Sep Oct Nov Dec		contained nextgroup=cccsYear
syn match cccsYear		/-\(\d\d\)\=\d\d/		contained

syn match cccsDateDotTime	/[-A-Za-z0-9]\+/	contained contains=@cccsDate nextgroup=cccsDot
					" DateDotTime must follow the
					" elements of Date or the .time
					" portion won't match.

syn match cccsDot		/\./		contained nextgroup=cccsTime

syn match cccsTime		/\d\d\=:\d\d\=/	contained nextgroup=cccsSeconds,cccsTimeZone
					" Time must follow DateDotTime or
					" Time won't match, but I don't
					" know why.
syn match cccsSeconds		/:\d\d\=/	contained nextgroup=cccsTimeZone
syn match cccsTimeZone		/UTC/		contained nextgroup=cccsTimeZoneHours
					" 'UTC' can't be a keyword because
					" it can immediately follow time
					" digits without any intervening
					" non-word characters.
syn match cccsTimeZoneHours	/[-+]\=\d\d\=/	contained nextgroup=cccsTimeZoneMinutes
syn match cccsTimeZoneMinutes	/:\d\d\=/	contained

syn keyword cccsNow		now		contained

" File-Inclusion Rule:
"
syn keyword cccsIncludeRule	include		contained skipwhite nextgroup=cccsPname
syn match cccsPname		/\f\+/		contained

" Load Rule:
"
syn keyword cccsLoadRule	load		contained skipwhite nextgroup=cccsPname

" Define the default highlighting.
"
hi def link cccsComment		Comment
hi def link cccsStandardRule	Statement
hi def link cccsScopeOption	Statement
hi def link cccsBranchRule	Statement
hi def link cccsTimeRule	Statement
hi def link cccsIncludeRule	PreProc
hi def link cccsLoadRule	PreProc
"hi def link cccsPattern		String
"hi def link cccsPname		String
hi def link cccsVersionSelector	Type
hi def link cccsClause		PreProc
hi def link cccsOverride	PreProc
hi def link cccsDot		Constant
hi def link cccsNow		Constant
hi def link cccsTime		Constant
hi def link cccsSeconds		Constant
hi def link cccsTimeZone	Constant
hi def link cccsTimeZoneHours	Constant
hi def link cccsTimeZoneMinutes	Constant
hi def link cccsDayOfWeek	Constant
hi def link cccsLongDateDay	Constant
hi def link cccsMonth		Constant
hi def link cccsYear		Constant
hi def link cccsBranchType	Constant
hi def link cccsElType		Constant
hi def link cccsError		Error

let b:current_syntax = "cccs"

" vim: ts=8 sw=2
