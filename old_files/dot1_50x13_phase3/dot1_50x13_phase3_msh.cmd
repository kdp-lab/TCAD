Title "Dot 1 pspray (Vdep = 7.7V@100um)"

Controls {
	meshengine = "mesh"
}

IOControls {
	outputFile = "/home/karri/TCAD/DB/dot1_50x13_phase3/dot1_50x13_phase3"
	EnableSections
}

Definitions {
	Constant "p-_region" {
		Species = "BoronActiveConcentration"
		Value = 1e+12
	}
	AnalyticalProfile "n-type_well" {
		Species = "PhosphorusActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 1)
	}
	AnalyticalProfile "p-type_well" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	AnalyticalProfile "p-spray" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 0.25, Dose= 2e+12, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	Constant "p-_region" {
		Species = "BoronActiveConcentration"
		Value = 1e+12
	}
	AnalyticalProfile "n-type_well" {
		Species = "PhosphorusActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 1)
	}
	AnalyticalProfile "p-type_well" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	AnalyticalProfile "p-spray" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 0.25, Dose= 2e+12, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	Refinement "bulk_region" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 5 2.5 1 )
	}
	Refinement "p+_side" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 0.3 2.5 1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "n+_side" {
		MaxElementSize = ( 2 1 1 )
		MinElementSize = ( 0.3 0.2 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "n+_half" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 2 1 1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "bulk_region" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 5 2.5 1 )
	}
	Refinement "p+_side" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 0.3 2.5 1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "n+_side" {
		MaxElementSize = ( 2 1 1 )
		MinElementSize = ( 0.3 0.2 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
	Refinement "n+_half" {
		MaxElementSize = ( 5 2.5 1 )
		MinElementSize = ( 2 1 1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
}

Placements {
	Constant "p-_region instance" {
		Reference = "p-_region"
		EvaluateWindow {
			Element = Cuboid [(0 0 0) (100 25 6.25)]
		}
	}
	AnalyticalProfile "p-spray instance" {
		Reference = "p-spray"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 25 0) (100 25 6.25) (100 0 6.25)]
		}
	}
	AnalyticalProfile "n-type_well instance" {
		Reference = "n-type_well"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 22 0) (100 22 4) (100 0 4)]
		}
	}
	AnalyticalProfile "p-type_well instance" {
		Reference = "p-type_well"
		ReferenceElement {
			Element = Polygon [ (0 0 0) (0 25 0) (0 25 6.25) (0 0 6.25)]
		}
	}
	Constant "p-_region instance" {
		Reference = "p-_region"
		EvaluateWindow {
			Element = Cuboid [(0 0 0) (100 25 6.25)]
		}
	}
	AnalyticalProfile "p-spray instance" {
		Reference = "p-spray"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 25 0) (100 25 6.25) (100 0 6.25)]
		}
	}
	AnalyticalProfile "n-type_well instance" {
		Reference = "n-type_well"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 22 0) (100 22 4) (100 0 4)]
		}
	}
	AnalyticalProfile "p-type_well instance" {
		Reference = "p-type_well"
		ReferenceElement {
			Element = Polygon [ (0 0 0) (0 25 0) (0 25 6.25) (0 0 6.25)]
		}
	}
	Refinement "p+_side instance" {
		Reference = "p+_side"
		RefineWindow = Cuboid [(0 0 0) (15 25 6.25)]
	}
	Refinement "n+_side instance" {
		Reference = "n+_side"
		RefineWindow = Cuboid [(95 0 0) (100 25 6.25)]
	}
	Refinement "n+_half instance" {
		Reference = "n+_half"
		RefineWindow = Cuboid [(85 0 0) (95 25 6.25)]
	}
	Refinement "p+_side instance" {
		Reference = "p+_side"
		RefineWindow = Cuboid [(0 0 0) (15 25 6.25)]
	}
	Refinement "n+_side instance" {
		Reference = "n+_side"
		RefineWindow = Cuboid [(95 0 0) (100 25 6.25)]
	}
	Refinement "n+_half instance" {
		Reference = "n+_half"
		RefineWindow = Cuboid [(85 0 0) (95 25 6.25)]
	}
}

