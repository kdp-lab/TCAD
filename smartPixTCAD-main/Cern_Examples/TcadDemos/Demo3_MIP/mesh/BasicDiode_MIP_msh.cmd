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
		Function = Gauss(PeakPos = 0, PeakVal = 1e+18, ValueAtDepth = 1e+12, Depth = 2.4)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "BOT_IMP_profile" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+18, ValueAtDepth = 1e+12, Depth = 2)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "general_refinement" {
		MaxElementSize = ( 5 5 5 )
		MinElementSize = ( 0.1 0.1 0.1 )
	}
	Refinement "implant_refinement_profile" {
		MaxElementSize = ( 1 1 1 )
		MinElementSize = ( 0.1 0.1 0.1 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 2)
	}
	Refinement "REFI1_def" {
		MaxElementSize = ( 0.8 0.8 0.8 )
		MinElementSize = ( 0.4 0.4 0.4 )
	}
	Refinement "REFI2_def" {
		MaxElementSize = ( 1.2 1.2 1.2 )
		MinElementSize = ( 0.6 0.6 0.6 )
	}
	Refinement "REFI3_def" {
		MaxElementSize = ( 3 3 3 )
		MinElementSize = ( 1.5 1.5 1.5 )
	}
}

Placements {
	Constant "bulk_placement" {
		Reference = "BULK_profile"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	AnalyticalProfile "nPlus_placement" {
		Reference = "IMP_profile"
		ReferenceElement {
			Element = Line [(0 0) (55 0)]
		}
	}
	AnalyticalProfile "pPlus_placement" {
		Reference = "BOT_IMP_profile"
		ReferenceElement {
			Element = Line [(0 55) (55 55)]
		}
	}
	Refinement "everything_ref_placement" {
		Reference = "general_refinement"
		RefineWindow = Rectangle [(-1 -1) (56 56)]
	}
	Refinement "top_ref_placement" {
		Reference = "implant_refinement_profile"
		RefineWindow = Rectangle [(0 0) (55 3)]
	}
	Refinement "bot_ref_placement" {
		Reference = "implant_refinement_profile"
		RefineWindow = Rectangle [(0 55) (55 52)]
	}
	Refinement "REFI1_MIP_placement" {
		Reference = "REFI1_def"
		RefineWindow = Rectangle [(23.5 55) (31.5 0)]
	}
	Refinement "REFI2_MIP_placement" {
		Reference = "REFI2_def"
		RefineWindow = Rectangle [(21.5 55) (33.5 0)]
	}
	Refinement "REFI3_MIP_placement" {
		Reference = "REFI3_def"
		RefineWindow = Rectangle [(19.5 55) (35.5 0)]
	}
}

