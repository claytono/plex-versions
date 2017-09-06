# Plex Version Tracker

[![Build Status](https://travis-ci.org/claytononeill/plex-versions.svg?branch=master)](https://travis-ci.org/claytononeill/plex-versions)


## Summary
This project is intended to track the public versions of Plex Media Server and
provide an archive of the version data and URLs for retrieving old releases.

## Why?

Even though I'm a Plex Pass subscriber, I don't always want to run the latest
bleeding edge release, or even the latest public release.  In the past it's
always been difficult to find the URLs for the older versions of Plex Media
Server.  This project is intended to help address that.

## How?
The Plex version manifest is retrieved once a day automatically and the raw
data is stored in the
[`raw/`](https://github.com/claytononeill/plex-versions/tree/master/raw)
directory.  The latest version manifest can always be found at
[`raw/pms-latest.json`](https://github.com/claytononeill/plex-versions/blob/master/raw/pms-latest.json).
Pretty printed versions of the JSON manifests can be found in the
[`pretty/`](https://github.com/claytononeill/plex-versions/tree/master/pretty)
directory and the
[`pretty/pms-latest.json`](https://github.com/claytononeill/plex-versions/blob/master/pretty/pms-latest.json)
file respectively.

## TL; DR
If you don't care how this is implemented, then you probably want to look at
the data in the
[`versions/`](https://github.com/claytononeill/plex-versions/tree/master/versions)
directory  This directory is the result of processing the raw JSON manifest and
producing a YAML file per version per platform.  

For example, if you wanted to see all of the Ubuntu x86_64 versions of Plex
Media Server that have been tracked, then you would look in the
[`versions/ubuntu_x86_64/`](https://github.com/claytononeill/plex-versions/tree/master/versions/ubuntu_x86_64)
directory.



