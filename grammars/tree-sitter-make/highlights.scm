; `$(VAR)` and `${VAR}` expand a variable; the parens are its delimiters.
"(" @punctuation.definition.variable.begin.bracket.round.make
")" @punctuation.definition.variable.end.bracket.round.make
"{" @punctuation.definition.variable.begin.bracket.curly.make
"}" @punctuation.definition.variable.end.bracket.curly.make

[
 ":"
 "&:"
 "::"
] @punctuation.separator.rule.make
"|" @punctuation.separator.order-only.make
";" @punctuation.separator.recipe.make
"," @punctuation.separator.comma.make
[
 "\""
 "'"
] @punctuation.definition.string.make

[
 "$"
 "$$"
] @punctuation.definition.variable.make

; The single characters that name an automatic variable.
(automatic_variable
 [ "@" "%" "<" "?" "^" "+" "/" "*" "D" "F"] @variable.language.make)

(automatic_variable
 "/" @invalid.illegal.make . ["D" "F"])

[
 "="
 ":="
 "::="
 "?="
 "+="
 "!="
 "@"
 "-"
 "+"
] @keyword.operator.make

[
 (text)
 (string)
 (raw_text)
] @string.quoted.double.make

(variable_assignment (word) @string.quoted.double.make)

[
 "ifeq"
 "ifneq"
 "ifdef"
 "ifndef"
 "else"
 "endif"
 "if"
 "or"  ; boolean functions are conditional in make grammar
 "and"
] @keyword.control.conditional.make

"foreach" @keyword.control.loop.make

[
 "define"
 "endef"
 "vpath"
 "undefine"
 "export"
 "unexport"
 "override"
 "private"
; "load"
] @keyword.control.make

[
 "include"
 "sinclude"
 "-include"
] @keyword.control.import.make

[
 "subst"
 "patsubst"
 "strip"
 "findstring"
 "filter"
 "filter-out"
 "sort"
 "word"
 "words"
 "wordlist"
 "firstword"
 "lastword"
 "dir"
 "notdir"
 "suffix"
 "basename"
 "addsuffix"
 "addprefix"
 "join"
 "wildcard"
 "realpath"
 "abspath"
 "call"
 "eval"
 "file"
 "value"
 "shell"
] @storage.type.function.make

[
 "error"
 "warning"
 "info"
] @keyword.control.exception.make

;; Variable
(variable_assignment
  name: (word) @constant.other.make)

(variable_reference
  (word) @constant.other.make)

(comment) @comment.line.make

((word) @_IGNORE_.clean @string.quoted.double.regex.make
 (#match? @_IGNORE_.clean "[%\*\?]"))

(function_call
  function: "error"
  (arguments (text) @markup.other.danger.make))

(function_call
  function: "warning"
  (arguments (text) @markup.other.warning.make))

(function_call
  function: "info"
  (arguments (text) @markup.other.note.make))

;; Install Command Categories
;; Others special variables
;; Variables Used by Implicit Rules
[
 "VPATH"
 ".RECIPEPREFIX"
] @constant.language.make

(variable_assignment
  name: (word) @_IGNORE_.clean @constant.language.make
        (#match? @_IGNORE_.clean "^(AR|AS|CC|CXX|CPP|FC|M2C|PC|CO|GET|LEX|YACC|LINT|MAKEINFO|TEX|TEXI2DVI|WEAVE|CWEAVE|TANGLE|CTANGLE|RM|ARFLAGS|ASFLAGS|CFLAGS|CXXFLAGS|COFLAGS|CPPFLAGS|FFLAGS|GFLAGS|LDFLAGS|LDLIBS|LFLAGS|YFLAGS|PFLAGS|RFLAGS|LINTFLAGS|PRE_INSTALL|POST_INSTALL|NORMAL_INSTALL|PRE_UNINSTALL|POST_UNINSTALL|NORMAL_UNINSTALL|MAKEFILE_LIST|MAKE_RESTARTS|MAKE_TERMOUT|MAKE_TERMERR|\.DEFAULT_GOAL|\.RECIPEPREFIX|\.EXTRA_PREREQS)$"))

(variable_reference
  (word) @_IGNORE_.clean @constant.language.make
  (#match? @_IGNORE_.clean "^(AR|AS|CC|CXX|CPP|FC|M2C|PC|CO|GET|LEX|YACC|LINT|MAKEINFO|TEX|TEXI2DVI|WEAVE|CWEAVE|TANGLE|CTANGLE|RM|ARFLAGS|ASFLAGS|CFLAGS|CXXFLAGS|COFLAGS|CPPFLAGS|FFLAGS|GFLAGS|LDFLAGS|LDLIBS|LFLAGS|YFLAGS|PFLAGS|RFLAGS|LINTFLAGS|PRE_INSTALL|POST_INSTALL|NORMAL_INSTALL|PRE_UNINSTALL|POST_UNINSTALL|NORMAL_UNINSTALL|MAKEFILE_LIST|MAKE_RESTARTS|MAKE_TERMOUT|MAKE_TERMERR|\.DEFAULT_GOAL|\.RECIPEPREFIX|\.EXTRA_PREREQS\.VARIABLES|\.FEATURES|\.INCLUDE_DIRS|\.LOADED)$"))

;; Standart targets
(targets
  (word) @entity.name.function.preprocessor.make
  (#match? @entity.name.function.preprocessor.make "^(all|install|install-html|install-dvi|install-pdf|install-ps|uninstall|install-strip|clean|distclean|mostlyclean|maintainer-clean|TAGS|info|dvi|html|pdf|ps|dist|check|installcheck|installdirs)$"))

(targets
  (word) @entity.name.function.preprocessor.make
  (#match? @entity.name.function.preprocessor.make "^(all|install|install-html|install-dvi|install-pdf|install-ps|uninstall|install-strip|clean|distclean|mostlyclean|maintainer-clean|TAGS|info|dvi|html|pdf|ps|dist|check|installcheck|installdirs)$"))

;; Builtin targets
(targets
  (word) @entity.name.function.preprocessor.make
  (#match? @entity.name.function.preprocessor.make "^\.(PHONY|SUFFIXES|DEFAULT|PRECIOUS|INTERMEDIATE|SECONDARY|SECONDEXPANSION|DELETE_ON_ERROR|IGNORE|LOW_RESOLUTION_TIME|SILENT|EXPORT_ALL_VARIABLES|NOTPARALLEL|ONESHELL|POSIX)$"))

