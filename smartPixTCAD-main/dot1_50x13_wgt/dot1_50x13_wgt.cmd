Title "Dot 1 pspray"
Controls
{
meshengine = "mesh"
}
Definitions
{
# Profiles
Constant "n-_region"
{
Species = "PhosphorusActiveConcentration" Value = 1.0e+10
}


# Refinement regions
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

Constant "n-_region instance"

{
  Reference = "n-_region"
  EvaluateWindow
{
   Element = cuboid [ (0,0,0) (100,125,31.25) ] # for 3D

}
}

# Refine regions

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

