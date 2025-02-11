Title ""

Controls {
}

IOControls {
	EnableSections
}

Definitions {
	Constant "bulk_profile" {
		Species = "BoronActiveConcentration"
		Value = 4.7e+12
	}
	AnalyticalProfile "nplus_implant_profile" {
		Species = "PhosphorusActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+12, Depth = 2.4)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "pplus_implant_profile" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+19, ValueAtDepth = 1e+12, Depth = 2.4)
		LateralFunction = Gauss(Factor = 0.8)
	}
	AnalyticalProfile "pstop_profile" {
		Species = "BoronActiveConcentration"
		Function = Gauss(PeakPos = 0, PeakVal = 1e+15, ValueAtDepth = 1e+12, Depth = 2)
		LateralFunction = Gauss(Factor = 0.8)
	}
	Refinement "Ref_all_def" {
		MaxElementSize = ( 5 5 5 )
		MinElementSize = ( 5 5 5 )
	}
	Refinement "ref1" {
		MaxElementSize = ( 0.8 0.8 0.8 )
		MinElementSize = ( 0.05 0.1 0.1 )
	}
	Refinement "ref2" {
		MaxElementSize = ( 1 1 1 )
		MinElementSize = ( 0.2 0.3 0.3 )
	}
	Refinement "ref3" {
		MaxElementSize = ( 2 2 2 )
		MinElementSize = ( 0.3 0.5 0.5 )
	}
	Refinement "ref4" {
		MaxElementSize = ( 2 2 2 )
		MinElementSize = ( 0.75 0.75 0.75 )
	}
	Refinement "implant_refinement_def" {
		MaxElementSize = ( 1 2.5 2.5 )
		MinElementSize = ( 0.1 0.15 0.15 )
		RefineFunction = MaxTransDiff(Variable = "DopingConcentration",Value = 1)
	}
}

Placements {
	Constant "bulk_placement" {
		Reference = "bulk_profile"
		EvaluateWindow {
			Element = region ["bulk"]
		}
	}
	AnalyticalProfile "implant_placement" {
		Reference = "nplus_implant_profile"
		ReferenceElement {
			Element = Polygon [ (0 16.5 -19.5) (0 18 -19.098076) (0 19.098076 -18) (0 19.5 -16.5) (0 19.5 16.5) (0 19.098076 18) (0 18 19.098076) (0 16.5 19.5) (0 -16.5 19.5) (0 -18 19.098076) (0 -19.098076 18) (0 -19.5 16.5) (0 -19.5 -16.5) (0 -19.098076 -18) (0 -18 -19.098076) (0 -16.5 -19.5)]
		}
	}
	AnalyticalProfile "backside_implant_placement" {
		Reference = "pplus_implant_profile"
		ReferenceElement {
			Element = Polygon [ (200 27.5 27.5) (200 -27.5 27.5) (200 -27.5 -27.5) (200 27.5 -27.5)]
		}
	}
	AnalyticalProfile "pstop_placement" {
		Reference = "pstop_profile"
		ReferenceElement {
			Element = ComplexPolygon [ Polygon [ (0 27.5 27.5) (0 -27.5 27.5) (0 -27.5 -27.5) (0 27.5 -27.5) (0 27.5 27.5)] Polygon [ (0 -24.5 -24.5) (0 -24.5 24.5) (0 24.5 24.5) (0 24.5 -24.5) (0 -24.5 -24.5)]]
		}
	}
	Refinement "implant_refinement" {
		Reference = "implant_refinement_def"
		RefineWindow = Polygon [ (0 16.5 -19.5) (0 18 -19.098076) (0 19.098076 -18) (0 19.5 -16.5) (0 19.5 16.5) (0 19.098076 18) (0 18 19.098076) (0 16.5 19.5) (0 -16.5 19.5) (0 -18 19.098076) (0 -19.098076 18) (0 -19.5 16.5) (0 -19.5 -16.5) (0 -19.098076 -18) (0 -18 -19.098076) (0 -16.5 -19.5)]
	}
	Refinement "backside_implant_refinement" {
		Reference = "implant_refinement_def"
		RefineWindow = Polygon [ (200 27.5 27.5) (200 -27.5 27.5) (200 -27.5 -27.5) (200 27.5 -27.5)]
	}
	Refinement "Everything_refinement" {
		Reference = "Ref_all_def"
		RefineWindow = Cuboid [(-10 -30 -30) (210 30 30)]
	}
	Refinement "ref1_top_refinement" {
		Reference = "ref1"
		RefineWindow = Cuboid [(0 -27.5 -27.5) (2.5 27.5 27.5)]
	}
	Refinement "ref2_top_refinement" {
		Reference = "ref2"
		RefineWindow = Cuboid [(-0.5 -27.5 -27.5) (4 27.5 27.5)]
	}
	Refinement "ref3_top_refinement" {
		Reference = "ref3"
		RefineWindow = Cuboid [(0 -27.5 -27.5) (6 27.5 27.5)]
	}
	Refinement "ref4_top_refinement" {
		Reference = "ref4"
		RefineWindow = Cuboid [(0 -27.5 -27.5) (20 27.5 27.5)]
	}
	Refinement "ref1_bot_refinement" {
		Reference = "ref1"
		RefineWindow = Cuboid [(198 -27.5 -27.5) (201.1 27.5 27.5)]
	}
	Refinement "ref2_bot_refinement" {
		Reference = "ref2"
		RefineWindow = Cuboid [(196 -27.5 -27.5) (201.1 27.5 27.5)]
	}
	Refinement "ref3_bot_refinement" {
		Reference = "ref3"
		RefineWindow = Cuboid [(194 -27.5 -27.5) (201.1 27.5 27.5)]
	}
}

