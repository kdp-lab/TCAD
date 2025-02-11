File {
	Grid=   "mesh/2D_3pixel_msh.tdr"
	Plot=   "results/pixel.tdr"
	Current="results/pixel.plt"
	Output= "results/pixel.log"
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
}

Physics(MaterialInterface="Oxide/Silicon") {
		Charge(Conc = 1e10 ) 					
}


Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
	SRHRecombination AvalancheGeneration
	eAvalanche hAvalanche 
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
}

Solve {
	Coupled(iterations = 100){Poisson}
	Coupled(iterations = 100){Poisson Electron Hole}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-5
		Increment=1.4
		Decrement=2
		Goal{ name="BOT_electrode" voltage= -1000}
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "results/pixel_0V" Time = (1.0) NoOverwrite ) 
	}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-6
		Increment=1.4
		Decrement=2
		Goal{ name="IMP2_electrode" voltage= 1.0 }
	){ 
		Coupled {Poisson Electron Hole}
		Plot ( FilePrefix = "results/pixel_1V" Time = (1.0) NoOverwrite ) 
	}
}
