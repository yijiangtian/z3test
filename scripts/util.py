import os
import subprocess
import shutil
import config 
import filecmp

def is_windows():
    return os.name == 'nt'

def is_linux():
    return os.name == 'posix' and os.uname()[0] == 'Linux'

def is_freebsd():
    return os.name == 'posix' and os.uname()[0] == 'FreeBSD'

def is_osx():
    return os.name == 'posix' and os.uname()[0] == 'Darwin'

# Goodie for changing the directory
class cd:
    def __init__(self, newPath):
        self.newPath = newPath

    def __enter__(self):
        self.savedPath = os.getcwd()
        os.chdir(self.newPath)

    def __exit__(self, etype, value, traceback):
        os.chdir(self.savedPath)

class setenv:
    def __init__(self, var, val):
        self.var = var
        self.val = val
        self.old_val = None

    def __enter__(self):
        if self.var in os.environ:
            self.old_val = os.environ[self.var]
        os.environ[self.var] = self.val

    def __exit__(self, etype, value, traceback):
        if self.old_val == None:
            os.environ.pop(self.var)
        else:
            os.environ[self.var] = self.old_val

def rmf(path):
    if not os.path.exists(path):
        return # nothing to be done
    if not os.path.isdir(path):
        os.path.remove(path)
    else:
        shutil.rmtree(path)

def mk_dir(d):
    if not os.path.exists(d):
        os.makedirs(d)

def is_z3depot(path):
    """
    Return true if the Z3 main repository is located in the given path. 
    The function checks the existence of several files.
    """
    for f in ["README", "LICENSE.txt", ".git", "RELEASE_NOTES", os.path.join("src", "ast", "ast.cpp")]:
        if not os.path.exists(os.path.join(path, f)):
            return False
    return True

def find_z3depot():
    """
    Try to find the Z3 main repository along the current path.
    The environment variable Z3DIR is also used.
    """
    c = os.getenv("Z3DIR", None)
    if c != None and c != "":
        if is_z3depot(c):
            return c
        else:
            raise Exception("Environment variable Z3DIR does not seem to contain the correct path to the Z3 repository.\nZ3DIR=%s" % c)
    p = os.getcwd()
    if is_z3depot(p):
        return p
    while True:
        new_p, h = os.path.split(p)
        if new_p == p:
            raise Exception("Failed to find path to the Z3 repository, try to set the environment variable Z3DIR")
        c = os.path.join(new_p, 'z3')
        if is_z3depot(c):
            return c
        p = new_p

def gitcheckout(branch):
    if subprocess.call([config.GIT, 'checkout', branch]) != 0:
        raise Exception("Failed to checkout branch '%s' at '%s'" % (branch, os.getcwd()))

def gitpull(branch):
    if subprocess.call([config.GIT, 'pull', '--commit', config.ORIGIN, branch]) != 0:
        raise Exception("Failed to pull latest changes from branch '%s' (from codeplex) at '%s'" % (branch, os.getcwd()))

def get_builddir(branch, debug, clang):
    if clang:
        branch = '%s-clang' % branch
    if debug:
        return os.path.join(config.BUILDDIR, branch, 'debug')
    else:
        return os.path.join(config.BUILDDIR, branch, 'release')

def mk_make(branch, debug, java, clang, static, VS64):
    cmd = ['python', os.path.join('scripts', 'mk_make.py'), '-b', get_builddir(branch, debug, clang) ]
    if debug:
        cmd.append('-d')
    if VS64 and is_windows():
        cmd.append('-x')
    if java:
        cmd.append('--java')
    if static:
        cmd.append('--staticlib')

    if clang:
        with setenv('CXX', 'clang++'):
            with setenv('CC', 'clang'):
                if subprocess.call(cmd) != 0:
                    raise Exception("Failed to execute mk_make\n%s" % cmd)
    else:
        if subprocess.call(cmd) != 0:
            raise Exception("Failed to execute mk_make\n%s" % cmd)
    
def make(branch, debug, everything, clang, jobs):
    bdir = get_builddir(branch, debug, clang)
    with cd(bdir):
        if is_windows():
            cmd = ['nmake']
        else:
            cmd = ['make', '-j', str(jobs)]
        if everything:
            cmd.append('all')
            cmd.append('test')
            cmd.append('examples')
        if subprocess.call(cmd) != 0:
            raise Exception("Failed to make Z3\n%s\n" % cmd)
        

def buildz3(branch="unstable", everything=False, clean=False, debug=True, java=False, clang=False, static=False, VS64=False, jobs=16):
    z3dir = find_z3depot()
    with cd(z3dir):
        gitcheckout(branch)
        gitpull(branch)
        bdir = get_builddir(branch, debug, clang)
        if clean:
            rmf(bdir)
        mk_dir(bdir)
        mk_make(branch, debug, java, clang, static, VS64)
        make(branch, debug, everything, clang, jobs)

