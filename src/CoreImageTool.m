
#import "CommandLineDriver.h"

/*
	CoreImageTool action parameters [action parameters ...]
	CoreImageTool load in.jpeg filter CICrop rectangle:0,0,200,100 filter CIUnsharpMask radius:1.0/intensity:2.0 store out.jpg
	
*/

int main (int argc, const char *argv[]) {
	return [CommandLineDriver runWithArguments:argv count:argc];
}





