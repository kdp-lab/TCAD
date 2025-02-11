; Reinitializing SDE 
(sde:clear)
; set coordinate system up direction 
(sde:set-process-up-direction "+z")

; Selecting default Boolean expression 
(sdegeo:set-default-boolean "ABA")

; Creating rectangular regions  
(sdegeo:create-cuboid (position 0 0 0) (position 100 25 6.25) 
  "Silicon" "substrate") 
  
; Defining contacts 
(define ANODE 
	(sdegeo:create-cuboid (position 101 0 0) (position 100 22 4)
	"Metal" "Anode"))
(sdegeo:set-contact ANODE "anode" "remove")  

(define CATHODE 
	(sdegeo:create-cuboid (position -1 0 0) (position 0 25 6.25) 
	"Metal" "Cathode"))
(sdegeo:set-contact CATHODE "cathode" "remove")  


;Analytical Profiles
  ;Bulk
(sdedr:define-constant-profile "p-_region" "BoronActiveConcentration" 1e12)
  ;Erf profiles
(sdedr:define-erf-profile "n-type_well" "PhosphorusActiveConcentration" "SymPos" 1.0  "Dose" 1.0e14 "Length" 0.6 "Erf"  "Factor" 1.0)
(sdedr:define-erf-profile "p-type_well" "BoronActiveConcentration" "SymPos" 1.0  "Dose" 1.0e14 "Length" 0.6 "Erf"  "Factor" 1.0)
(sdedr:define-erf-profile "p-spray" "PhosphorusActiveConcentration" "SymPos" 0.25  "Dose" 2.0e12 "Length" 0.6 "Erf"  "Factor" 0.01)

;Meshing Strategies
(sdedr:define-refeval-window "bulk_region instance" "Cuboid"
  (position 0 0 0) (position 100 25 6.25))
(sdedr:define-refinement-size "bulk_region"
  15 7.5 3
  15 7.5 3 )
(sdedr:define-refinement-placement "bulk_region instance"
 "bulk_region" "bulk_region instance" )

(sdedr:define-refeval-window "p+_side instance" "Cuboid"
  (position 0 0 0) (position 15 25 6.25))
(sdedr:define-refinement-size "p+_side"
  0.9 7.5 3
  15 7.5 3 )
(sdedr:define-refinement-placement "p+_side instance"
 "p+_side" "p+_side instance" )

(sdedr:define-refeval-window "n+_side instance" "Cuboid"
  (position 95 0 0) (position 100 25 6.25))
(sdedr:define-refinement-size "n+_side"
  0.9 0.6 0.6
  6 3 3 )
(sdedr:define-refinement-placement "n+_side instance"
 "n+_side" "n+_side instance" )

(sdedr:define-refeval-window "n+_half instance" "Cuboid"
  (position 85 0 0) (position 95 25 6.25))
(sdedr:define-refinement-size "n+_half"
  6 3 3
  15 7.5 3 )
(sdedr:define-refinement-placement "n+_half instance"
 "n+_half" "n+_half instance" )

;Placements
(sdedr:define-refeval-window "n-type_well region" "Rectangle"  (position 100 0 0)  (position 100 24 4) )
(sdedr:define-analytical-profile-placement "n-type_well instance" "n-type_well" "n-type_well region" "Both" "NoReplace" "Eval")
(sdedr:define-refeval-window "p-type_well region" "Rectangle"  (position 0 0 0)  (position 0 25 6.25) )
(sdedr:define-analytical-profile-placement "p-type_well instance" "p-type_well" "p-type_well region" "Both" "NoReplace" "Eval")
(sdedr:define-refeval-window "p-spray region" "Rectangle"  (position 100 0 0)  (position 100 25 6.25) )
(sdedr:define-analytical-profile-placement "p-spray instance" "p-spray" "p-spray region" "Both" "NoReplace" "Eval")

; Saving the model
(sde:save-model "n1")