def testz3py(branch="unstable", debug=True, clang=False):
    z3dir = find_z3depot()
    bdir = get_builddir(branch, debug, clang)
    p    = os.path.join(z3dir, bdir)
    with cd(p):
        if subprocess.call([config.PYTHON, 'z3test.pyc']) != 0:
            raise Exception("Failed to execute Z3 python regression tests 'z3test.pyc' at '%s'" % p)

def testjavaex(branch="unstable", debug=True, clang=False):
    z3dir = find_z3depot()
    bdir = get_builddir(branch, debug, clang)
    p    = os.path.join(z3dir, bdir)
    with cd(p):
        print p
        if is_windows():
            if subprocess.call([config.JAVA, '-cp', 'com.microsoft.z3.jar;.', 'JavaExample']) != 0:
                raise Exception("Failed to execute Java example at '%s'" % p)
        elif is_osx():
            if subprocess.call([config.JAVA, '-cp', 'com.microsoft.z3.jar:.', 'JavaExample']) != 0:
                raise Exception("Failed to execute Java example at '%s'" % p)            
        elif is_linux() or is_freebsd():
            with setenv('LD_LIBRARY_PATH', '.'):
                if subprocess.call([config.JAVA, '-cp', 'com.microsoft.z3.jar:.', 'JavaExample']) != 0:
                    raise Exception("Failed to execute Java example at '%s'" % p)

def testz3ex(exe, branch="unstable", debug=True, clang=False):
    z3dir = find_z3depot()
    bdir = get_builddir(branch, debug, clang)
    p    = os.path.join(z3dir, bdir)
    with cd(p):
        with setenv('PATH', '.'):
            if is_windows() or is_osx():
                if subprocess.call([exe]) != 0:
                    raise Exception("Failed to execute '%s' at '%s'" % (exe, p))
            elif is_linux() or is_freebsd():
                with setenv('LD_LIBRARY_PATH', '.'):
                    if subprocess.call([exe]) != 0:
                        raise Exception("Failed to execute '%s' at '%s'" % (exe, p))


# The duration is in seconds. It can be a float such as 0.001
def timeout(func, args=(), kwargs={}, timeout_duration=1.0, default=None):
    import threading
    class InterruptableThread(threading.Thread):
        def __init__(self):
            threading.Thread.__init__(self)
            self.result = None

        def run(self):
            try:
                self.result = func(*args, **kwargs)
            except:
                self.result = default

    it = InterruptableThread()
    it.start()
    it.join(timeout_duration)
    if it.isAlive():
        return default
    else:
        return it.result

def test_benchmark(z3exe, benchmark, expected=None):
    if not os.path.exists(benchmark):
        raise Exception("Benchmark '%s' does not exist" % benchmark)
    base, ext = os.path.splitext(benchmark)
    if expected == None:
        expected = '%s.expected.out' % base
    if not os.path.exists(expected):
        raise Exception("Expected answer file '%s' does not exist" % benchmark)
    produced  = '%s.produced.out' % base
    producedf = open(produced, 'w')
    errcode = 0
    try:
        errcode = subprocess.call([z3exe, benchmark], stdout=producedf)
    except:
        raise Exception("Failed to start Z3: %s" % z3exe)
    producedf.close()
    if errcode != 0 and errcode != 1:
        raise Exception("Z3 (%s) returned unexpected error code for %s" % (z3exe, benchmark))
    if not filecmp.cmp(expected, produced):
        print "EXPECTED"
        print open(expected, 'r').read()
        print "======================"
        print "PRODUCED"
        print open(produced, 'r').read()
        print "======================"
        raise Exception("Z3 (%s) produced unexpected output for %s" % (z3exe, benchmark))
    return True

def test_benchmarks(z3exe, benchdir, ext="smt2", timeout_duration=60.0):
    print "Testing benchmarks at", benchdir, "using", z3exe
    error = False
    for benchmark in filter(lambda f: f.endswith(ext), os.listdir(benchdir)):
        try:
            bench = os.path.join(benchdir, benchmark)
            print "Testing", bench
            if timeout(test_benchmark, 
                       args=(z3exe, bench), 
                       timeout_duration=timeout_duration,
                       default=False) == False:
                raise Exception("Timeout executing benchmark %s using %s" % (bench, z3exe))
        except Exception as ex:
            print "Failed"
            print ex
            error = True
    if error:
        raise Exception("Found errors testing benchmarks at %s using %s" % (benchdir, z3exe))

def test_benchmarks_using_latest(benchdir, branch="unstable", debug=True, clang=False, ext="smt2", timeout_duration=60.0):
    z3dir = find_z3depot()
    bdir  = get_builddir(branch, debug, clang)
    z3exe = os.path.join(z3dir, bdir, 'z3')
    test_benchmarks(z3exe, benchdir, ext, timeout_duration)

# buildz3(java=True, everything=True)
# testjavaex()                
# testz3ex('cpp_example', "unstable", True, True)
# testz3ex('c_example')    
# test_benchmarks('/home/leo/projects/z3/build/debug/z3', 'regressions/smt2')
# test_benchmark('/home/leo/projects/z3/build/debug/z3', 'regressions/smt2/bad_patterns.smt2')
# test_benchmarks_using_latest('regressions/smt2')
