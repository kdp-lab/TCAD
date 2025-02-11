
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "cathode" 4 (color:rgb 0 1 0 )"##" )
(sdegeo:define-contact-set "anode" 4 (color:rgb 1 0 0 )"##" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "n-type_well instance" "Polygon" (list (position 100 0 0) (position 100 24 0) (position 100 24 4) (position 100 0 4)))
(sdedr:define-refeval-window "p-type_well instance" "Polygon" (list (position 0 0 0) (position 0 25 0) (position 0 25 6.25) (position 0 0 6.25)))
(sdedr:define-refeval-window "Refwin_1" "Polygon" (list (position 100 0 0) (position 100 24 0) (position 100 24 4) (position 100 0 4)))
(sdedr:define-refeval-window "Refwin_2" "Polygon" (list (position 0 0 0) (position 0 25 0) (position 0 25 6.25) (position 0 0 6.25)))
(sdedr:define-refeval-window "p-spray instance" "Polygon" (list (position 100 0 0) (position 100 25 0) (position 100 25 6.25) (position 100 0 6.25)))
(sdedr:define-refeval-window "RefEvalWin_2" "Cuboid" (position 0 0 0) (position 100 25 6.25))
(sdedr:define-refeval-window "bulk_region instance" "Cuboid" (position 0 0 0) (position 100 25 6.25))
(sdedr:define-refeval-window "p+_side instance" "Cuboid" (position 0 0 0) (position 15 25 6.25))
(sdedr:define-refeval-window "n+_side instance" "Cuboid" (position 95 0 0) (position 100 25 6.25))
(sdedr:define-refeval-window "n+_half instance" "Cuboid" (position 85 0 0) (position 95 25 6.25))

;; Restore GUI session parameters:
(sde:set-window-position 0 1)
(sde:set-window-size 1470 811)
(sde:set-window-style "Windows")
(sde:set-background-color 0 127 178 204 204 204)
(sde:scmwin-set-prefs "Liberation Sans" "Normal" 8 124 )
