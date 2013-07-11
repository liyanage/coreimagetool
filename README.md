# Introduction

This is a command line front end to Apple’s Core Image framework introduced in Mac OS X 10.4. It makes core image filter processing available to scripting languages like bash or Perl/Python/Ruby/PHP used for command-line or web applications.

You can use CoreImageTool to experiment with Core Image filters, batch-process large amounts of images, or render images dynamically in web applications.

# Installation Instructions

CoreImageTool consists of just one file which you can download here. Store it somewhere on your disk, like /usr/local/bin, and make it executable:

    sudo mkdir -p /usr/local/bin
    sudo curl -o /usr/local/bin/CoreImageTool http://www2.entropy.ch/download/CoreImageTool
    sudo chmod 755 /usr/local/bin/CoreImageTool

Now you can invoke it like this:

    /usr/local/bin/CoreImageTool

# Usage

CoreImageTool takes its instructions as command line arguments, in a form that is different from other command line tools. CoreImageTool commands can get quite long.

The general form of a command is

    /usr/local/bin/CoreImageTool action parameters

I’ll leave off /usr/local/bin from now on.

There can be multiple action/parameters sequences in a command line. The actions are executed in the order in which they appear on the command line. Currently there are three main and two debugging actions:

<dl>
  <dt><code>load</code></dt>
	<dd>Loads an image from a path on disk</dd>

	<dt><code>filter</code></dt>
	<dd>applies a filter to an image</dd>

	<dt><code>store</code></dt>
	<dd>stores a result image to a path on disk</dd>

	<dt><code>version</code></dt>
	<dd>prints the program’s version number</dd>

	<dt><code>verbose</code></dt>
	<dd>prints some diagnostic output</dd>

</dl>

In most cases, you will use one load action, followed by one or more filter actions and finally one store action.

The program can process multiple images in one command, which is why all actions take a key string as their first parameter. The key identifies the image to be loaded, filtered or stored.

## Loading images

Here is a full example of a command:

    CoreImageTool load myimage test.png

This doesn’t really do anything at all. It loads the image file `test.png` and associates it with the key `myimage`.

## Storing images

Let’s store the input image under a different output filename:

    CoreImageTool load myimage test.png store myimage test-out.jpg public.jpeg

