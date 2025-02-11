File {
	Grid=   "mesh/BasicDiode_msh.tdr"
	Plot=   "results/basicSimulation_des.tdr"
	Current="results/basicSimulation_des.plt"
	Output= "results/basicSimulation_des.log"
}

Electrode {
	{Name="IMP1_electrode"	Voltage=0.0 Material = "Aluminum"}
	{Name="BOT_electrode"	Voltage=0.0 Material = "Aluminum"}
}


Physics	{
	Temperature = 300 
	Mobility(eHighFieldSaturation hHighFieldSaturation PhuMob( Phosphorus Klaassen ))
	Recombination( SRH( DopingDependence TempDependence) )
	EffectiveIntrinsicDensity(BandGapNarrowing(Slotboom))
}

Plot {
	eDensity hDensity eCurrent/Vector hCurrent/Vector Potential
	SpaceCharge ElectricField/Vector Doping eMobility hMobility
}

Math{
	NumberOfThreads = maximum
	Digits=5
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 15
}

# First solve the Poission equation. Afterwards, solve the full coupled equation set with all electrodes grounded. 
# Then gradually ramp the electrode at the backside to -500. 
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
		Goal{ name="BOT_electrode" voltage= -500}
	){ 
		Coupled {Poisson Electron Hole}
	}
}


