#include <stdio.h>
#include <string>

int main(int argc, char *argv[]) 
{
    std::string fileString = "set fo [open \"n";
    fileString.append(argv[2]);
    fileString.append("_Wfield.txt\" \"w\"]\n");
    double w, h;
    int nx = 0; int ny = 0;
    char *s = argv[1]; 
    FILE *fp = fopen("probe_pot.tcl", "w");
    fprintf(fp, fileString.c_str());
    fprintf(fp, "echo \"# x   y   Ex Eu\"\n");

    for (w=0.5; w<5*55.0; w=w+0.5) {
		nx++;
        for (h=0.5; h<200.0; h=h+0.5) {
		if(nx==1){
		 ny++;	
		}
		fprintf(fp, "set pot1 [probe_field -coord {%f %f} -field ElectricField-X -plot Plot_%s %s]\n", w, h, s, s);
		fprintf(fp, "set pot2 [probe_field -coord {%f %f} -field ElectricField-Y -plot Plot_%s %s]\n", w, h, s, s);
		fprintf(fp, "puts $fo \"%3f %3f $pot1 $pot2\"\n", w, h);
        }
    }

    fprintf(fp, "puts $fo \"nx=%d, ny =%d\"\n", nx, ny);
    fprintf(fp, "close $fo\n", nx, ny);
    fprintf(fp, "exit\n", nx, ny);
    fclose(fp);
}