This loads the image as before and then stores it as `test-out.jpg`. The store action takes an additional third parameter to control the output image file format, in this case `public.jpeg` for a JPEG file. The parameter is an [Apple Uniform Type Identifier](http://developer.apple.com/macosx/uniformtypeidentifiers.html). You can look up the available types in the [ImageIO documentation](http://developer.apple.com/graphicsimaging/workingwithimageio.html) (Table 3 on that page, not 1).

If the type is `public.jpeg`, there is an optional fourth parameter, the lossy compression quality factor. Enter a floating point value between 0.0, exclusive, (maximum compression) and 1.0 (lossless compression).

The command above should produce a copy of the input image.

Note that you can have multiple store operations for the same image key at various locations in your command line. This is useful if you want to store the results of intermediate image processing steps, for example when scaling down a big image to several smaller sizes. In this case you would interleave scale filter and store actions.

## Filtering images

Now let’s try some filtering, this is where it gets interesting.

    CoreImageTool \ 
    load myimage test.png \ 
    filter myimage CICrop rectangle=10,10,20,20 \ 
    store myimage test-out.jpg public.jpeg

This applies the CICrop filter to the input image using the filter action. This action takes three parameters: The image key identifying the image to be filtered, the name of the filter and the parameters for the filter. There are a few filters which take no parameters, in those cases the filter action only has two parameters.

The available filter names and the parameters required by each filter are documented in the Core Image Filter Reference. The filter names are taken unchanged. The filter parameter names have been shortened a bit for more convenience on the command line, according to this rule:

* Take the filter parameter name from the Apple documentation, for example inputAspectRatio
* Remove the leading “input”, turning “inputAspectRatio” into “AspectRatio”
* Lowercase the first (and only the first) letter, turning “AspectRatio” into “aspectRatio”

The parameter’s value follows after an equal sign. The value’s format depends on the data type, which is given in the documentation:

<dl>
	<dt><code>NSNumber</code></dt>
	<dd>The parameter value consists of a single number, for example <code>aspectRatio=1.25</code></dd>

	<dt><code>CIColor</code></dt>
	<dd>The parameter value consists of four numbers separated by commas, for example <code>color0=1.0,0,0.25,1</code>. The four numbers define the red/green/blue/alpha values, from 0 to 1.</dd>

	<dt><code>CIVector</code></dt>
	<dd>The parameter value consists of one to four numbers separated by commas, for example <code>rectangle=10,10.0,20,20</code>. The meaning of the numbers depends on the filter.</dd>

	<dt><code>NSAffineTransform</code></dt>
	<dd>The parameter value consists of six numbers separated by commas, for example <code>transform=1,0,0,1,0,0</code>. The numbers determine the raw values of a transformation matrix. You can read more about it in Apple’s <a href="http://developer.apple.com/documentation/Cocoa/Conceptual/CocoaDrawingGuide/Transforms/chapter_4_section_3.html#//apple_ref/doc/uid/TP40003290-CH204-BCIIICJI">Cocoa Drawing</a> and <a href="http://developer.apple.com/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_affine/chapter_6_section_7.html">Quartz Drawing</a> documentation.</dd>
	
	<dt><code>CIImage</code></dt>
	<dd>The parameter value is an image key, i.e. it refers to an image previously loaded with the <code>load</code> action, for example <code>backgroundImage=mybgimage</code>. That image can in turn have filters applied to it in the same command, and this is why all actions work with an image key as their first argument.</dd>

</dl>

Many filters take more than one parameter. In those cases, the name=value pairs are separated by a colon:

    transform=1,0,0,1,0,0:rectangle=1.0,2.0,40,40

Here is a longer example using lots of filters:

    CoreImageTool \ 
    load image test2-in.jpg \ 
    filter image CIAffineClamp transform=1,0,0,1,0,0 \ 
    filter image CICrop rectangle=0,0,200,100 \ 
    load bgimg test1-in.jpg \ 
    filter bgimg CIColorInvert \ 
    filter image CIAdditionCompositing backgroundImage=bgimg \ 
    filter image CIUnsharpMask radius=1.0:intensity=2.0 \ 
    store image test2-out1.jpg public.jpeg \ 
    filter image CILanczosScaleTransform scale=0.75:aspectRatio=1 \ 
    filter image CIColorInvert \ 
    filter image CIColorMonochrome color=1,0,0,1:intensity=1 \ 
    store image test2-out2.jpg public.jpeg

Note that the image associated with key bgimg is both the target of a CIColorInvert filter operation as well as a parameter to another image’s CIAdditionCompositing filter operation.

# FAQ

This section list a few frequently asked questions and their answers.

* When I crop and resize an image, sometimes I have a white 1 pixel line on the sides I cropped.

    You are probably getting partially transparent pixels at the edge when you scale and you might need to add a [CIAffineClamp](http://developer.apple.com/DOCUMENTATION/GraphicsImaging/Reference/CoreImageFilterReference/Reference/reference.html#//apple_ref/doc/filter/ci/CIAffineClamp) filter. Dan Wood wrote a very good [explanation and solution](http://gigliwood.com/weblog/Cocoa/Core_Image,_part_2.html) for this issue.

# Additional Information

* You will most likely spend a lot of time reading the [Core Image Filter Reference](http://developer.apple.com/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/uid/TP40004346).
* [Charles Parnot](href="http://cmgm.stanford.edu/~cparnot/xgrid-stanford/) wrote an excellent [introduction with sample images](http://www.macresearch.org/apples_coreimage_power_in_the_terminal) for the MacResearch website.
* Richard York wrote an article about [using CoreImageTool as part of a PHP web application](http://www.deadmarshes.com/Blog/apple/CoreImage.html).
* Another way to explore Core Image interactively is with [F-Script](http://www.fscript.org). Core Image is an example in their [20-minute tutorial](http://www.fscript.org/documentation/LearnFScriptIn20Minutes/index.htm).
* [ImageTricks](http://www.belightsoft.com/products/imagetricks/) by BeLight Software allows you to use CoreImage in a graphical application instead of on the command line. It’s free and it might be useful if you need to experiment with filter settings for an image processing sequence which you later want to automate using CoreImageTool.
