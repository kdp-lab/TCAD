##################################################################################
# Script to export the electric field in the silicon regions of a .TDR field map #
##################################################################################

# Input and output files
set file_0V results/pixel_0V_0000_des.tdr 
set fileId [open "results/ElectricField.txt" "w"]

TdrFileOpen $file_0V

puts -nonewline $fileId "#x y Ex Ey\n"

#Go through all geometries
set nGeom [TdrFileGetNumGeometry $file_0V]
for {set jGeom 0} {$jGeom < $nGeom} {set jGeom [expr {$jGeom + 1}]} {
  set nState [TdrGeometryGetNumState $file_0V $jGeom]
  set nRegion [TdrGeometryGetNumRegion $file_0V $jGeom]

  #Go through all states
  for {set jState 0} {$jState < $nState} {set jState [expr {$jState + 1}]} {
    for {set jRegion 0} {$jRegion < $nRegion} {incr jRegion} {
      set RegionName [TdrRegionGetName $file_0V $jGeom $jRegion]
      set nData [TdrRegionGetNumDataset $file_0V $jGeom $jRegion $jState]

      set materialName [TdrRegionGetMaterial $file_0V $jGeom $jRegion]
      set materialMatch [string match -nocase silicon $materialName]
      if {$materialMatch == 0} {
          continue
      }
      puts "Exports field in $materialName..."

      #Go through all datasets
      for {set jData 0} {$jData < $nData} {set jData [expr {$jData + 1}]} {
        set dataSetName [TdrDatasetGetName $file_0V $jGeom $jRegion $jState $jData]
	 #Change this line to export some other quantity
        set dataMatch [string match -nocase ElectricField $dataSetName] 
        if {$dataMatch == 0} {
          continue
        }

      	set nVal [TdrDatasetGetNumValue $file_0V $jGeom $jRegion $jState $jData]
        for {set jVal 0} {$jVal < $nVal} {set jVal [expr {$jVal + 1}] } {
       	  set EfieldX [list [TdrDataGetComponent $file_0V $jGeom $jRegion $jState $jData $jVal 0]]
          set EfieldY [list [TdrDataGetComponent $file_0V $jGeom $jRegion $jState $jData $jVal 1]]
          set X [list [TdrDataGetCoordinate $file_0V $jGeom $jRegion $jState $jData $jVal 0]]
          set Y [list [TdrDataGetCoordinate $file_0V $jGeom $jRegion $jState $jData $jVal 1]]
	  puts -nonewline $fileId "$X $Y $EfieldX $EfieldY\n"
        }
      }
    }
  }
}

TdrFileClose $file_0V
