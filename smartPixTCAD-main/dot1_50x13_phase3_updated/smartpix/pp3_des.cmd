File { * input files:
    Grid = "n2_msh.tdr"
    Doping = "n2_msh.tdr"
    * output files:
    Plot = "n3_des.dat"
    Current = "n3_des.plt"
    Output = "n3_des.log"
}

Electrode {
    { Name="anode"  Voltage=0.0 }
    { Name="cathode"  Voltage=0.0 }
}

Physics {
    Temperature = 263
    Traps( 
           * MidBand Acceptor
           (Acceptor Level EnergyMid=+0.010 fromMidBandGap 
            Conc=1.5e11 eXsection=1.e-16 hXsection=1.e-16
            Tunneling(Hurkx))
           * MidBand Donor
           (Donor Level EnergyMid=-0.010 fromMidBandGap 
            Conc=1.5e11 eXsection=1.e-16 hXsection=1.e-16
            Tunneling(Hurkx))
         )
    Mobility (DopingDep HighFieldSat Enormal)
    Recombination (SRH (DopingDependence TempDependence Tunneling(Hurkx)) Band2Band)
}

Plot { ElectricField/Vector }

Math { Method = pardiso ConstRefPot Iterations = 15 Digits = 4.5 }

Solve { Poisson
    Coupled {Poisson electron hole}
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -0.1} InitialStep = 0.05 Increment = 1.5 Decrement = 1.5) {
        Coupled  {Poisson electron hole}
}
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -1.0} InitialStep = 0.02 Increment = 1.2 Decrement = 1.2) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_01")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -5.0} InitialStep = 0.1 Increment = 1.5 Decrement = 1.5) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_05")
    Plot ( -Loadable FilePrefix="n3_05")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -7.7} InitialStep = 0.1 Increment = 1.5 Decrement = 1.5) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_08")
    Plot ( -Loadable FilePrefix="n3_08")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -19.9} InitialStep = 0.05 Increment = 1.3 Decrement = 1.3) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_19")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -20.0} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_20")
    Plot ( -Loadable FilePrefix="n3_20")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -39.9} InitialStep = 0.1 Increment = 1.5 Decrement = 1.5 ) {
        Coupled {Poisson electron hole}
}
    Save (FilePrefix="n3_39")
Quasistationary 
    (Goal {Name = "cathode" Voltage = -40} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_40")
    Plot ( -Loadable FilePrefix="n3_40")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -49.9} InitialStep = 0.2 Increment = 1.5 Decrement = 1.5 ) {
        Coupled {Poisson electron hole}
}
    Save (FilePrefix="n3_49")
Quasistationary 
    (Goal {Name = "cathode" Voltage = -50} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_50")
    Plot ( -Loadable FilePrefix="n3_50")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -59.9} InitialStep = 0.2 Increment = 1.5 Decrement = 1.5 ) {
        Coupled {Poisson electron hole}
}
    Save (FilePrefix="n3_59")
Quasistationary 
    (Goal {Name = "cathode" Voltage = -60} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_60")
    Plot ( -Loadable FilePrefix="n3_60")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -69.9} InitialStep = 0.2 Increment = 1.5 Decrement = 1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_69")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -70} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_70")
    Plot ( -Loadable FilePrefix="n3_70")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -99.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_99")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -100} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_100")
    Plot ( -Loadable FilePrefix="n3_100")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -114.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_114")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -115} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_115")
    Plot ( -Loadable FilePrefix="n3_115")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -124.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_124")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -125} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_125")
    Plot ( -Loadable FilePrefix="n3_125")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -149.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_149")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -150} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_150")
    Plot ( -Loadable FilePrefix="n3_150")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -174.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_174")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -175} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_175")
    Plot ( -Loadable FilePrefix="n3_175")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -199.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_199")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -200} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_200")
    Plot ( -Loadable FilePrefix="n3_200")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -224.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_224")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -225} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_225")
    Plot ( -Loadable FilePrefix="n3_225")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -249.9} InitialStep = 0.1 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_249")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -250} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_250")
    Plot ( -Loadable FilePrefix="n3_250")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -274.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_274")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -275} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_275")
    Plot ( -Loadable FilePrefix="n3_275")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -299.9} InitialStep = 0.10 Increment=1.5 Decrement=1.5 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_299")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -300} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_300")
    Plot ( -Loadable FilePrefix="n3_300")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -324.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_324")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -325} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_325")
    Plot ( -Loadable FilePrefix="n3_325")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -349.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_349")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -350} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_350")
    Plot ( -Loadable FilePrefix="n3_350")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -374.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_374")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -375} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_375")
    Plot ( -Loadable FilePrefix="n3_375")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -399.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_399")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -400} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_400")
    Plot ( -Loadable FilePrefix="n3_400")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -424.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_424")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -425} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_425")
    Plot ( -Loadable FilePrefix="n3_425")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -449.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_449")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -450} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_450")
    Plot ( -Loadable FilePrefix="n3_450")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -474.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_474")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -475} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_475")
    Plot ( -Loadable FilePrefix="n3_475")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -499.9} InitialStep = 0.2 Increment=1.3 Decrement=1.3 ) {
        Coupled  {Poisson electron hole}
}
    Save (FilePrefix="n3_499")
    Quasistationary 
    (Goal {Name = "cathode" Voltage = -500} InitialStep = 1.0 ) {
        Coupled (Iterations = 50 Digits = 5) {Poisson electron hole}
}
    Save (FilePrefix="n3_500")
    Plot ( -Loadable FilePrefix="n3_500")

}

