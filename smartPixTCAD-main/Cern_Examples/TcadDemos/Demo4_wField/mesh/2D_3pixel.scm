
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "BOT_electrode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "IMP1_electrode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "IMP2_electrode" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "IMP3_electrode" 4 (color:rgb 1 0 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "IMP1_line" "Line" (position 8 0 0) (position 47 0 0))
(sdedr:define-refeval-window "IMP2_line" "Line" (position 63 0 0) (position 102 0 0))
(sdedr:define-refeval-window "IMP3_line" "Line" (position 118 0 0) (position 157 0 0))
(sdedr:define-refeval-window "BOT_IMP_line" "Line" (position 0 200 0) (position 165 200 0))
(sdedr:define-refeval-window "PSTOP1_line" "Line" (position 0 0 0) (position 3 0 0))
(sdedr:define-refeval-window "PSTOP2_line" "Line" (position 52 0 0) (position 58 0 0))
(sdedr:define-refeval-window "PSTOP3_line" "Line" (position 107 0 0) (position 113 0 0))
(sdedr:define-refeval-window "PSTOP4_line" "Line" (position 162 0 0) (position 165 0 0))
(sdedr:define-refeval-window "REF_ALL" "Rectangle" (position -10 210 0) (position 175 -10 0))
(sdedr:define-refeval-window "REF_IMP" "Rectangle" (position 0 -1.5 0) (position 165 2.5 0))
(sdedr:define-refeval-window "REF1_TOP" "Rectangle" (position 0 -1.5 0) (position 165 2.5 0))
(sdedr:define-refeval-window "REF2_TOP" "Rectangle" (position 0 0 0) (position 165 5 0))
(sdedr:define-refeval-window "REF3_TOP" "Rectangle" (position 0 0 0) (position 165 10 0))
(sdedr:define-refeval-window "REF_BOT_IMP" "Rectangle" (position 0 200 0) (position 165 198.5 0))
(sdedr:define-refeval-window "REF1_BOT" "Rectangle" (position 0 200 0) (position 165 197.5 0))
(sdedr:define-refeval-window "REF2_BOT" "Rectangle" (position 0 201.1 0) (position 165 195 0))
(sdedr:define-refeval-window "REF3_BOT" "Rectangle" (position 0 201.1 0) (position 165 190 0))

;; Restore GUI session parameters:
(sde:set-window-position 0 457)
(sde:set-window-size 840 800)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "DejaVu Sans Mono" "Normal" 10 100 )
