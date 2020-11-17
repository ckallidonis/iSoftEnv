import sys
sys.path.append('/m100/home/userexternal/ckallido/software/util/python_modules/lib/python3.6/site-packages')

import git
import optparse
from git import RemoteProgress

class CloneProgress(RemoteProgress):
    def update(self, op_code, cur_count, max_count=None, message=''):
        if message:
            print(message)
#--------------------------------------


# Repository url's
Repos = { 'qmp'               : 'git@github.com:usqcd-software/qmp.git',
          'qdpxx'             : 'git@github.com:usqcd-software/qdpxx.git',
          'tensor'            : 'git@github.com:JeffersonLab/tensor.git',
          'hadron'            : 'git@github.com:JeffersonLab/hadron.git',
          'harom'             : 'git@github.com:JeffersonLab/harom.git',
          'chroma-genprop4'   : 'git@github.com:JeffersonLab/chroma.git'}


# Which repos have submodules
Submodules = { 'qmp'               : False,
               'qdpxx'             : True,
               'tensor'            : False,
               'hadron'            : False,
               'harom'             : True,
               'chroma-genprop4'   : True}


# Branches to checkout
Branches = {'qmp'               : 'devel',
            'qdpxx'             : 'devel',
            'tensor'            : 'master',
            'hadron'            : 'devel',
            'harom'             : 'shmchroma',
            'chroma-genprop4'   : 'shmharom'}


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

        
