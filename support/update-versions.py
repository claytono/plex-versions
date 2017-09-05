#!/usr/bin/env python
"""Read Plex json manifest and produce a file for every version"""

import json
import os.path
import sys
import yaml

def make_name(release):
    """Make human readable short name for release"""

    build_trim = [
        'linux-ubuntu-',
        'linux-synology-',
        'linux-drobo-',
        'linux-seagate-',
        'linux-',
        'freebsd-',
        'seagate-',
    ]
    build = release['build']
    for prefix in build_trim:
        if build.startswith(prefix):
            build = build[len(prefix):]

    if release['distro'] == 'redhat':
        distro = release['label'].split()[0].lower()
    else:
        distro = release['distro']

    name = distro + '_' + build

    if name.startswith('english_windows-'):
        name = 'windows_' + name[16:]
    return name

def process_file(filename):
    """Read the json manifest file and produce an arraye of versions"""

    with open(filename, "r") as json_file:
        data = json.load(json_file)

    downloads = {}
    print "Processing data file " + filename
    for category, platforms  in data.iteritems():
        print ' * ' + category
        for platform, platform_info in platforms.iteritems():
            print '  + ' + platform
            if 'releases' in platform_info:
                for release in platform_info['releases']:
                    name = make_name(release)
                    print '    - ' + name
                    if name in downloads:
                        print "ERROR duplicate release %s found!" % (name)
                        sys.exit(1)

                    info = platform_info.copy()
                    del info['releases']
                    info.update(release)
                    downloads[name] = info
    return downloads

def make_filename(name, release):
    """Return filename and directory for a specific release"""

    path = 'versions/' + name

    return path, path + '/' + release['version'] + '.yaml'

def update_files(releases):
    """Write each release to a specific file unless it already exists"""

    for name, release in releases.iteritems():
        path, filename = make_filename(name, release)
        if os.path.exists(filename):
            print filename + " already exists, skipping"
            continue
        if not os.path.exists(path):
            os.makedirs(path)
        with open(filename, "w") as yamlfile:
            print "writing " + filename
            yaml.safe_dump(release, yamlfile, default_flow_style=False)


def main():
    """Process each file given on command-line"""
    if len(sys.argv) < 2:
        print "Usage: update-versions.py <file> [<file> ...]"

    for arg in sys.argv[1:]:
        releases = process_file(arg)
        update_files(releases)

if __name__ == "__main__":
    main()
