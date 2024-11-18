# TCAD
Repo for TCAD information and models in KDP Lab


Purpose
The purpose of this document is to outline the work done using Synopsys TCAD suite and associated tools in the work of the SmartPixels collaboration and to provide a first time user a field guide to the software with an eye to future modifications of the simulation parameters/optimization
Scope
This document will cover the function of the tools in the Synopsys TCAD suite used for simulating particle track events through sensor geometry, the interconnections between these tools, and the current status of the project
Introduction
Synopsys TCAD is the Technical Computer Aided Design software developed by Synopsys which is the industry standard for simulating all steps of semiconductor device manufacture and deployment with simulations for construction processes (ion implantation, lithography, etc), modeling, mesh generation, and simulation of irradiation damage and particle interactions. This is used as an in depth validation technique in the Smart Pix collaboration for programs such as PixelAV which are more custom built. Extensive documentation on each module as well as a tutorial for the software suite can be located in the GUI under the buttons in the top right: . It’s recommended that these tutorials be consulted to understand the full capability of the software for both debugging and learning purposes.
Workflow
Workbench
The Sentaurus Workbench is the GUI component of the Synopsys TCAD suite and contains a place for all of the various tools to be implemented in a workflow. It consists of a toolbar at the top, a project list to the left, and the current working project in the main portion of the window. Experiments are conducted by first placing the appropriate tools in the workbench window, editing the appropriate command files to perform the desired steps, and executing the experiment by running the desired nodes of the experiment. Most work for a given experiment can be implemented in the workbench itself without needing to open other tools directly, but in some cases, especially the Sentaurus Structure Editor, it can be immensely helpful to gain one’s bearings through a GUI displaying the geometry of the device in question and to build the device using scheme commands and seeing exactly how they map onto a 3D model of the device in question.
In the case of the Smart Pixels Experiment, we currently are running our experiment in the workflow mode described in the Sentaurus Mesh tutorial, namely starting with our device boundaries as well as meshing/doping commands in the Structure Editor (sde), using the output of sde to as the input to Mesh (snmesh) which in turn produces the input files necessary for the Device Simulator (sdevice) to produce the final simulation. If configured correctly, the steps along the way can be visualized using Sentaurus Visual (svisual) to produce plots and models of the simulation outputs
Structure Editor (sde)
A Note on Graphical Glitches
As of the time of writing, there have been many issues with how to display the GUI of sde with both windows machines remotely as well as locally on the 011 workstation. What has worked for me on windows is to use PuTTY with the appropriate X11 forwarding protocols and using the xming X11 server. This was tested running Windows 11 Version 10.0.22631 Build 22631 as recently as 8/18/2024. On Mac, XQuartz seems to work on the lab’s MacBook Air to run sde without much problem, but I’ve been in touch with Mary Heintz to resolve this problem for local operations.
Sde is a ACIS kernel modeling software which can be used to generate 2D and 3D structures of semiconductor devices using either a CAD style modeling interface which generates a series of “scheme” commands for the file reflecting the inputs, or scheme commands can be input directly to generate structures, mesh definitions, doping profiles and zones such as dopant placements, fine/coarse grained meshing areas, and contact regions.
The current model of the SmartPix sensor simulates out fourth of a pixel sensor, exploiting a two-fold symmetry in the (X-Z and Y-Z VERIFY THIS) planes with the implicit assumption that edge effects are minimal given a particle passing through the center of the bulk and normal to the contact regions. This is done to simplify the simulation and to allow for finer meshing for a given overall sensor geometry. KEEP THIS IN MIND WHEN TESTING DIFFERENT GEOMETRIES THAT DIMENSIONS SCALE MULTIPLICATIVELY AND NOT ADDITIVELY!
The boundaries of the sensor are given by the sdegeo scheme commands which currently are defined in the command file sde_dvs.cmd. This is not a very efficient way to do this, and so once the simulation is fully operational, it’s recommended to define variables for both the boundaries of the whole sensor as well as for the contact regions for easier on the fly/bulk simulation experiments. For more information on how to do this, consult the swb tutorial. 
One quirk of how contacts can be defined is that first a cuboid must be constructed and then its body must be deleted to leave essentially a 2D surface on the intersection of the substrate and the contact cuboids. I don’t know why this is, but it’s handled by the scheme command located under the Defining Contacts comment in sde_dvs.cmd
Analytical Regions define the following:
Dopant
Concentration
Function for how dopant is implanted into its placement (Error Function, Gaussian, Constant, etc.)
Analytical Regions, Meshing Strategies, and the placements of both exist as sdedr: functions with their own syntax which can be found in the sde users guide.
Analytical Regions are placed on the structure by defining a 2D planar region in the coordinate system, usually a rectangle
Meshing strategies will define how fine grained the mesh is in various regions of interest, bulk and p-n junctions. These are similarly placed with cuboids on the structure, but you can get a lot fancier by defining various functions that describe how the mesh should change as a function of x-y-z coordinate.
All of the above parameters can be input as variables in swb
After defining the necessary values of the model, saving the model will generate the following files:
The model geometry in an ACIS format file (.sat) 
The Ref/Eval windows and parameters in a Scheme file (.scm)
The refinement- and doping-related information in a command file (.cmd)
The structure in a TDR boundary file (_bnd.tdr).
Mesh (snmesh)
Snmesh is the intermediate step between sde and sdevice which takes as an input the above .sat files and outputs .tdr. Ensure when used in the workflow described above that the commands are Produced by Previous Tools, as this automatically grabs the .cmd from sde
Device
Used to run the actual simulation environment, parameters all exist in the command file as with sde. Once it can be run successfully we need to define the parameters with variables
Visual
Used to look at plots and information such as meshes, time slices, etc. Can be used to explore outputs from each step, such as .sat, .tdr, and .plt files generated as output files
Procedure
Current Working Model
