; A multi-target rule has one entry per literal target, never its prerequisites.
(rule (targets (word) @name @definition.target))
(variable_assignment name: (word) @name) @definition.variable
(define_directive name: (word) @name) @definition.function
