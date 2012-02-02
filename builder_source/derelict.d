module derelict;

import std.stdio : writefln, writeln;
import std.process : shell, ErrnoException;
import std.file : dirEntries, SpanMode;
import std.array : endsWith;
import std.string : format;

// Output confiuration
enum outdir = "../lib/";

version(Windows)
{
    enum prefix = "";
    enum extension = ".lib";
}

// Compiler Configuration
version(DigitalMars)
{
    enum compilerOptions = "dmd -lib -O -release -inline -property -w -wi -I../import -of" ~ outdir;
}
else
{
    static assert(false, "Unknown compiler.");

    // If this isn't here, the compiler complains about an undefined identifier.
    enum compilerOptions = "";
}


// Package names
enum packUtil = "DerelictUtil";
enum packGL3 = "DerelictGL3";
enum packGLFW3 = "DerelictGLFW3";

// Source paths
enum srcDerelict = "../import/derelict/";
enum srcUtil = srcDerelict ~ "util/";
enum srcGL3 = srcDerelict ~ "opengl3/";
enum srcGLFW3 = srcDerelict ~ "glfw3/";

// Map package names to source paths.
string[string] pathMap;

int main(string[] args)
{
    buildDerelict();


    return 0;
}

// Build all of the Derelict libraries.
void buildDerelict()
{
    try
    {
        foreach(key; pathMap.keys)
            buildPackage(key);
    }
    // Eat any ErrnoException. The compiler will print the right thing on a failed build, no need
    // to clutter the output with exception info.
    catch(ErrnoException e) {}
}

void buildPackage(string packageName)
{
    writefln("Building %s\n", packageName);

    // Build up a string of all .d files in the directory that maps to packageName.
    string joined;
    foreach(string s; dirEntries(pathMap[packageName], SpanMode.breadth))
    {
        if(s.endsWith(".d"))
        {
            writeln(s);
            joined ~= " " ~ s;
        }
    }

    string arg = format("%s%s%s%s%s", compilerOptions, prefix, packageName, extension, joined);

    string s = shell(arg);
    writeln(s);
    writeln("Build succeeded.");

}

static this()
{
    // Initializes the source path map.
    pathMap =
    [
        packUtil : srcUtil,
        packGL3 : srcGL3,
        packGLFW3 : srcGLFW3
    ];
}