import os
 
plugins=[{"name":"supertab", "url":"git://github.com/tsaleh/vim-supertab.git"}]
#https://github.com/kien/ctrlp.vim 
bundle_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'bundle/')
 
print "Removing all current plugins!"
os.system('rm -rf %s*' % bundle_dir)
 
for plugin in plugins:
    print "Downloading %s" % plugin['name']
    os.system("git clone %s %s%s" % ( plugin['url'], bundle_dir, plugin['name'] ) )
 
os.system("rm -rf %s*.git" % bundle_dir)
print "Got all plugins"
