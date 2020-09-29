import sys
sys.path.append('/users/kallidoc/software/util/python_modules/lib/python3.6/site-packages')

import git
import optparse
from git import RemoteProgress

class CloneProgress(RemoteProgress):
    def update(self, op_code, cur_count, max_count=None, message=''):
        if message:
            print(message)
#--------------------------------------

# Repository url's
Repos = { 'adat'              : 'git@github.com:JeffersonLab/adat.git',
          'adat-devel-pdf'    : 'git@github.com:JeffersonLab/adat.git',
          'chroma'            : 'git@github.com:JeffersonLab/chroma.git',
          'chroma-jit'        : 'git@github.com:JeffersonLab/chroma.git',
          'colorvec'          : 'git@github.com:JeffersonLab/colorvec.git',
          'colorvec-devel-pdf': 'git@github.com:JeffersonLab/colorvec.git',
          'hadron'            : 'git@github.com:JeffersonLab/hadron.git',
          'harom'             : 'git@github.com:JeffersonLab/harom.git',
          'mg_proto'          : 'git@github.com:JeffersonLab/mg_proto.git',
          'qdp-jit'           : 'git@github.com:JeffersonLab/qdp-jit.git',
          'qdpxx'             : 'git@github.com:usqcd-software/qdpxx.git',
          'qmp'               : 'git@github.com:usqcd-software/qmp.git',
          'qphix'             : 'git@github.com:JeffersonLab/qphix.git',
          'redstar'           : 'git@github.com:JeffersonLab/redstar.git',
          'redstar-devel-pdf' : 'git@github.com:JeffersonLab/redstar.git',
          'tensor'            : 'git@github.com:JeffersonLab/tensor.git'}


# Which repos have submodules
Submodules = { 'adat'              : True,
               'adat-devel-pdf'    : True,
               'chroma'            : True,
               'chroma-jit'        : True,
               'colorvec'          : False,
               'colorvec-devel-pdf': False,
               'hadron'            : False,
               'harom'             : True,
               'mg_proto'          : False,
               'qdp-jit'           : True,
               'qdpxx'             : True,
               'qmp'               : False,
               'qphix'             : False,
               'redstar'           : False,
               'redstar-devel-pdf' : False,
               'tensor'            : False}


# Branches to checkout
Branches = { 'adat'              : 'devel',
             'adat-devel-pdf'    : 'devel-pdf',
             'chroma'            : 'devel',
             'chroma-jit'        : 'devel-jit',
             'colorvec'          : 'devel',
             'colorvec-devel-pdf': 'devel-pdf',
             'hadron'            : 'devel',
             'harom'             : 'devel',
             'mg_proto'          : 'devel',
             'qdp-jit'           : 'devel',
             'qdpxx'             : 'devel',
             'qmp'               : 'devel',
             'qphix'             : 'devel',
             'redstar'           : 'devel',
             'redstar-devel-pdf' : 'devel-pdf',
             'tensor'            : 'master'}


# Parse user-supplied arguments
usage = "usage: %prog [options] "
parser = optparse.OptionParser(usage)

parser.add_option("-d", "--src_directory", type="string", default='',
                  help='Set directory of source files')

parser.add_option("-p", "--program", type="string", default='all',
                  help='Which program to clone, all/<program_name> (default \'all\')')

(options, args) = parser.parse_args()
#--------------------------------------

# Source main directory
src_root_dir=options.src_directory
if src_root_dir == '':
    raise ValueError('--src_directory option must be set')

# Which program(s) to clone
prog_install = options.program
if prog_install == 'all':
    progs_list = Repos.keys()
else:
    if prog_install not in Repos:
        raise ValueError('%s not in supported Repo List'%(prog_install))
    progs_list = [prog_install]
print('Will clone the following programs')
print(progs_list)
#---------------


# Perform cloning
for prog in progs_list:
    repo_dir = src_root_dir + '/' + prog
    print('Cloning %s into %s' % (prog, src_root_dir))
    git.Repo.clone_from(Repos[prog], repo_dir, 
                        branch=Branches[prog], progress=CloneProgress())

    g_repo = git.Repo(repo_dir)
    if Submodules[prog]:
        print('Cloning submodules for %s'%(prog))
        output = g_repo.git.submodule('update', '--init','--recursive')

    print('%s done'%(prog))

        
