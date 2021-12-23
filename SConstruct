

import os
import sys

sys.dont_write_bytecode = True

#-------------------------------------------------------------------------------
#
#    Help info
#
help_info ="""
********************************************************************************     
    Available variants:
    ~~~~~~~~~~~~~~~~~~~
        noc-stream (default)
     
    Usage:
    ~~~~~  
    scons [variant=<[path/]name>] [targets]
"""

Help(help_info)

#-------------------------------------------------------------------------------
#
#    General Settings
#

#-------------------------------------------------------------------------------
#
#    Variant management
#
variant = ARGUMENTS.get('variant', 'noc-stream')

variant_name = variant.split(os.sep)[-1]

print_info('*'*80)
print_info(' '*27 + 'build variant: ' + variant_name)
print_info('*'*80 + '\n')

variant_path = os.path.join('src', 'cfg', variant, variant_name + '.scons')

if not os.path.exists(variant_path):
    print_error('\nError: unsupported variant: ' + variant)
    print(help_info)
    sys.exit(-3)

#-------------------------------------------------------------------------------
#
#    Environment
#
env = import_config('env.yml', os.path.join('src', 'cfg', variant))

envx = Environment() #( tools = {} )

envx['ENV']['PATH']          = os.environ['PATH']
envx['ENV']['CAD']           = os.environ['CAD']
envx['ENV']['DISPLAY']       = os.environ['DISPLAY']
envx['ENV']['HOME']          = os.environ['HOME']
envx['ENV']['XILINXX']       = env.XILINX               
envx['ENV']['MENTOR']        = env.MENTOR               
envx['ENV']['XILINX_VIVADO'] = env.XILINX_VIVADO        
envx['QUESTABIN']            = env.QUESTABIN            
envx['QUESTASIM']            = env.QUESTASIM            
envx['VENDOR_LIB_PATH']      = env.VENDOR_LIB_PATH      
envx['XILINX_VIVADO']        = env.XILINX_VIVADO        


SConscript(variant_path, exports='envx')

#-------------------------------------------------------------------------------

if 'dump' in ARGUMENTS:
    env_key = ARGUMENTS[ 'dump' ]
    if env_key == 'env':
        print( envx.Dump() )
    else:
        print( envx.Dump(key = env_key) )

#-------------------------------------------------------------------------------

