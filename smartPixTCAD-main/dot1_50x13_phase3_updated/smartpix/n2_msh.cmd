Title "Untitled"

Controls {
}

IOControls {
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
		LateralFunction = Erf(Factor = 1)
	}
	AnalyticalProfile "p-spray" {
		Species = "PhosphorusActiveConcentration"
		Function = Erf(SymPos = 0.25, Dose= 2e+12, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	Refinement "bulk_region" {
		MaxElementSize = ( 15 7.5 3 )
		MinElementSize = ( 15 7.5 3 )
	}
	Refinement "p+_side" {
		MaxElementSize = ( 0.9 7.5 3 )
		MinElementSize = ( 15 7.5 3 )
	}
	Refinement "n+_side" {
		MaxElementSize = ( 0.9 0.6 0.6 )
		MinElementSize = ( 6 3 3 )
	}
	Refinement "n+_half" {
		MaxElementSize = ( 6 3 3 )
		MinElementSize = ( 15 7.5 3 )
	}
}

Placements {
	AnalyticalProfile "n-type_well instance" {
		Reference = "n-type_well"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 24 0) (100 24 4) (100 0 4)]
		}
	}
	AnalyticalProfile "p-type_well instance" {
		Reference = "p-type_well"
		ReferenceElement {
			Element = Polygon [ (0 0 0) (0 25 0) (0 25 6.25) (0 0 6.25)]
		}
	}
	AnalyticalProfile "p-spray instance" {
		Reference = "p-spray"
		ReferenceElement {
			Element = Polygon [ (100 0 0) (100 25 0) (100 25 6.25) (100 0 6.25)]
		}
	}
	Refinement "bulk_region instance" {
		Reference = "bulk_region"
		RefineWindow = Cuboid [(0 0 0) (100 25 6.25)]
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

