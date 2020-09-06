# -*- coding: utf-8 -*-

import sys, getopt
import os
import time
import math
import csv
import time
from array import array
import subprocess

infiles = {}

def fillInputFiles (dirPath,inputfile,specific,exclude):
        InDir=os.listdir(dirPath)
        for filename in InDir:
                if filename.startswith(str(inputfile)) and filename.find(str(specific)) != -1 and filename.find(str(exclude)) == -1:
                        print filename
                        infiles[filename]={}
                        infiles[filename]["name"]=filename
                        infiles[filename]["path"]=dirPath+"/"+filename



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
                opts, args = getopt.getopt(argv,"hi:d:o:p:r:s:n:",["inputfile=","datapath=","outputdir=","phrase=","replace=","specifier=","notuse="])
        except getopt.GetoptError:
                print usage
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
        
#        if inputfile == '':
#                print usage
#                sys.exit(2)
                        
        print " inputfiles    : "+str(inputfile)
        print " datapath      : "+str(datapath)
        print " outputdir     : "+str(outputdir)
        print " phrase        : "+str(phrase)
        print " replace       : "+str(replace)
        print " specifier     : "+str(specifier)
        print " notuse        : "+str(notuse)
  
        fillInputFiles (datapath,inputfile,specifier,notuse)

        for filename in infiles:
                outname = filename
                outname = outname.replace(phrase,replace)
                outname = outputdir+"/"+outname
                print "mv "+infiles[filename]["path"]+" "+outname
                os.system("mv "+infiles[filename]["path"]+" "+outname)

if __name__ == "__main__":
  main(sys.argv[1:])
