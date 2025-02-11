Device Pixel {

File {
Grid = "../meshes/2D_P1_msh.tdr"
Parameter = "sdevice.par"
Plot = "@tdrdat@"
Current = "@plot@"
}

Electrode {
{Name = "IMP1_electrode" voltage = 0.0 Material = "Aluminum"}
{Name = "BOT_electrode" voltage = 0.0 Material = "Aluminum" }
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
#if @fluence@ > 1e13
Physics(MaterialInterface="Oxide/Silicon") {
		Charge(Conc = 1e12 ) 					
} 
#else 
Physics(MaterialInterface="Oxide/Silicon") {
		Charge(Conc = 1e11 ) 					
} 
#endif

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
}


File {
Output = "@log@"
ACExtract = "@acplot@"
}

System {
 Pixel pixel( "BOT_electrode"=cp "IMP1_electrode"=cn)
 Vsource_pset vn (cn 0) {dc=0}
 Vsource_pset vp (cp 0) {dc=0}
}

Plot {
      eDensity hDensity eCurrent/Vector hCurrent/Vector
      Potential ElectricField/Vector
      SpaceCharge Doping
      eQuasiFermi hQuasiFermi
      Doping DonorConcentration AcceptorConcentration
      eTrappedCharge hTrappedCharge
      eGapStatesRecombination hGapStatesRecombination
}

Math {
	NumberOfThreads = maximum
	Digits=5
	method = blocked
	submethod = pardiso
	Extrapolate
	RelErrControl
	Derivatives
	Notdamped = 50
	Iterations = 15
}

Solve {
    coupled (iterations=100) { Poisson }
    Coupled (iterations=100) { Poisson Electron Hole }
    Save(FilePrefix="n@node@_init")

    ACCoupled ( StartFrequency=@freq@ EndFrequency= @freq@
                NumberOfPoints=1 Decade
                Node(cp cn) Exclude(vp vn)
              )
              {Poisson Electron Hole Circuit Contact}

    QuasiStationary ( InitialStep=1e-7
                      Minstep   = 1e-10
                      MaxStep   = 0.04
                      Increment = 1.25  
                      Decrement = 4 
                      Goal {Parameter=vp.dc voltage  = @voltage@ }
                    ) 
               { 
                 ACCoupled ( Iterations=10
                            StartFrequency=@freq@ EndFrequency=@freq@
                            NumberOfPoints=1 Decade
                            Node(cp cn) Exclude(vp vn)
                          )
                          {Poisson Electron Hole Circuit Contact}
               }
}


