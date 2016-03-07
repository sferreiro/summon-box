# A Virtual Machine for SUMMON development
(Based on https://github.com/rails/rails-dev-box.git)

## Introduction


## Requirements

* Install Cygwin. Make sure to include OpenSSH client. (It's under Net group)
* [VirtualBox 5.0.14] (may not work on older versions due to a compatibility error with Vagrant) (https://www.virtualbox.org)
* [Vagrant 1.8.1] (http://vagrantup.com)
 

## How To Build The Virtual Machine

Building the virtual machine is this easy:
	
	1. Open a CMD console with Administrative privileges.
    2. $ git clone https://github.com/sferreiro/summon-box.git
    3. $ cd summon-box
    4. $ startup.bat
	5. Enter Guthub username, password and email. 
	
That's it.

After the installation has finished, you can access the virtual machine with

    host $ vagrant ssh
    Welcome to Ubuntu 14.04.2 LTS (GNU/Linux 3.13.0-55-generic x86_64)
    ...
    vagrant@summon-dev-box:~$

The summon projects will be already cloned on /home/summon. That's a synced folder with the correspondent "summon" folder created on the windows host.
	
Port 3000 in the host computer is forwarded to port 3000 in the virtual machine. Thus, applications running in the virtual machine can be accessed via localhost:3000 in the host computer. Be sure the web server is bound to the IP 0.0.0.0, instead of 127.0.0.1, so it can access all interfaces:

## What's In The Box

* Development tools

* Git

* RVM 

* Ruby 1.9.3-p448

* MySQL

* System dependencies for nokogiri, mysql, mysql2

* Solr

* An ExecJS runtime

## Recommended Workflow

The recommended workflow is

* edit in the host computer and

* test within the virtual machine.

## Virtual Machine Management

When done just log out with `^D` and suspend the virtual machine

    host $ vagrant suspend

then, resume to hack again

    host $ vagrant resume

Run

    host $ vagrant halt

to shutdown the virtual machine, and

    host $ vagrant up

to boot it again.

You can find out the state of a virtual machine anytime by invoking

    host $ vagrant status

Finally, to completely wipe the virtual machine from the disk **destroying all its contents**:

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.

## Faster Rails test suites

The default mechanism for sharing folders is convenient and works out the box in
all Vagrant versions, but there are a couple of alternatives that are more
performant.

### rsync

Vagrant 1.5 implements a [sharing mechanism based on rsync](https://www.vagrantup.com/blog/feature-preview-vagrant-1-5-rsync.html)
that dramatically improves read/write because files are actually stored in the
guest. Just throw

    config.vm.synced_folder '.', '/vagrant', type: 'rsync'

to the _Vagrantfile_ and either rsync manually with

    vagrant rsync

or run

    vagrant rsync-auto

for automatic syncs. See the post linked above for details.
