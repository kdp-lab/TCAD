File {
	Grid=   "BasicDiode_msh.tdr"
	Plot=   "results/radDamage_des.tdr"
	Current="results/radDamage_des.plt"
	Output= "results/radDamage_des.log"
}

Electrode {
	{Name="IMP1_electrode"	Voltage=0.0 Material = "Aluminum"}
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

Physics(MaterialInterface="Oxide/Silicon") { 		#The mesh used here contains no oxide, but this is included for completeness
		Charge(Conc = 1e12 ) 					
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

# First solve the Poission equation. Afterwards, solve the full coupled equation set with all electrodes grounded. 
# Then gradually ramp the electrode at the backside to -1000
# A variable t is ramped from 0 to 1, where V(t) = V_start + t(V_end - V_start) 
Solve {
	Coupled(iterations = 600){Poisson}
	Coupled{Poisson Hole Electron}
	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-5
		Increment=1.4
		Decrement=2
		Goal{ name="BOT_electrode" voltage= -1000}
	){ 
		Coupled {Poisson Electron Hole}
		Plot(FilePrefix = "results/biasRamp" Time = (0.5)) #Save the field at 500V. 
	}
}


