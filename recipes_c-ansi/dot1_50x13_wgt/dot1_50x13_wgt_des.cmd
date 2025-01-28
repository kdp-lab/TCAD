File { * input files:
    Grid = "dot1_50x13_wgt_msh.grd"
    Doping = "dot1_50x13_wgt_msh.dat"
    * output files:
    Plot = "dot1_50x13_wgt_des.dat"
    Current = "dot1_50x13_wgt_des.plt"
    Output = "dot1_50x13_wgt_des.log"
}

Electrode {
    { Name="anode"  Voltage=0.0 }
    { Name="cathode"  Voltage=0.0 }
    { Name="pixel01"  Voltage=0.0 }
    { Name="pixel02"  Voltage=0.0 }
    { Name="pixel10"  Voltage=0.0 }
    { Name="pixel11"  Voltage=0.0 }
    { Name="pixel12"  Voltage=0.0 }
    { Name="pixel20"  Voltage=0.0 }
    { Name="pixel21"  Voltage=0.0 }
    { Name="pixel22"  Voltage=0.0 }
}

Physics {
    Temperature = 263
}

Plot { ElectrostaticPotential }

Math { Method = pardiso ConstRefPot Iterations = 100 Digits = 4.5 }

Solve { Poisson
    Quasistationary 
    (Goal {Name = "anode" Voltage = 1.} InitialStep = 0.05 Increment = 1.5 Decrement = 1.5) {Poisson}
    Quasistationary 
    (Goal {Name = "anode" Voltage = 1} InitialStep = 0.10 Increment = 1.05 Decrement = 1.05) {Poisson}
    Save (FilePrefix="dot1_50x13_wgt_1")
    Plot (FilePrefix="dot1_50x13_wgt_1")

}
