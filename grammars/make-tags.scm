; A multi-target rule has one entry per literal target, never its prerequisites.
(rule (targets (word) @name
  (#set! symbol.tag "target")))
(variable_assignment name: (word) @name) @definition.variable
(define_directive name: (word) @name) @definition.function
