
File {
   * input files:
	Grid=   "../meshes/Edge_msh.tdr"
	Parameter= "@parameter@"
	Plot=   "@tdrdat@"
	Current="@plot@"
	Output= "@log@"
}

Electrode {
	{Name="IMP1_electrode"	Voltage=0.0}
	{Name="BOT_electrode"	Voltage=0.0} 
	{Name="OG_electrode"	Voltage=0.0} 		#OG = Outer guard ring
	{Name="IG_electrode"	Voltage=0.0}   		#IG = Inner guard ring
	{Name="MG_electrode"	Voltage=0.0} 		#MG = Middle guard ring
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
		Charge(Conc = @Qf@ ) 					
}
	

Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
	SRHRecombination HeavyIonChargeDensity AvalancheGeneration eAlphaAvalanche hAlphaAvalanche
	eAvalanche hAvalanche eTrappedCharge hTrappedCharge eGapStatesRecombination hGapStatesRecombination
}

Math{
	NumberOfThreads = maximum
	Digits=5
	Extrapolate
	RelErrControl
	Method = blocked
	SubMethod = pardiso
	Derivatives
	Notdamped = 50
	Iterations = 15
}

Solve {
	Coupled(iterations = 200){Poisson}
	Coupled(iterations = 200){Poisson Hole Electron}

	Set ("MG_electrode" mode current)
	QuasiStationary ( 
		InitialStep=1e-9
		Maxstep=0.05
		MinStep=1e-11
		Increment=1.41 
		Goal { name="MG_electrode" current=0 }
	) { 
		Coupled {Poisson Electron Hole}
	}

	Set ("OG_electrode" mode current)
	QuasiStationary ( 
		InitialStep=1e-9
		Maxstep=0.05
		MinStep=1e-11
		Increment=1.41 
		Goal { name="OG_electrode" current=0 }
	) { 
		Coupled {Poisson Electron Hole}
	}

	Quasistationary(
		InitialStep=1e-3
		Maxstep=0.04
		MinStep=1e-6
		Increment=1.4
		Decrement=2
		Goal{ name="BOT_electrode" voltage= @Vb@}
	){ 
		Coupled {Poisson Electron Hole}
	}

}
