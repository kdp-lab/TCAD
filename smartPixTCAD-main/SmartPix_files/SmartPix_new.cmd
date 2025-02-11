Title "Untitled"

Controls {
}

IOControls {
	outputFile = "/home/aknicholas/DB/SmartPix_new"
	EnableSections
}

Definitions {
	AnalyticalProfile "n-type_well profile" {
		Species = "PhosphorusActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 1)
	}
	AnalyticalProfile "p-spray profile" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 0.25, Dose= 2e+12, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
	AnalyticalProfile "p-type_well profile" {
		Species = "BoronActiveConcentration"
		Function = Erf(SymPos = 1, Dose= 1e+14, Length = 0.6)
		LateralFunction = Erf(Factor = 0.01)
	}
}

