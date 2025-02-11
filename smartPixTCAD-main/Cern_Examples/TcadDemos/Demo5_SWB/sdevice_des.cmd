File {
	Grid=   "n@node|-1@_msh.tdr"
	Plot=   "@tdrdat@"
	Current="@plot@"
	Output= "@log@"
}

Electrode {
	{Name="IMP1_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="IMP2_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="IMP3_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="BOT_electrode"	Voltage=0.0 Material = "Aluminum"}
}


Physics	{
	Fermi
	Temperature = 241.5 
	Mobility( eHighFieldSaturation hHighFieldSaturation PhuMob( Phosphorus Klaassen ) )
	Recombination(SRH(
				DopingDependence 		
				TempDependence		
				ElectricField(Lifetime=Hurkx DensityCorrection=none)
			)
	 		eAvalanche (vanOverstraeten Eparallel)
			hAvalanche (vanOverstraeten Eparallel)  
	)	
	EffectiveIntrinsicDensity(BandGapNarrowing(Slotboom))
	
	#Add Gaussian charge profile
	HeavyIon (
		Direction=(0.000000, 200.000000)
		Location=(@<Xmip + 82.5>@,0.000000)
		Time=0.02e-9
		Length = 200.000000
		wt_hi = 1.0
		LET_f = 1.282E-5
		Picocoulomb)
}

Physics(MaterialInterface="Oxide/Silicon") { 		#The mesh used here contains no oxide, but this is included for completeness
		Charge(Conc = @Qox@) 					
}

Physics (material = "Silicon"){
	Traps(
		(Donor Level
		fromValBand
		Conc = 16e15
		EnergyMid = 0.48
		eXsection = 2.0e-14
		hXsection = 1e-14)
	
		(Acceptor Level
		fromCondBand
		Conc = 3e15 
		EnergyMid = 0.525
		eXsection = 5e-15
		hXsection = 1e-14)

		(Acceptor Level
		fromValBand
		Conc = 144e15
		EnergyMid = 0.90
		eXsection = 1e-16 
		hXsection = 1e-16 )
	)
}

Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
	eTrappedCharge hTrappedCharge eGapStatesRecombination hGapStatesRecombination 			#We add some additional quantities to visualize trap states
	SRHRecombination AvalancheGeneration
	eAvalanche hAvalanche 
	HeavyIonChargeDensity
}

Math{
	NumberOfThreads = maximum
	Method = blocked
	SubMethod = pardiso
	Digits=5
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 15

	#Additional commands specific from transient simmulations 
 	RecBoxIntegr(1e-2 10 1000)
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
		FinalTime= 20E-9
		InitialStep=0.5E-11
		MaxStep=5E-9
	){
		Coupled (iterations=8, notdamped=15) { Poisson Electron Hole } 
	}
}


