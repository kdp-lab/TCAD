Device Pixel {

File {
Grid = "../meshes/2D_P1_msh.tdr"
Parameter = "sdevice.par"
Plot = "n8_des.tdr"
Current = "n8_des.plt"
}

Electrode {
{Name = "IMP1_electrode" voltage = 0.0 Material = "Aluminum"}
{Name = "BOT_electrode" voltage = 0.0 Material = "Aluminum" }
}

Physics	{
	Fermi
	Temperature = 293.15
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
		Charge(Conc = 1e11 ) 					
} 

}


File {
Output = "n8_des.log"
ACExtract = "n8_ac_des.plt"
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
    Save(FilePrefix="n8_init")

    ACCoupled ( StartFrequency=1000 EndFrequency= 1000
                NumberOfPoints=1 Decade
                Node(cp cn) Exclude(vp vn)
              )
              {Poisson Electron Hole Circuit Contact}

    QuasiStationary ( InitialStep=1e-7
                      Minstep   = 1e-10
                      MaxStep   = 0.04
                      Increment = 1.25  
                      Decrement = 4 
                      Goal {Parameter=vp.dc voltage  = -300 }
                    ) 
               { 
                 ACCoupled ( Iterations=10
                            StartFrequency=1000 EndFrequency=1000
                            NumberOfPoints=1 Decade
                            Node(cp cn) Exclude(vp vn)
                          )
                          {Poisson Electron Hole Circuit Contact}
               }
}



