
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "IMP1_electrode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "BOT_electrode" 4 (color:rgb 0 1 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "top_imp_line" "Line" (position 0 0 0) (position 55 0 0))
(sdedr:define-refeval-window "bot_imp_line" "Line" (position 0 55 0) (position 55 55 0))
(sdedr:define-refeval-window "everything_refinement" "Rectangle" (position -1 -1 0) (position 56 56 0))
(sdedr:define-refeval-window "implant_refinement" "Rectangle" (position 0 0 0) (position 55 3 0))
(sdedr:define-refeval-window "bot_refinement" "Rectangle" (position 0 55 0) (position 55 52 0))
(sdedr:define-refeval-window "REF1_MIP" "Rectangle" (position 23.5 55 0) (position 31.5 0 0))
(sdedr:define-refeval-window "REF2_MIP" "Rectangle" (position 21.5 55 0) (position 33.5 0 0))
(sdedr:define-refeval-window "REF3_MIP" "Rectangle" (position 19.5 55 0) (position 35.5 0 0))

;; Restore GUI session parameters:
(sde:set-window-position 0 457)
(sde:set-window-size 840 800)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "DejaVu Sans Mono" "Normal" 10 100 )
