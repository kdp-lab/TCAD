###########################################################
# Script to calculate and save the weighting field as tdr #
###########################################################

# Input and output files
set file_1V results/pixel_1V_0000_des.tdr 
set file_0V results/pixel_0V_0000_des.tdr 
set outfile results/weightingField.tdr

TdrFileOpen $file_1V
TdrFileOpen $file_0V

#Go through all geometries
set nGeom [TdrFileGetNumGeometry $file_1V]
for {set jGeom 0} {$jGeom < $nGeom} {set jGeom [expr {$jGeom + 1}]} {
  set nState [TdrGeometryGetNumState $file_1V $jGeom]
  set nRegion [TdrGeometryGetNumRegion $file_1V $jGeom]

  #Go through all states
  for {set jState 0} {$jState < $nState} {set jState [expr {$jState + 1}]} {
    for {set jRegion 0} {$jRegion < $nRegion} {incr jRegion} {
      set RegionName [TdrRegionGetName $file_1V $jGeom $jRegion]
      puts "$RegionName done..."
      set nData [TdrRegionGetNumDataset $file_1V $jGeom $jRegion $jState]

      #Go through all datasets
      for {set jData 0} {$jData < $nData} {set jData [expr {$jData + 1}]} {
        set dataSetName [TdrDatasetGetName $file_1V $jGeom $jRegion $jState $jData]
	
	#Only modify the field and the potential
        set dataMatch1 [string match -nocase electrostaticpotential $dataSetName]
        set dataMatch2 [string match -nocase ElectricField $dataSetName]
        if {($dataMatch1 == 0)&&($dataMatch2 == 0)} {
          continue
        }
      	set nVal [TdrDatasetGetNumValue $file_1V $jGeom $jRegion $jState $jData]

        for {set jVal 0} {$jVal < $nVal} {set jVal [expr {$jVal + 1}] } {
          set nrow [TdrDataGetNumRow $file_1V $jGeom $jRegion $jState $jData $jVal]
          set ncol [TdrDataGetNumCol $file_1V $jGeom $jRegion $jState $jData $jVal]

	  #Go through all values 
          for {set i 0} {$i < $nrow} {incr i} {
            for {set j 0} {$j < $ncol} {incr j} {
              set value_1V [TdrDataGetComponent $file_1V $jGeom $jRegion $jState $jData $jVal $i $j]
              set value_0V [TdrDataGetComponent $file_0V $jGeom $jRegion $jState $jData $jVal $i $j]
              set result [expr {$value_1V - $value_0V} ] 
              TdrDataSetComponent $file_1V $jGeom $jRegion $jState $jData $jVal $i $j $result
            }
          }
        }
      }
    }
  }
}

TdrFileSave $file_1V $outfile
TdrFileClose $file_1V
TdrFileClose $file_0V
