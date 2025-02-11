File {
  	Grid    = "../meshes/@mesh@_msh.tdr"
	Parameter= "sdevice.par"
	Plot=   "@tdrdat@"
	Current="@plot@"
	Output= "@log@"
}

Electrode {
	{Name="IMP1_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="IMP2_electrode" Voltage= 0.0 Material = "Aluminum"}
	{Name="IMP3_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="IMP4_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="IMP5_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="BOT_electrode"	Voltage=0.0 Material = "Aluminum"}
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
		Charge(Conc = 1e12 ) 					
}

Physics (material = "Silicon"){
	Traps(
		(Donor Level
		Add2TotalDoping
		fromValBand
		Conc = @<4*fluence>@
		EnergyMid = 0.48
		eXsection = 2.0e-14
		hXsection = 1e-14)
	
		(Acceptor Level
		Add2TotalDoping
		fromCondBand
		Conc = @<0.75*fluence>@
		EnergyMid = 0.525
		eXsection = 5e-15
		hXsection = 1e-14)

		(Acceptor Level
		Add2TotalDoping
		fromCondBand
		Conc = @<0.5*fluence>@
		EnergyMid = 0.90
		eXsection = 1e-14
		hXsection = 1e-14)
	)
}

Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
	SRHRecombination HeavyIonChargeDensity AvalancheGeneration eAlphaAvalanche hAlphaAvalanche
	eAvalanche hAvalanche eTrappedCharge hTrappedCharge eGapStatesRecombination hGapStatesRecombination
}

Math{
	Method = blocked
	SubMethod = pardiso
	NumberOfThreads = maximum
	Digits=5
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 15
}

Solve {
	Coupled(iterations = 600){Poisson}
	Coupled(iterations = 600){Poisson Electron Hole}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-5
		Increment=1.4
		Decrement=2
		Goal{ name="BOT_electrode" voltage= @voltage@}
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "n@node@_midIMP_0V" Time = (1.0) NoOverwrite ) 
	}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-7
		Increment=1.4
		Decrement=2
		Goal{ name="IMP3_electrode" voltage= 1.0 }
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "n@node@_midIMP_1V" Time = (1.0) NoOverwrite ) 
	}
}
