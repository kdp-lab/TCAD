
File{
  Grid    = "n51_msh.tdr"
  Parameter= "pp56_des.par"
  Plot    = "n56_des.tdr"
  Current = "n56_des.plt"
  Output  = "n56_des.log"
}

Electrode {
	{Name="implant_electrode"	Voltage=0.0}
	{Name="backside_electrode"	Voltage=0.0}
}

Physics	{
	Fermi
	Temperature = 241.5
	Mobility(
	 	eHighFieldSaturation
	 	hHighFieldSaturation
	 	PhuMob( Phosphorus Klaassen )
	 )
	Recombination(
			SRH(
				DopingDependence 		
				TempDependence		
				ElectricField(Lifetime=Hurkx DensityCorrection=none)
			)
	 		eAvalanche (vanOverstraeten Eparallel)
			hAvalanche (vanOverstraeten Eparallel)  
		)	
	EffectiveIntrinsicDensity(BandGapNarrowing(Slotboom))
}
Physics(MaterialInterface="Oxide/Silicon") {
		Charge(Conc = 1e12) 					
}

Physics (material = "Silicon"){
	Traps(
		(Donor Level
		fromValBand
		Conc = 16000000000000000.0
		EnergyMid = 0.48
		eXsection = 2.0e-14
		hXsection = 1e-14)
	
		(Acceptor Level
		fromCondBand
		Conc = 3000000000000000.0
		EnergyMid = 0.525
		eXsection = 5e-15
		hXsection = 1e-14)

		(Acceptor Level
		fromValBand
		Conc = 1.44e+17
		EnergyMid = 0.90
		eXsection = 1e-16 
		hXsection = 1e-16 )
	)
}
	
Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
	SRHRecombination HeavyIonChargeDensity AvalancheGeneration eAlphaAvalanche hAlphaAvalanche
	eAvalanche hAvalanche eTrappedCharge hTrappedCharge eGapStatesRecombination hGapStatesRecombination
}

Math{
	NumberOfThreads = maximum
	Method = Blocked
	SubMethod = pardiso





	Digits=5
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 12
}

Solve {
	Coupled(iterations = 600){Poisson}
	Coupled{Poisson Hole Electron}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-6
		Increment=1.4
		Decrement=2
		Goal{ name="backside_electrode" voltage= -1000}
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "n56_quasi" Time = (0.5; 0.6; 0.7; 0.8; 0.9; 1) NoOverwrite ) 
	}
}

