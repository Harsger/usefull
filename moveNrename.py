# -*- coding: utf-8 -*-

import sys, getopt
import os
import time
import math
import csv
import time
from array import array
import subprocess

filelist = []

def fillFileList( dirPath , inputfile , specific , exclude ):
    directoryList=os.listdir(dirPath)
    filelist[:]=[]
    for filename in directoryList:
        if( 
            filename.find(str(inputfile)) != -1
            and filename.find(str(specific)) != -1 
            and filename.find(str(exclude)) == -1
        ):
            print( filename )
            filelist.append( filename )

def main(argv):

    usage = 'moveNrename.py -i <inputfile> -d <datapath> -o <outputdir> -p <phrase> -r <replace> -s <specifier> -n <notuse>'

    filename = ''
    inputfile = ''
    datapath = ''
    outputdir = ''
    phrase = 'neverUseThisPhrase'
    replace = ''
    specifier = ''
    notuse = 'neverUseThisPhrase'
    
    try:
        opts, args = getopt.getopt(argv,"hi:d:o:p:r:s:n:",
            [
                "inputfile=",
                "datapath=",
                "outputdir=",
                "phrase=",
                "replace=",
                "specifier=",
                "notuse="
            ]
        )
    except getopt.GetoptError:
        print( str(usage) )
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print usage
            sys.exit()
        elif opt in ("-i", "--inputfile"):
            inputfile = arg
        elif opt in ("-d", "--datapath"):
            datapath = arg
        elif opt in ("-o", "--outputdir"):
            outputdir = arg
        elif opt in ("-p", "--phrase"):
            phrase = arg
        elif opt in ("-r", "--replace"):
            replace = arg
        elif opt in ("-s", "--specifier"):
            specifier = arg
        elif opt in ("-n", "--notuse"):
            notuse = arg
    
    if datapath == '':
        print( str(usage) )
        sys.exit(2)

    if outputdir == '':
        outputdir = datapath
                    
    print " inputfiles    : "+str(inputfile)
    print " datapath      : "+str(datapath)
    print " outputdir     : "+str(outputdir)
    print " phrase        : "+str(phrase)
    print " replace       : "+str(replace)
    print " specifier     : "+str(specifier)
    print " notuse        : "+str(notuse)

    fillFileList( datapath , inputfile , specifier , notuse )

    for filename in filelist:
        outname = filename
        outname = outname.replace(phrase,replace)
        outname = outputdir+"/"+outname
        command = "mv "+str(datapath)+"/"+str(filename)+" "+str(outname)
        print( str(command) )
        os.system( str(command) )

if __name__ == "__main__":
  main(sys.argv[1:])
