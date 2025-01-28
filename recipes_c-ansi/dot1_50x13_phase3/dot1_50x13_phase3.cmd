Title "Dot 1 pspray (Vdep = 7.7V@100um)"
Controls
{
meshengine = "mesh"
}
Definitions
{
# Profiles
Constant "p-_region"
{
Species = "BoronActiveConcentration" Value = 1.0e+12
}

AnalyticalProfile "n-type_well" 
{
   Species = "PhosphorusActiveConcentration" 
   Function = Erf(SymPos = 1.0, Dose = 1e+14, Length = 0.6)  
   LateralFunction = Erf(Factor = 1.0)
}

AnalyticalProfile "p-type_well"
{
  Species = "BoronActiveConcentration"
  Function = Erf(SymPos = 1.0, Dose = 1e+14, Length = 0.6)
   LateralFunction = Erf(Factor = 0.01)
}

AnalyticalProfile "p-spray"
{
  Species = "BoronActiveConcentration"
  Function = Erf(SymPos = 0.25, Dose = 2e+12, Length = 0.6)
   LateralFunction = Erf(Factor = 0.01)
}

# Refinement regions
Refinement "bulk_region"
{  MaxElementSize = (5,2.5,1) 
   MinElementSize = (5,2.5,1)
}

Refinement "p+_side"

{
  MinElementSize = (0.3, 2.5, 1)
  MaxElementSize = (5, 2.5, 1)
  RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 1)
}

Refinement "n+_side"

{
  MinElementSize = (0.3, 0.2, 0.2)
  MaxElementSize = (2, 1, 1.0)
  RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 1)
}

Refinement "n+_half"

{
  MinElementSize = (2, 1, 1)
  MaxElementSize = (5, 2.5, 1)
  RefineFunction = MaxTransDiff(Variable = "DopingConcentration", Value = 1)
}


}

Placements

{
# Profiles

Constant "p-_region instance"

{
  Reference = "p-_region"
  EvaluateWindow
{
  Element = cuboid [(0 0 0), (100 25 6.25)] # for 3D
}
}

AnalyticalProfile "p-spray instance"

{
  Reference = "p-spray"
  ReferenceElement
{
  Element = rectangle [(100, 0, 0) (100, 25, 6.25)]
}
}

AnalyticalProfile "n-type_well instance"

{
  Reference = "n-type_well"
  ReferenceElement
{
  Element = rectangle [(100, 0, 0) (100, 22, 4)]
}
}

AnalyticalProfile "p-type_well instance"

{
  Reference = "p-type_well"
  ReferenceElement
{
  Element = rectangle [(0, 0, 0) (0, 25, 6.25)]
}
}


# Refinement regions

Refinement "p+_side instance"

{
  Reference = "p+_side"
  RefineWindow = cuboid [(0 0 0), (15 25 6.25)]
}

Refinement "n+_side instance"

{
  Reference = "n+_side"
  RefineWindow = cuboid [(95 0 0), (100 25 6.25)]
}

Refinement "n+_half instance"

{
  Reference = "n+_half"
  RefineWindow = cuboid [(85 0 0), (95 25 6.25)]
}

Refinement "bulk_region instance"

{
  Reference = "bulk_region"}
}
