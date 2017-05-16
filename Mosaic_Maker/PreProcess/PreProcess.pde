
/*
    * Author :: Aswin Mohan
    * Twitter :: aswinmohanme
    *
    * Preprocess the Images to FInd the Most Predominant Colors for an Image and then Save it
    * Most of the COde is Adapted from https://cate.blog/2013/08/26/extracting-the-dominant-color-from-an-image-in-processing/
    * Without the authors permission , but with gratitude Thanks
*/

import java.util.Date;

// void setup() {
//
//   // Using just the path of this sketch to demonstrate,
//   // but you can list any directory you like.
//   String path = sketchPath();
//
//   println("Listing all filenames in a directory: ");
//   String[] filenames = listFileNames(path);
//   printArray(filenames);
//
//   println("\nListing info about all files in a directory: ");
//   File[] files = listFiles(path);
//   for (int i = 0; i < files.length; i++) {
//     File f = files[i];
//     println("Name: " + f.getName());
//     println("Is directory: " + f.isDirectory());
//     println("Size: " + f.length());
//     String lastModified = new Date(f.lastModified()).toString();
//     println("Last Modified: " + lastModified);
//     println("-----------------------");
//   }
//
//   println("\nListing info about all files in a directory and all subdirectories: ");
//   ArrayList<File> allFiles = listFilesRecursive(path);
//
//   for (File f : allFiles) {
//     println("Name: " + f.getName());
//     println("Full path: " + f.getAbsolutePath());
//     println("Is directory: " + f.isDirectory());
//     println("Size: " + f.length());
//     String lastModified = new Date(f.lastModified()).toString();
//     println("Last Modified: " + lastModified);
//     println("-----------------------");
//   }
//
//   noLoop();
// }

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {
}

// This function returns all the files in a directory as an array of Strings
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>();
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}

import processing.core.PImage;

// Create a Class for the Image and it's attributes
 class ImageColors {
    public String c;
    IntDict colors;

    PImage img;

    // Load the Image
    public ImageColors(PImage image){
        this.colors = new IntDict();
        calculate(image);
    }

    //Calculate the Average Hue , saturation and the brightness of the given Image
    private void calculate(PImage image){
        image.loadPixels();

        for (int i=0; i < image.pixels.length; ++i){
            color pixel = image.pixels[i];
            String keyPixel = String.valueOf(pixel);
            colors.add(keyPixel ,1);
        }

        colors.sortValuesReverse();
        this.c= colors.keyArray()[0];
    }

}

void setup(){
    size(500,500);

    //Load the Files
    File[] files = listFiles(sketchPath("data"));

    String[] values = new String[files.length];

    for (int i=0; i < files.length-1; ++i){
        ImageColors image = new ImageColors(loadImage(files[i].toString()));
        values[i] = files[i].toString() + ' ' + image.c;
    }
    saveStrings("ColorData.txt",values);
}
