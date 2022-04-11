# -*- coding: utf-8 -*-

import sys, getopt, os , copy

filelist = []

def fillFileList( directory , start , end , specific , exclude ) :
    global filelist
    directoryList = os.listdir( directory )
    for filename in directoryList :
        if( 
            filename.startswith( str(start) )
            and filename.endswith( str(end) )
            and     str(specific) in filename 
            and not str(exclude)  in filename
        ) :
            filelist.append( filename )

def main(argv) :

    global filelist
    
    neverUse = 'neverUseThisPhrase'
    
    parameters = {                          
        'filename'    : ''       ,
        'ending'      : ''       ,
        'inpath'      : ''       ,
        'outpath'     : ''       ,
        'phrase'      : neverUse ,
        'replacement' : ''       ,
        'specifier'   : ''       ,
        'notuse'      : neverUse 
    }
    

    shortParametersMap = {}
    shortParametersString = 'h'
    longParametersList = []
    usage = 'python moveNrename.py'
    
    for p , v in parameters.items() :
        shortParametersMap[str(p[0])] = str(p)
        shortParametersString += str(p[0])+':'
        longParametersList.append( str(p)+'=' )
        usage += '\n \t\t -'+str(p[0])+' <'+str(p)+'>'
    
    try :
        opts , args = getopt.getopt( 
                                        argv , 
                                        shortParametersString ,
                                        longParametersList
                                    )
    except getopt.GetoptError :
        print( str(usage) )
        sys.exit(1)
    
    if len(opts) < 1 :
        print( str(usage) )
        sys.exit(2)
    
    for opt , arg in opts :
        if opt in ("-h", "--help") :
            print( str(usage) )
            sys.exit(3)
        shortOption = str( opt.replace( '-' , '' ) )[0]
        if shortOption in shortParametersMap :
            parameters[ shortParametersMap[shortOption] ] = arg
           
    if( parameters['inpath'] == '' ) :
        print(' ERROR : \"inpath\" has to be specified ')
        sys.exit(4)
        
    if not os.path.isdir( parameters['inpath'] ) :
        print(' ERROR : \"inpath\" is no directory ')
        sys.exit(5)
        
    if( 
        parameters['outpath'] != '' 
        and not os.path.isdir( parameters['outpath'] ) 
    ) :
        print(' ERROR : \"outpath\" is no directory ')
        sys.exit(6)
    
    if( 
        parameters['inpath'] == parameters['outpath' ]
        and
        (
            parameters['phrase'] == neverUse
            and
            parameters['replacement'] == ''
        )
    ) :
        print( str(usage) )
        print(' ERROR : different paths and/or \n'+
              '         phrase and replacement have to be specified' )
        sys.exit(7)
    
    fillFileList( 
                    parameters['inpath'   ] , 
                    parameters['filename' ] , 
                    parameters['ending'   ] , 
                    parameters['specifier'] , 
                    parameters['notuse'   ] 
                )
    
    if len(filelist) < 1 :
        print( str(usage) )
        sys.exit(8)
    
    for p , v in parameters.items() :
        print( str(p)+'\t:\t'+str(v) )

    for filename in filelist :
        if( 
            parameters['phrase'] != neverUse
            and
            parameters['phrase'] not in filename 
        ) :
            continue
        inname = copy.deepcopy( filename )
        addition = ''
        if( 
            parameters['inpath'] != ''
            and (
                    parameters['inpath'] == '.'
                    or 
                    not parameters['inpath'].endswith('/')
                )
        ) :
            addition = '/'
        inname = (
                    str(parameters['inpath'])
                    +str(addition)+
                    str(inname)
                )
        outname = copy.deepcopy( filename )
        outname = outname.replace( 
                                        parameters['phrase'     ] , 
                                        parameters['replacement'] 
                                    )
        addition = ''
        if( 
            parameters['outpath'] != ''
            and (
                    parameters['outpath'] == '.'
                    or 
                    not parameters['outpath'].endswith('/')
                )
        ) :
            addition = '/'
        outname = (
                    str(parameters['outpath'])
                    +str(addition)+
                    str(outname)
                )
        command = 'mv '+str(inname)+' '+str(outname)
        print( str(command) )
        os.system( str(command) )

if __name__ == "__main__":
  main(sys.argv[1:])
