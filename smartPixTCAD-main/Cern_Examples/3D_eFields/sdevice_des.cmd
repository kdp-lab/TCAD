
File{
  Grid    = "@tdr@"
  Parameter= "@parameter@"
  Plot    = "@tdrdat@"
  Current = "@plot@"
  Output  = "@log@"
}

Electrode {
	{Name="implant_electrode"	Voltage=0.0}
	{Name="backside_electrode"	Voltage=0.0}
}

Physics	{
	Fermi
	Temperature = @temp@
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
		Charge(Conc = @Qf@) 					
}

#if @fluence@ != 0	
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
#endif
	
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
	# ILSrc = " 
	# set (1) {
	# 	iterative( gmres(80), tolrel = 1e-8, tolunprec = 1e-4, tolabs=0, maxit=200);         	
	#         preconditioning( ilut(0.001, -1) );                                                   
	# 	ordering ( symmetric=nd, nonsymmetric = mpsilst);
	# 	options (compact = yes, verbose = 2, refineresidual = 0);
	# };
	# "

        # #gmres lower: faster execution time and less memory. gmes higher: Increases convergence. Try to reduce for huge mesh. 
        # #Set ilut first value to a lower value for higher precision and higher for less ram use




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
		Goal{ name="backside_electrode" voltage= @bias@}
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "n@node@_quasi" Time = (0.5; 0.6; 0.7; 0.8; 0.9; 1) NoOverwrite ) 
	}
}
