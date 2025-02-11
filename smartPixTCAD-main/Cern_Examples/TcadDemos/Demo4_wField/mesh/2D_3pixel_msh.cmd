Title ""

Controls {
}

Definitions {
	Constant "BULK_profile" {
		Species = "BoronActiveConcentration"
		Value = 4.7e+12
	}
	AnalyticalProfile "IMP_profile" {
		Species = "PhosphorusActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+12, Depth = 2.4)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "BOT_IMP_profile" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+12, Depth = 2)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "PSTOP_profile" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+15, ValueAtDepth = 1e+11, Depth = 1.5)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "REFI_ALL_def" {
		MaxElementSize = ( 4 4 4 )
		MinElementSize = ( 0.1 0.1 0.1 )
	}
	Refinement "REFI1_def" {
		MaxElementSize = ( 0.6 0.6 0.6 )
		MinElementSize = ( 0.2 0.2 0.2 )
	}
	Refinement "REFI2_def" {
		MaxElementSize = ( 0.8 0.8 0.8 )
		MinElementSize = ( 0.3 0.3 0.3 )
	}
	Refinement "REFI3_def" {
		MaxElementSize = ( 2 2 2 )
		MinElementSize = ( 1 1 1 )
	}
	Refinement "REFI4_def" {
		MaxElementSize = ( 3 3 3 )
		MinElementSize = ( 1.5 1.5 1.5 )
	}
	Refinement "REFI_IMP_def" {
		MaxElementSize = ( 1 1 1 )
		MinElementSize = ( 0.2 0.2 0.2 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
}

Placements {
	Constant "BULK_placement" {
		Reference = "BULK_profile"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	AnalyticalProfile "BOT_IMP_placement" {
		Reference = "BOT_IMP_profile"
		ReferenceElement {
			Element = Line [(0 200) (165 200)]
		}
	}
	AnalyticalProfile "IMP1_placement" {
		Reference = "IMP_profile"
		ReferenceElement {
			Element = Line [(8 0) (47 0)]
		}
	}
	AnalyticalProfile "IMP2_placement" {
		Reference = "IMP_profile"
		ReferenceElement {
			Element = Line [(63 0) (102 0)]
		}
	}
	AnalyticalProfile "IMP3_placement" {
		Reference = "IMP_profile"
		ReferenceElement {
			Element = Line [(118 0) (157 0)]
		}
	}
	AnalyticalProfile "PSTOP1_placement" {
		Reference = "PSTOP_profile"
		ReferenceElement {
			Element = Line [(0 0) (3 0)]
		}
	}
	AnalyticalProfile "PSTOP2_placement" {
		Reference = "PSTOP_profile"
		ReferenceElement {
			Element = Line [(52 0) (58 0)]
		}
	}
	AnalyticalProfile "PSTOP3_placement" {
		Reference = "PSTOP_profile"
		ReferenceElement {
			Element = Line [(107 0) (113 0)]
		}
	}
	AnalyticalProfile "PSTOP4_placement" {
		Reference = "PSTOP_profile"
		ReferenceElement {
			Element = Line [(162 0) (165 0)]
		}
	}
	Refinement "ALL_REFI_placement" {
		Reference = "REFI_ALL_def"
		RefineWindow = Rectangle [(-10 210) (175 -10)]
	}
	Refinement "IMP_REFI_placement" {
		Reference = "REFI_IMP_def"
		RefineWindow = Rectangle [(0 -1.5) (165 2.5)]
	}
	Refinement "BOT_IMP_REFI_placement" {
		Reference = "REFI_IMP_def"
		RefineWindow = Rectangle [(0 200) (165 198.5)]
	}
	Refinement "REFI1_TOP_placement" {
		Reference = "REFI1_def"
		RefineWindow = Rectangle [(0 -1.5) (165 2.5)]
	}
	Refinement "REFI2_TOP_placement" {
		Reference = "REFI2_def"
		RefineWindow = Rectangle [(0 0) (165 5)]
	}
	Refinement "REFI3_TOP_placement" {
		Reference = "REFI3_def"
		RefineWindow = Rectangle [(0 0) (165 10)]
	}
	Refinement "REFI1_BOT_placement" {
		Reference = "REFI1_def"
		RefineWindow = Rectangle [(0 200) (165 197.5)]
	}
	Refinement "REFI2_BOT_placement" {
		Reference = "REFI2_def"
		RefineWindow = Rectangle [(0 201.1) (165 195)]
	}
	Refinement "REFI3_BOT_placement" {
		Reference = "REFI3_def"
		RefineWindow = Rectangle [(0 201.1) (165 190)]
	}
}

