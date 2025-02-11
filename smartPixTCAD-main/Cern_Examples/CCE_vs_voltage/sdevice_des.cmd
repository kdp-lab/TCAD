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
	HeavyIon (
		Direction=(0.000000,200.000000)
		Location=(137.5,0.000000)
		Time=0.02e-9
		Length = 200.000000
		wt_hi = 1.0
		LET_f = 1.282E-5
		Picocoulomb )
}

Physics(MaterialInterface="Oxide/Silicon") {
		Charge(Conc = 1e12 ) 					
}
	
Physics (material = "Silicon"){
	Traps(
		(Donor Level
		fromValBand
		Conc = @<4*fluence>@
		EnergyMid = 0.48
		eXsection = 2.0e-14
		hXsection = 1e-14)
	
		(Acceptor Level
		fromCondBand
		Conc = @<0.75*fluence>@
		EnergyMid = 0.525
		eXsection = 5e-15
		hXsection = 1e-14)

		(Acceptor Level
		fromValBand
		Conc = @<36*fluence>@
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
        hSaturationVelocity eSaturationVelocity eLifetime 
	eDriftVelocity/Vector eVelocity/Vector  
	hDriftVelocity/Vector hVelocity/Vector 
}

Math{
	NumberOfThreads = maximum
	Method = Blocked
	Submethod = pardiso

	Digits=5
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 15
 	RecBoxIntegr(1e-3 50 5000)
 	# RecBoxIntegr(1e-2 30 3000)
	CheckTransientError
	TransientDigits = 5
}

Solve {
	Coupled(iterations = 600){Poisson}
	Coupled{Poisson Hole Electron}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-5
		Increment=1.4
		Decrement=2
		Goal{ name="BOT_electrode" voltage= @voltage@}
	){ 
		Coupled {Poisson Electron Hole}
	}
	NewCurrentPrefix = "transient"
	Transient( 
		InitialTime = 0.0 
		FinalTime= 25E-9
		InitialStep=0.5E-11
		MaxStep=5E-9
	){
		Coupled (iterations=8, notdamped=15) { Poisson Electron Hole } 
	}
}
